class AddPlayerTables < ActiveRecord::Migration
  def change
    create_table "players", force: :cascade do |t|
      t.string   :name
      t.string   :email,              null: false, default: ""
      t.integer  :top_completed_level_id
      t.string   :email
      t.string   :facebook
      t.string   :twitter
      t.string   :identifier
      t.integer  :player_level,               default: 1
      t.string   :skills
      t.datetime :created_at,                              null: false
      t.datetime :updated_at,                              null: false
    end

    add_index "players", ["name"], name: "i_players_n"
    add_index "players", ["email"], name: "i_players_e"

    create_table "player_achievements", force: :cascade do |t|
      t.integer  :player_id
      t.integer  :achievement_id
      t.integer  :level_awarded_id
      t.boolean  :viewed
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index "player_achievements", ["player_id"], name: "i_player_achievements_p"

    create_table "player_items", force: :cascade do |t|
      t.integer  :player_id
      t.integer  :culture_item_id
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index "player_items", ["player_id"], name: "i_player_items_p"

    create_table "player_levels", force: :cascade do |t|
      t.integer  :player_id
      t.integer  :world_id
      t.integer  :level_id
      t.integer  :solid_gold, default: 0
      t.integer  :plays
      t.integer  :wins
      t.integer  :high_score
      t.integer  :fastest_time
      t.integer  :status
      t.integer  :max_kills
      t.integer  :cartridges_collected, default: 0
      t.integer  :vhs_tapes_collected, default: 0
      t.integer  :cassettes_collected, default: 0
      t.integer  :gold_cassettes_collected,  default: 0
      t.integer  :gold_vhs_tapes_collected,  default: 0
      t.integer  :gold_cartridges_collected, default: 0
      t.datetime :fastest_time_at
      t.datetime :max_kills_at
      t.datetime :high_score_at
      t.datetime :started_at
      t.datetime :completed_at
      t.datetime :gold_at
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index "player_levels", ["player_id"], name: "i_player_levels_p"
    add_index "player_levels", ["player_id", "level_id"], name: "i_player_levels_pl"
    add_index "player_levels", ["player_id", "world_id"], name: "i_player_levels_pw"
  end
end
