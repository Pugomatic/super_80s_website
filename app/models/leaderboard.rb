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
    options[:sort] = 'score' unless %w(score time).include? options[:sort]

    case metric
    when 'high_score'
      return  PlayerLevel.where(level_id: level_id).order("#{metric} DESC") if level_id

      top = ""
      list = []

      if world_id
        top = Level.where(world_id: world_id).order(number: :desc).first.id.to_s
        list = PlayerLevel.joins(:level, :player).where('levels.world_id = ?', world_id).where('fastest_time > 0 AND high_score > 0 AND players.handle IS NOT NULL').group('playa').pluck('SUM("player_levels"."high_score") as sum_high_score, SUM("player_levels"."fastest_time"), CONCAT(players.handle, \'*#@)\', players.top_completed_level_id) as playa')
      else
        top = Level.order(number: :desc).first.id.to_s
        list = PlayerLevel.joins(:level, :player).where('fastest_time > 0 AND high_score > 0 AND players.handle IS NOT NULL').group('playa').pluck('SUM("player_levels"."high_score") as sum_high_score, SUM("player_levels"."fastest_time"), CONCAT(players.handle, \'*#@)\', players.top_completed_level_id) as playa')
      end

      list.map! do |a|
        playa, top_id = a[2].split("*#@)")
        {player: playa, score: a[0], time: top == top_id ? a[1] / 1000.0 : nil }
      end

      if options[:sort] == 'time'
        list.reject {|i| i[:time] == nil }.sort {|a, b| a[:time] <=> b[:time] }
      else
        list.sort {|a, b| a[:score] <=> b[:score] }.reverse
      end
    else
      []
    end
  end

  def leader_level
    if direct
      if summed_up? || live_entries.is_a?(Array)
        "5"
      else
        live_entries.limit(1).first&.player_level
      end
    else
      entries.first.player.player_level
    end
  end

  def leader
    if direct
      if summed_up? || live_entries.is_a?(Array)
        live_entries.first && live_entries.first[:player]
      else
        live_entries.limit(1).first&.player&.handle
      end
    elsif entries.blank?
      ""
    else
      entries.reject {|e| e.level_id == nil }.first&.player&.handle
    end
  end

  def player_count
    if direct
      live_entries.count
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
