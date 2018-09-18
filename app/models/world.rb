class World < ApplicationRecord
  has_many  :levels

  def name
    case year
    when '1980'
      return 'TOYS'
    when '1981'
      return 'ARCADIA'
    when '1982'
      return 'MIAMI'
    when '1983'
      return 'STREETZ'
    when '1984'
      return 'HORROR'
    end

    raise "WHAT YEAR IS IT?"
  end
end
