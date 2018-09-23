module PlayerLeaderboards
  extend ActiveSupport::Concern

  included do
    belongs_to :player

    before_save       :set_totals
  end

  class_methods do
    def high_scores
      leaderboard('high_score')
    end

    def fast_times
      leaderboard('fastest_time', :asc)
    end

    def max_collected
      leaderboard('max_items_collected')
    end

    def max_kills
      leaderboard('max_kills')
    end

    def most_played
      leaderboard('plays')
    end

    def hardest
      leaderboard('tries')
    end
  end

  def handle
    player.email.split('@').first[0..12]
  end

  def add!(leaderboard)
    self.fastest_time += leaderboard.fastest_time
    self.high_score += leaderboard.high_score
    self.plays += leaderboard.plays
    self.wins += leaderboard.wins
    self.max_kills += leaderboard.max_kills
    self.max_items_collected += leaderboard.max_items_collected
    self.max_cassettes_collected += leaderboard.max_cassettes_collected
    self.max_vhs_tapes_collected += leaderboard.max_vhs_tapes_collected
    self.max_cartridges_collected += leaderboard.max_cartridges_collected
    self.gold_cassettes_collected += leaderboard.gold_cassettes_collected
    self.gold_vhs_tapes_collected += leaderboard.gold_vhs_tapes_collected
    self.gold_cartridges_collected += leaderboard.gold_cartridges_collected
    save
  end

  def set_totals
    self.gold_collected = gold_cartridges_collected + gold_cassettes_collected + gold_vhs_tapes_collected
  end
end
