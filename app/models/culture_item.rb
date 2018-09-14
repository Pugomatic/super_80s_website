class CultureItem < ActiveRecord::Base
  strip_attributes

  belongs_to  :culture_format
  belongs_to  :world

  has_many    :achievement_items
  has_many    :achievements, through: :achievement_items
  has_many    :player_items
  has_many    :players, through: :player_items

  validates  :uid, presence: true, uniqueness: true
  validates  :funny_title, presence: true
  validates  :title, presence: true
  validates  :culture_format_id, presence: true
  validates  :world_id, presence: true

  def self.load(player, type, years, limit = nil)
    player.culture_items.includes(:world, :culture_format).where('worlds.year' => years, 'culture_format' => CultureFormat.get(type)).order(funny_title: :asc)
  end

  def self.cassettes
    where(culture_format: CultureFormat.get(:cassette))
  end

  def self.cartridges
    where(culture_format: CultureFormat.get(:cartridge))
  end

  def self.vhs_tapes
    where(culture_format: CultureFormat.get(:vhs))
  end

  def format
    culture_format
  end

  def media
    culture_format.name.underscore
  end

  def format=(cf)
    self.culture_format = cf;
  end

  def self.import(file)
    formats = {}
    worlds = {}

    %w(VHS Cassette Cartridge).each do |format|
      formats[format] = CultureFormat.find_by(name: format)
    end
    %w(1980 1981 1982 1983 1984).each do |year|
      worlds[year] = World.find_by(year: year)
    end

    transaction do
      CultureItem.destroy_all
      AchievementItem.destroy_all
      Level.update_all gold_cartridges: 0, gold_cassettes: 0, gold_vhs_tapes: 0

      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        item = new #find_by(id: row["id"]) || new
        if row['good']
          parameters = ActionController::Parameters.new(row.to_hash)
          if %w(1980 1981 1982 1983 1984).include?(parameters[:year].to_s)

            item.attributes = parameters.permit(:title, :artist, :director, :actors, :tags, :funny_title, :level_number, :dans_commentary, :color, :uid)
            item.required = !parameters[:required].blank?
            item.title.try :strip!
            item.director.try :strip!
            item.actors.try :strip!
            item.artist.try :strip!
            item.funny_title.try :strip!
            item.tags.try :strip!
            item.dans_commentary.try :strip!
            item.color.try :strip!
            item.format = formats[parameters[:format]]
            item.world = worlds[parameters[:year].to_s]
            item.uid.try :strip!

            item.save || raise(item.errors.full_messages.inspect)

            if item.required?
              level = Level.find_by(number: item.level_number)
              if !level
                raise item.inspect
              end

              case item.format
              when formats['Cassette']
                level.gold_cassettes += 1;

              when formats['VHS']
                level.gold_vhs_tapes += 1;

              when formats['Cartridge']
                level.gold_cartridges += 1;
              end

              level.save!
            end

            %w(achievement_1 achievement_2 achievement_3 achievement_4).each do |a|
              unless parameters[a].blank?
                if achievement = Achievement.find_by(name: parameters[a])
                  AchievementItem.create! achievement: achievement, culture_item_id: item.id
                end
              end
            end
          end
        end
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then  Roo::Csv.new(file.path)
    when ".xls" then  Roo::Excel.new(file.path)
    when ".xlsx" then  Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.year(yr)
    joins(:world).where('worlds.year' => "19#{yr}")
  end

  def self.movies
    where(culture_format: CultureFormat.find_by(name: 'VHS'))
  end

  def self.music
    where(culture_format: CultureFormat.find_by(name: 'Cassette'))
  end

  def self.reqd
    where(required: true)
  end

  def self.games
    where(culture_format: CultureFormat.find_by(name: 'Cartridge'))
  end

  def self.stats
    details = ""
    details << "\t\t1980\t\t1981\t\t1982\t\t1983\t\t1984\t\tTotal\n"
    details << "VHS\t\t#{year("80").movies.count} (#{year("80").movies.reqd.count})\t#{year("81").movies.count} (#{year("81").movies.reqd.count})\t\t#{year("82").movies.count} (#{year("82").movies.reqd.count})\t#{year("83").movies.count} (#{year("83").movies.reqd.count})\t#{year("84").movies.count} (#{year("84").movies.reqd.count})\t#{movies.count}\n"
    details << "Cassette\t#{year("80").music.count} (#{year("80").music.reqd.count})\t\t#{year("81").music.count} (#{year("81").music.reqd.count})\t\t#{year("82").music.count} (#{year("82").music.reqd.count})\t\t#{year("83").music.count} (#{year("83").music.reqd.count})\t\t#{year("84").music.count} (#{year("84").music.reqd.count})\t\t#{music.count}\n"
    details << "Cartridge\t#{year("80").games.count} (#{year("80").games.reqd.count})\t\t#{year("81").games.count} (#{year("81").games.reqd.count})\t\t#{year("82").games.count} (#{year("82").games.reqd.count})\t\t#{year("83").games.count} (#{year("83").games.reqd.count})\t\t#{year("84").games.count} (#{year("84").games.reqd.count})\t\t#{games.count}\n"
    details << "Total\t\t#{year("80").count}\t\t#{year("81").count}\t\t#{year("82").count}\t\t#{year("83").count}\t\t#{year("84").count}\n"

    details << "Total Items = #{count}\t\tTotal Achievements = #{Achievement.count}"

    puts details
  end
end
