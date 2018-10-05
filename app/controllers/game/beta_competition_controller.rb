module Game
  class BetaCompetitionController < BaseController
    layout  'game'

    before_action   :set_paths

    def index
      @selected = :leaderboard

      @top_level_board = Player.top_level_board

      @dont_show_nav = true unless current_player
    end
  end
end
