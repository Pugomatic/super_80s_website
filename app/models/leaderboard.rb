class Leaderboard < ApplicationRecord
  has_many  :leaderboard_players
  has_many  :players, through: :leaderboard_players
  has_many  :leaderboard_entries

  attr_accessor :leaders

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
