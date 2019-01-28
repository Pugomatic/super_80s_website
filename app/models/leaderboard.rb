class Leaderboard < ApplicationRecord
  belongs_to  :level
  belongs_to  :world

  has_many  :leaderboard_players
  has_many  :players, through: :leaderboard_players
  has_many  :leaderboard_entries

  attr_accessor :leaders

  def summed_up?
    stat == 'game_score' || level_id.nil? && world_id
  end

  def name_length
    name.length > 27 ? 27 : name.length
  end

  def empty?
    if direct
      player_count
    else
      entries.count == 0
    end
  end

  def display_time
    if level
      "#{level.world.year}.#{level.month}"
    elsif world
      world.year
    else
      nil
    end
  end

  def live_entries(options = {sort: 'score'})
    top = 0
    list = []

    plucky = 'SUM("player_levels"."high_score") as sum_high_score, SUM("player_levels"."fastest_time"), CONCAT(players.handle, \'*#@)\', players.id, \'*#@)\', players.player_level, \'*#@)\', players.top_completed_level_id) as playa'

    if level_id
      ordering = "high_score DESC, fastest_time ASC"

      if options[:sort] == 'time'
        if timeframe == 'minigame'
          ordering = "fastest_time DESC, high_score DESC"
        else
          ordering = "fastest_time ASC, high_score DESC"
        end
      end

      list = PlayerLevel.joins(:player).where(level_id: level_id).where('high_score > 0').order(ordering).map do |r|
        {player: r.player.handle, player_id: r.player.id, player_level: r.player.player_level, score: r.high_score, time: r.fastest_time.nil? ? 0.0 : r.fastest_time / 1000.0 }
      end

    elsif world_id
      top = Level.where(world_id: world_id).order(number: :desc).first.number
      list = PlayerLevel.joins(:level, :player).where('levels.world_id = ?', world_id).where('fastest_time > 0 AND high_score > 0 AND players.handle IS NOT NULL').group('playa').pluck(plucky)
    else
      top = Level.order(number: :desc).first.number
      list = PlayerLevel.joins(:level, :player).where('fastest_time > 0 AND high_score > 0 AND players.handle IS NOT NULL').group('playa').pluck(plucky)
    end

    if timeframe == 'world' || timeframe == 'game'
      list.map! do |a|
        playa, player_id, player_level, player_top = a[2].split("*#@)")
        player_top = player_top.nil? ? 0 : Level.find(player_top).number
        puts player_top
        {player: playa, player_id: player_id, player_level: player_level, score: a[0], time: player_top >= top ? a[1] / 1000.0 : nil }
      end

      if options[:sort] == 'time'
        list = list.reject {|i| i[:time] == nil }.sort {|a, b| a[:time] <=> b[:time] }
      else
        list = list.sort {|a, b| a[:score] <=> b[:score] }.reverse
      end
    end

    unless list.empty?
      if options[:sort] == 'time'
        if list.first[:player] != top_time_name
          update_attributes player_count: list.count, top_time_name: list.first[:player], top_time: list.first[:score], top_time_level: list.first[:player_level]
        end
      elsif list.first[:player] != top_score_name
        update_attributes player_count: list.count, top_score_name: list.first[:player], top_score: list.first[:score], top_score_level: list.first[:player_level]
      end
    end

    list
  end

  def leader_level
    if direct
      top_score_level
    else
      entries.first.player.player_level
    end
  end

  def leader
    if direct
      top_score_name
    elsif entries.blank?
      ""
    else
      entries.reject {|e| e.level_id == nil }.first&.player&.handle
    end
  end

  def player_count
    if direct
      read_attribute(:player_count)
    else
      leaderboard_entries.count
    end
  end

  def display_stat
    "SCORE"
  end

  def status
    if locked?
      "done"
    elsif closed?
      "closed"
    else
      "open"
    end
  end

  def join!(player)
    if open?
      transaction do
        LeaderboardPlayer.create(leaderboard: self, player: player)
        LeaderboardEntry.create(leaderboard: self, player: player)
        player.reset!
      end
    end
  end

  def open?
    !closed? && !locked?
  end

  def joiners
    joiner_tables.split.map do |tbl|
      self.class.sanitize_sql(tbl)
    end
  end

  def entries
    return [] if leaderboard_entries.count == 0

    leaderboard_entries.includes(joiners).where('players.leader = ?', true).order(self.class.sanitize_sql_for_order(sorting))
  end

  def update_entries!
    players.each do |player|
      update_entry! player
    end
  end

  def update_entry!(player)
    entry = leaderboard_entries.find_by(player_id: player.id) || leaderboard_entries.build(player_id: player.id)

    if timeframe == 'game'
      if metric == 'high_score' # total, high_score
        entry.value = player.player_total.high_score
        entry.level = player.top_completed_level
      end
    end

    entry.save
  end

  def leaders
    if stat == 'level_score'
      players.top_level_board.to_a
    end
  end
end
