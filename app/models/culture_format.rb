class CultureFormat < ActiveRecord::Base
  has_many  :culture_items

  validates :name, presence: true

  def self.get(type)
    if type == :vhs
      find_by(name: 'VHS')
    elsif type == :cassette
      find_by(name: 'Cassette')
    elsif type == :cartridge
      find_by(name: 'Cartridge')
    else
      find_by(name: type)
    end
  end
end
