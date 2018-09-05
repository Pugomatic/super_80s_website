class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         omniauth_providers: [:facebook]

  belongs_to :current_level, class_name: Level
  belongs_to :top_completed_level, class_name: Level

  has_many  :player_items
  has_many  :culture_items, through: :player_items
  has_many  :player_achievements
  has_many  :achievements, through: :player_achievements
  has_many  :player_levels


  def self.from_game(all_params)
    fb_data = JSON.parse(all_params[:fb_data])

    player = find_by(email: fb_data['email'], uid: fb_data['id']) || new(pending: true)
    player.pending = false if player.persisted?
    player.player_level = all_params[:player_level]
    player.top_completed_level = Level.find_by(number: all_params[:top_completed_level_number])
    player.uid = fb_data['id'] if player.uid.blank?
    player.name = fb_data['name'] if player.name.blank?
    player.email = fb_data['email'] if player.email.blank?
    player.fb_data = fb_data if player.fb_data.blank?
    player.image = fb_data['picture'] && fb_data['picture']['data'] && fb_data['picture']['data']['url'] if player.image.blank?
    player.skills = all_params[:abilities].select {|k,v| v == "1"}.keys.join(",")
    player.save(validate: false)

    CultureItem.select(:id).where(uid: all_params[:collected_items].split(',')).each do |item|
      item.player_items.create player: player
    end

    Achievement.select(:id).where(sort_name: all_params[:achievements].split(',')).each do |a|
      a.player_achievements.create player: player
    end

    all_params[:levels].each do |number, data|
      pl =  player.player_levels.includes(:level).find_by('levels.number' => number) || player.player_levels.build(level: Level.find_by(number: number))
      if data[:status] == "completed"
        pl.fastest_time = (data[:fastest_time].to_f * 1000).round
        pl.high_score = data[:high_score]
        pl.plays = data[:plays]
        pl.wins = data[:wins]
        pl.status = data[:status]
        pl.max_kills = data[:max_kills]
        pl.max_items_collected = data[:max_items_collected]
        pl.max_cassettes_collected = data[:max_cassettes_collected]
        pl.max_vhs_tapes_collected = data[:max_vhs_tapes_collected]
        pl.max_cartridges_collected = data[:max_cartridges_collected]
        pl.gold_cassettes_collected = data[:gold_cassettes_collected]
        pl.gold_vhs_tapes_collected = data[:gold_vhs_tapes_collected]
        pl.gold_cartridges_collected = data[:gold_cartridges_collected]
      else
        pl.status = data[:status]
      end

      pl.save
    end
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

    player = find_by(uid: auth.uid, email: auth.info.email) || new
    player.attributes = {uid: auth.uid, email: auth.info.email, provider: auth.provider, password: Devise.friendly_token[0,20], name: auth.info.name, image: player.image ? player.image : auth.info.image, pending: false}
    player.save!
    player
  end

  def abilities
    skills.blank? ? [] : skills.split(",")
  end
end
