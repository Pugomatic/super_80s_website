# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180903181329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievement_items", force: :cascade do |t|
    t.integer  "achievement_id"
    t.integer  "culture_item_id"
    t.integer  "amount",          default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "achievement_items", ["achievement_id"], name: "i_achievement_items_a", using: :btree

  create_table "achievements", force: :cascade do |t|
    t.string   "name"
    t.string   "sort_name"
    t.string   "description"
    t.integer  "image"
    t.integer  "match_type"
    t.integer  "match_timeframe"
    t.integer  "matches_allowed"
    t.string   "matching_culture_item_ids"
    t.integer  "match_count"
    t.string   "match_year"
    t.integer  "match_format"
    t.integer  "match_precedence",          default: 0
    t.integer  "award_count",               default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "achievements", ["sort_name"], name: "i_achievements_sn", using: :btree

  create_table "beta_testers", force: :cascade do |t|
    t.text     "email"
    t.string   "version"
    t.boolean  "installed"
    t.integer  "plays"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comfy_blog_comments", force: :cascade do |t|
    t.integer  "post_id",                      null: false
    t.string   "author",                       null: false
    t.string   "email",                        null: false
    t.text     "content"
    t.boolean  "is_published", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_blog_comments", ["post_id", "created_at"], name: "index_comfy_blog_comments_on_post_id_and_created_at", using: :btree
  add_index "comfy_blog_comments", ["post_id", "is_published", "created_at"], name: "index_blog_comments_on_post_published_created", using: :btree

  create_table "comfy_blog_posts", force: :cascade do |t|
    t.integer  "blog_id",                                  null: false
    t.string   "title",                                    null: false
    t.string   "slug",                                     null: false
    t.text     "content"
    t.string   "excerpt",      limit: 1024
    t.string   "author"
    t.integer  "year",                                     null: false
    t.integer  "month",        limit: 2,                   null: false
    t.boolean  "is_published",              default: true, null: false
    t.datetime "published_at",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_blog_posts", ["created_at"], name: "index_comfy_blog_posts_on_created_at", using: :btree
  add_index "comfy_blog_posts", ["is_published", "created_at"], name: "index_comfy_blog_posts_on_is_published_and_created_at", using: :btree
  add_index "comfy_blog_posts", ["is_published", "year", "month", "slug"], name: "index_blog_posts_on_published_year_month_slug", using: :btree

  create_table "comfy_blogs", force: :cascade do |t|
    t.integer "site_id",                             null: false
    t.string  "label",                               null: false
    t.string  "identifier",                          null: false
    t.string  "app_layout",  default: "application", null: false
    t.string  "path"
    t.text    "description"
  end

  add_index "comfy_blogs", ["identifier"], name: "index_comfy_blogs_on_identifier", using: :btree
  add_index "comfy_blogs", ["site_id", "path"], name: "index_comfy_blogs_on_site_id_and_path", using: :btree

  create_table "comfy_cms_blocks", force: :cascade do |t|
    t.string   "identifier",     null: false
    t.text     "content"
    t.integer  "blockable_id"
    t.string   "blockable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_blocks", ["blockable_id", "blockable_type"], name: "index_comfy_cms_blocks_on_blockable_id_and_blockable_type", using: :btree
  add_index "comfy_cms_blocks", ["identifier"], name: "index_comfy_cms_blocks_on_identifier", using: :btree

  create_table "comfy_cms_categories", force: :cascade do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "comfy_cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true, using: :btree

  create_table "comfy_cms_categorizations", force: :cascade do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "comfy_cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "comfy_cms_files", force: :cascade do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_files", ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id", using: :btree
  add_index "comfy_cms_files", ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "comfy_cms_files", ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label", using: :btree
  add_index "comfy_cms_files", ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position", using: :btree

  create_table "comfy_cms_layouts", force: :cascade do |t|
    t.integer  "site_id",                    null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.text     "css"
    t.text     "js"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_layouts", ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_layouts", ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "comfy_cms_pages", force: :cascade do |t|
    t.integer  "site_id",                        null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                          null: false
    t.string   "slug"
    t.string   "full_path",                      null: false
    t.text     "content_cache"
    t.integer  "position",       default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.boolean  "is_published",   default: true,  null: false
    t.boolean  "is_shared",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_pages", ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_pages", ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "comfy_cms_revisions", force: :cascade do |t|
    t.string   "record_type", null: false
    t.integer  "record_id",   null: false
    t.text     "data"
    t.datetime "created_at"
  end

  add_index "comfy_cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "comfy_cms_sites", force: :cascade do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "comfy_cms_sites", ["hostname"], name: "index_comfy_cms_sites_on_hostname", using: :btree
  add_index "comfy_cms_sites", ["is_mirrored"], name: "index_comfy_cms_sites_on_is_mirrored", using: :btree

  create_table "comfy_cms_snippets", force: :cascade do |t|
    t.integer  "site_id",                    null: false
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_snippets", ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "comfy_cms_snippets", ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position", using: :btree

  create_table "culture_formats", force: :cascade do |t|
    t.string   "name"
    t.integer  "enum_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "culture_items", force: :cascade do |t|
    t.string   "uid",                               null: false
    t.integer  "culture_format_id"
    t.integer  "world_id"
    t.string   "title"
    t.string   "funny_title"
    t.string   "artist"
    t.string   "color"
    t.string   "director"
    t.string   "actors"
    t.string   "tags"
    t.boolean  "required",          default: false
    t.integer  "level_number"
    t.string   "dans_commentary"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "culture_items", ["culture_format_id"], name: "i_culture_items_cf", using: :btree
  add_index "culture_items", ["funny_title"], name: "i_culture_items_ft", using: :btree
  add_index "culture_items", ["required"], name: "i_culture_items_r", using: :btree
  add_index "culture_items", ["uid"], name: "i_culture_items_u", using: :btree
  add_index "culture_items", ["world_id"], name: "i_culture_items_w", using: :btree

  create_table "levels", force: :cascade do |t|
    t.integer  "world_id"
    t.integer  "next_level_id"
    t.integer  "number"
    t.string   "name"
    t.integer  "month"
    t.boolean  "minigame"
    t.boolean  "boss"
    t.integer  "gold_cassettes",  default: 0
    t.integer  "gold_vhs_tapes",  default: 0
    t.integer  "gold_cartridges", default: 0
    t.boolean  "level_up_player"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "player_achievements", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "achievement_id"
    t.integer  "level_awarded_id"
    t.boolean  "viewed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_achievements", ["player_id"], name: "i_player_achievements_p", using: :btree

  create_table "player_items", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "culture_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_items", ["player_id"], name: "i_player_items_p", using: :btree

  create_table "player_levels", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "world_id"
    t.integer  "level_id"
    t.integer  "solid_gold",                default: 0
    t.integer  "plays",                     default: 0
    t.integer  "wins",                      default: 0
    t.integer  "high_score",                default: 0
    t.integer  "fastest_time",              default: 0
    t.string   "status",                    default: "locked"
    t.integer  "max_kills",                 default: 0
    t.integer  "max_cartridges_collected",  default: 0
    t.integer  "max_vhs_tapes_collected",   default: 0
    t.integer  "max_cassettes_collected",   default: 0
    t.integer  "max_items_collected",       default: 0
    t.integer  "gold_cassettes_collected",  default: 0
    t.integer  "gold_vhs_tapes_collected",  default: 0
    t.integer  "gold_cartridges_collected", default: 0
    t.integer  "gold_collected",            default: 0
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_levels", ["player_id", "level_id"], name: "i_player_levels_pl", using: :btree
  add_index "player_levels", ["player_id", "world_id"], name: "i_player_levels_pw", using: :btree
  add_index "player_levels", ["player_id"], name: "i_player_levels_p", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "top_completed_level_id"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "identifier"
    t.integer  "player_level",           default: 1
    t.string   "skills"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.text     "image"
    t.text     "fb_data"
    t.string   "handle"
    t.boolean  "pending",                default: false
  end

  add_index "players", ["email"], name: "i_players_e", using: :btree
  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree
  add_index "players", ["name"], name: "i_players_n", using: :btree
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree

  create_table "referer_trackings", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.text     "session_referer_url"
    t.text     "session_first_url"
    t.text     "current_request_url"
    t.text     "current_request_referer_url"
    t.string   "user_agent"
    t.string   "ip"
    t.string   "session_id"
    t.text     "cookies_yaml"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "cookie_referer_url"
    t.text     "cookie_first_url"
    t.datetime "cookie_time"
    t.text     "infos_session"
    t.text     "infos_request"
    t.text     "log"
    t.string   "status"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ip_address"
    t.boolean  "is_suspect"
  end

  create_table "worlds", force: :cascade do |t|
    t.string   "year"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
