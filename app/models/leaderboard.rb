class Leaderboard < ApplicationRecord
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
    if level_id
      "#{world.year}.#{level.month}"
    elsif world_id
      world.year
    else
      nil
    end
  end

  def live_entries
    case metric
    when 'high_score'
      if level_id
        PlayerLevel.where(level_id: level_id).order("#{metric} DESC")
      elsif world_id
        PlayerLevel.joins(:level, :player).where('levels.world_id = ?', world_id).group('players.handle').order('sum_high_score desc').sum(:high_score).map {|k, v| {player: k, score: v}}
      else
        PlayerLevel.joins(:level, :player).group('players.handle').order('sum_high_score desc').sum(:high_score).map {|k, v| {player: k, score: v}}
      end
    else
      []
    end
  end

  def leader_level
    if direct
      if summed_up?
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
