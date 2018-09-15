class BetaTester < ApplicationRecord
  validates   :email, presence: true, uniqueness: true
end
