class Leaderboard < ApplicationRecord
  has_many  :leaderboard_players
  has_many  :players, through: :leaderboard_players
  has_many  :leaderboard_entries

  attr_accessor :leaders

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
    leaderboard_entries.includes(joiners).where('players.leader = ? AND level_id IS NOT NULL', true).order(self.class.sanitize_sql_for_order(sorting)).to_a + leaderboard_entries.includes(joiners).where('players.leader = ? AND level_id IS NULL', true).to_a
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
