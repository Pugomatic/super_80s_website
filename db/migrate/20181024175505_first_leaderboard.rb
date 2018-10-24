class FirstLeaderboard < ActiveRecord::Migration[5.2]
  def change
    lb = Leaderboard.create! name: 'First Beta Competition', stat: 'level_score', label: 'first_beta'

    %w(linus_raaen thuber420 chesley88 fikolimino jwyngarden nicholas.oel cmscrew973 auto88966493 olafurkiljan joke.verpoor malachi.seab TheCobra Hiroki YOMI sasmerca confused507 ahsoaka221 tayas38 Dmarbon hepsychan crcs3534 slim_gutta me Phoenix dark Comic dan.camaro ejblood auto59008493 SaveFerris shivangi bwicked420 dandan69211 allancrocker raulrea1973 mkizziah732 Onypsis bailey.richa jolly1111  auto74034593 auto94231693 auto87013783 cousineaucha Zorqz kirtsilver rex.manning. auto34455493 satishpill ianjgardom maxscarrow travisdickin kdhirten chrisesko VANEE astronomicon atomiccreepe gailkeech).each do |handle|
      lb.leaderboard_players.create player: Player.find_by(handle: handle)
    end
  end
end
