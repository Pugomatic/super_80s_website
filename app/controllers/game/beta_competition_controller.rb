module Game
  class BetaCompetitionController < BaseController
    layout  'game'

    before_action   :set_paths

    def index
      @selected = :leaderboard

      @dont_show_nav = true
    end
  end
end
