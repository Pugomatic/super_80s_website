class AddGameTables < ActiveRecord::Migration[4.2]
  def change
    drop_table :players
    drop_table :prizes

    create_table "achievement_items", force: :cascade do |t|
      t.integer  :achievement_id
      t.integer  :culture_item_id
      t.integer  :amount,          default: 0
      t.datetime :created_at,                  null: false
      t.datetime :updated_at,                  null: false
    end

    add_index "achievement_items", ["achievement_id"], name: "i_achievement_items_a"

    create_table "achievements", force: :cascade do |t|
      t.string   :name
      t.string   :sort_name
      t.string   :description
      t.integer  :image
      t.integer  :match_type
      t.integer  :match_timeframe
      t.integer  :matches_allowed
      t.string   :matching_culture_item_ids
      t.integer  :match_count
      t.string   :match_year
      t.integer  :match_format
      t.integer  :match_precedence,          default: 0
      t.integer  :award_count,               default: 0
      t.datetime :created_at,                            null: false
      t.datetime :updated_at,                            null: false
    end

    add_index "achievements", ["sort_name"], name: "i_achievements_sn"

    create_table "culture_formats", force: :cascade do |t|
      t.string   :name
      t.integer  :enum_index
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    # add_index "culture_formats", ["name"], name: "i_culture_formats_n"
    # add_index "culture_formats", ["enum_index"], name: "i_culture_formats_ei"

    create_table "culture_items", force: :cascade do |t|
      t.string   :uid, null: false
      t.integer  :culture_format_id
      t.integer  :world_id
      t.string   :title
      t.string   :funny_title
      t.string   :artist
      t.string   :color
      t.string   :director
      t.string   :actors
      t.string   :tags
      t.boolean  :required,             default: false
      t.integer  :level_number
      t.string   :dans_commentary
      t.datetime :created_at,                       null: false
      t.datetime :updated_at,                       null: false
    end

    add_index "culture_items", ["uid"], name: "i_culture_items_u"
    add_index "culture_items", ["culture_format_id"], name: "i_culture_items_cf"
    add_index "culture_items", ["world_id"], name: "i_culture_items_w"
    add_index "culture_items", ["funny_title"], name: "i_culture_items_ft"
    add_index "culture_items", ["required"], name: "i_culture_items_r"

    create_table "levels", force: :cascade do |t|
      t.integer  :world_id
      t.integer  :next_level_id
      t.integer  :number
      t.string   :name
      t.integer  :month
      t.boolean  :minigame
      t.boolean  :boss
      t.integer  :gold_cassettes,            default: 0
      t.integer  :gold_vhs_tapes,            default: 0
      t.integer  :gold_cartridges,           default: 0
      t.boolean  :level_up_player
      t.datetime :created_at,                            null: false
      t.datetime :updated_at,                            null: false
    end

    # add_index "levels", ["number"], name: "i_levels_nu"
    # add_index "levels", ["name"], name: "i_levels_na"
    # add_index "levels", ["world_id"], name: "i_levels_y"

    create_table "worlds", force: :cascade do |t|
      t.string   :year
      t.string   :title
      t.integer  :position
      t.datetime :created_at,             null: false
      t.datetime :updated_at,             null: false
    end
  end
end
