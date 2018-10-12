module Game
  class BetaCompetitionController < BaseController
    layout  'game'

    before_action   :set_paths

    def index
      @selected = :leaderboard

      @dont_show_nav = true unless current_player
    end
  end
end
