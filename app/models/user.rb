class User < ActiveRecord::Base
  #has_referer_tracking
  strip_attributes

  default_scope -> { order('created_at desc') }

  validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
end
