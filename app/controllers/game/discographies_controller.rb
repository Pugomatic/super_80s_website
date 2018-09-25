module Game
  class DiscographiesController < BaseController
    before_action   :set_player, only: [:index]
    before_action   :set_paths

    def index
      @selected = :disco
      @media = params[:media] ? params[:media].to_sym : :cassette
      if params[:year].blank? || params[:year] == "ALL"
        @years = %w(1980 1981 1982 1983 1984)
      else
        @years = [params[:year]]
      end

      if @media == :cartridge
        @fonts = {
            'favorite' => '#fa57e1',
            'blue' => '#ffff00',
            'dcddcb' => '#dcddcb',
            'purple' => '#ff3ae4',
            'green' => '#c0a614',
            'red' => '#dce840',
            'cyan' => '#119',
            'gold' => '#D4AF37',
            'orange' => '#ffffff',
            'blue2' => '#ff8800',
            'grey' => '#fff'
        }
      else
        @fonts = {
            nil => '#0e0616',
            '' => '#0e0616',
            'favorite' => '#fa57e1',
            'gold' => '#0e0616',
            'blue' => '#ebe3e3',
            'blue2' => '#f1ff99',
            'purple' => '#f1ff99',
            'grey' => '#ebe3e3',
            'black' => '#0e0616',
            'red' => '#dce840',
            'white' => '#0e0616'
        }
      end

      @items = CultureItem.load(@player, @media, @years)
    end
  end
end