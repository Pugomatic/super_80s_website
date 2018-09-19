class NewAchievements < ActiveRecord::Migration[5.2]
  def change
    Achievement.create! name: "B-Movie Buff",
                        sort_name: 'b_movie',
                        description: "Groovy! You've got a sweet collection of B-Movies!",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Animaniac",
                        sort_name: 'animaniac',
                        description: "You're a maniac... Ani-maniac!",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5
  end
end
