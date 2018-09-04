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
