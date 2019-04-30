class Site < ApplicationRecord
  validates :domain, presence: true
  validates :name, presence: true
end
