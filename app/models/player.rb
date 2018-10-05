class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         omniauth_providers: [:facebook]

  belongs_to :top_completed_level, class_name: 'Level'

  has_many  :player_items, dependent: :destroy
  has_many  :culture_items, through: :player_items
  has_many  :player_achievements, dependent: :destroy
  has_many  :achievements, through: :player_achievements
  has_many  :player_levels, dependent: :destroy
  has_many  :player_worlds, dependent: :destroy
  has_one   :player_total, dependent: :destroy

  attr_accessor :world_statuses

  before_create :set_handle
  before_save   :remove_bad_language
  after_create  :create_player_totals

  def self.public(current)
    where('public = ? OR id = ?', true, current&.id)
  end

  def self.get(id_or_handle)
    find_by(id: id_or_handle) || find_by(handle: id_or_handle) || nil
  end

  def player_level_display
    "level #{player_level || 0} #{player_level_display_name ? "(#{player_level_display_name})" : ''}"
  end

  def player_level_display_name
    case player_level
    when 1
      'The New Kid'
    when 2
      'Tragically Unhip'
    when 3
      'The Follower'
    when 4
      'The Trendsetter'
    when 5
      'Members Only'
    when 6
      'The New Style'
    when 7
      'The Style Counselor'
    when 8
      'Top Dog'
    when 9
      'Neon Jesus'
    else
      nil
    end
  end

  def self.top_level_board
    Player.includes(top_completed_level: :player_levels).where('players.id = player_levels.player_id AND player_levels.level_id = players.top_completed_level_id AND players.leader = ?', true).order('levels.number DESC, player_levels.high_score DESC')
  end

  def self.from_game(all_params)
    raise "No fbdata" unless all_params[:fb_data]
    fb_data = JSON.parse(all_params[:fb_data])

    fakemail = "auto#{Time.now.to_i.to_s.reverse}@noemail.com"

    player = find_by(uid: fb_data['id']) || new(pending: true)
    player.world_statuses = {}
    World.pluck(:id).each {|id| player.world_statuses[id] = 'destroyed' }

    transaction do
      player.pending = false if player.persisted?
      player.player_level = all_params[:player_level]
      player.top_completed_level = Level.find_by(number: all_params[:top_completed_level_number])
      player.uid = fb_data['id'] if player.uid.blank?
      player.name = fb_data['name'] if player.name.blank?
      player.email = fb_data['email'] if player.email.blank?
      player.email = fakemail if player.email.blank? && fb_data['email'].blank?
      player.fb_data = fb_data if player.fb_data.blank?
      player.image = fb_data['picture'] && fb_data['picture']['data'] && fb_data['picture']['data']['url'] if player.image.blank?
      player.skills = all_params[:abilities].select {|k,v| v == "1"}.keys.join(",")
      player.save(validate: false)

      player.update_data! all_params
    end

    player.set_world_statuses!
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    player = find_by(provider: auth.provider, uid: auth.uid)
    return player if player

    fakemail = "auto#{Time.now.to_i.to_s.reverse}@noemail.com"

    player = find_by(uid: auth.uid) || new
    player.attributes = {uid: auth.uid, email: auth.info.email || fakemail, provider: auth.provider, password: Devise.friendly_token[0,20], name: auth.info.name, image: player.image ? player.image : auth.info.image, pending: false}
    player.save!
    player
  end

  def favorites
    player_items.includes(:culture_item).where(favorite: true)
  end

  def update_from_game!(all_params)
    @world_statuses = {}
    World.pluck(:id).each {|id| @world_statuses[id] = 'destroyed' }

    transaction do
      self.player_level = all_params[:player_level]
      self.top_completed_level = Level.find_by(number: all_params[:top_completed_level_number])
      self.skills = all_params[:abilities].select {|k,v| v == "1"}.keys.join(",")
      save(validate: false)

      update_data!(all_params)
    end

    set_world_statuses!
  end

  def abilities
    skills.blank? ? [] : skills.split(",")
  end

  def update_data!(all_params)
    set_culture_items!(all_params[:collected_items]) unless all_params[:collected_items].blank?
    set_achievements!(all_params[:achievements]) unless all_params[:achievements].blank?

    if player_worlds
      player_worlds.destroy_all
    end

    world_statuses.keys.each do |wid|
      player_worlds.create(world_id: wid)
    end

    calculate_world_statuses! all_params[:levels]
  end

  def set_world_statuses!
    world_statuses.each do |wid, status|
      rescued = achievements.find_by(sort_name: "rescued_#{World.find(wid).year}")

      player_worlds.find_by(world_id: wid).update_attribute(:status, rescued ? "rescued" : status)
    end
  end

  def display_class(current)
    if internal
      "internal"
    elsif current == self
      "me"
    else
      ""
    end
  end

  private

  def remove_bad_language
    hate_filter = LanguageFilter::Filter.new matchlist: :hate, replacement: :garbled
    profanity_filter = LanguageFilter::Filter.new matchlist: :profanity, replacement: :garbled
    sex_filter = LanguageFilter::Filter.new matchlist: :sex, replacement: :garbled

    self.name = hate_filter.sanitize(name)
    self.handle = hate_filter.sanitize(handle)
    self.tagline = hate_filter.sanitize(tagline)

    self.name = profanity_filter.sanitize(name)
    self.handle = profanity_filter.sanitize(handle)
    self.tagline = profanity_filter.sanitize(tagline)

    self.name = sex_filter.sanitize(name)
    self.handle = sex_filter.sanitize(handle)
    self.tagline = sex_filter.sanitize(tagline)
  end

  def set_handle
    self.handle = email.split('@').first[0, 12]
  end

  def create_player_totals
    create_player_total
  end

  def calculate_world_statuses!(level_data)
    player_total.clear!

    level_data.each do |number, data|
      pl =  player_levels.includes(:level).find_by('levels.number' => number) || player_levels.build(level: Level.find_by(number: number))
      if data[:status] == "completed"
        pl.set(data)

        world = player_worlds.find_by(world_id: pl.level.world_id) rescue raise(pl.inspect)

        world.add!(pl)
        if %w(current destroyed).include? world_statuses[pl.level.world_id]
          if (pl.level.month == 8)
            world_statuses[pl.level.world_id] = 'finished'
          else
            world_statuses[pl.level.world_id] = 'current'
          end
        end
        player_total.add!(pl)
      else
        pl.status = data[:status]
      end

      pl.save
    end
  end

  def set_achievements!(data)
    Achievement.select(:id).where(sort_name: data.split(',')).each do |a|
      a.player_achievements.create player: self
    end
  end

  def set_culture_items!(collected_items)
    CultureItem.select(:id).where(uid: collected_items.split(',')).each do |item|
      item.player_items.create player: self
    end
  end
end
