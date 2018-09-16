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

ActiveRecord::Schema.define(version: 2018_09_16_162351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievement_items", id: :serial, force: :cascade do |t|
    t.integer "achievement_id"
    t.integer "culture_item_id"
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "i_achievement_items_a"
  end

  create_table "achievements", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "sort_name"
    t.string "description"
    t.integer "image"
    t.integer "match_type"
    t.integer "match_timeframe"
    t.integer "matches_allowed"
    t.string "matching_culture_item_ids"
    t.integer "match_count"
    t.string "match_year"
    t.integer "match_format"
    t.integer "match_precedence", default: 0
    t.integer "award_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sort_name"], name: "i_achievements_sn"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "beta_testers", id: :serial, force: :cascade do |t|
    t.text "email"
    t.string "version"
    t.boolean "installed"
    t.integer "plays"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comfy_blog_comments", id: :serial, force: :cascade do |t|
    t.integer "post_id", null: false
    t.string "author", null: false
    t.string "email", null: false
    t.text "content"
    t.boolean "is_published", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id", "created_at"], name: "index_comfy_blog_comments_on_post_id_and_created_at"
    t.index ["post_id", "is_published", "created_at"], name: "index_blog_comments_on_post_published_created"
  end

  create_table "comfy_blog_posts", id: :serial, force: :cascade do |t|
    t.integer "blog_id", null: false
    t.string "title", null: false
    t.string "slug", null: false
    t.text "content"
    t.string "excerpt", limit: 1024
    t.string "author"
    t.integer "year", null: false
    t.integer "month", limit: 2, null: false
    t.boolean "is_published", default: true, null: false
    t.datetime "published_at", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "site_id"
    t.integer "layout_id"
    t.index ["created_at"], name: "index_comfy_blog_posts_on_created_at"
    t.index ["is_published", "created_at"], name: "index_comfy_blog_posts_on_is_published_and_created_at"
    t.index ["is_published", "year", "month", "slug"], name: "index_blog_posts_on_published_year_month_slug"
  end

  create_table "comfy_blogs", id: :serial, force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "label", null: false
    t.string "identifier", null: false
    t.string "app_layout", default: "application", null: false
    t.string "path"
    t.text "description"
    t.index ["identifier"], name: "index_comfy_blogs_on_identifier"
    t.index ["site_id", "path"], name: "index_comfy_blogs_on_site_id_and_path"
  end

  create_table "comfy_cms_categories", id: :serial, force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "label", null: false
    t.string "categorized_type", null: false
    t.index ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true
  end

  create_table "comfy_cms_categorizations", id: :serial, force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "categorized_type", null: false
    t.integer "categorized_id", null: false
    t.index ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true
  end

  create_table "comfy_cms_files", id: :serial, force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "block_id"
    t.string "label", default: "", null: false
    t.string "file_file_name"
    t.string "description", limit: 2048
    t.integer "position", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id"
    t.index ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name"
    t.index ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label"
    t.index ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position"
  end

  create_table "comfy_cms_fragments", id: :serial, force: :cascade do |t|
    t.string "identifier", null: false
    t.text "content"
    t.string "record_type"
    t.integer "record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "tag", default: "text", null: false
    t.datetime "datetime"
    t.boolean "boolean", default: false, null: false
    t.index ["identifier"], name: "index_comfy_cms_fragments_on_identifier"
    t.index ["record_id", "record_type"], name: "index_comfy_cms_fragments_on_record_id_and_record_type"
  end

  create_table "comfy_cms_layouts", id: :serial, force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "parent_id"
    t.string "app_layout"
    t.string "label", null: false
    t.string "identifier", null: false
    t.text "content"
    t.text "css"
    t.text "js"
    t.integer "position", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position"
    t.index ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true
  end

  create_table "comfy_cms_pages", id: :serial, force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "layout_id"
    t.integer "parent_id"
    t.integer "target_page_id"
    t.string "label", null: false
    t.string "slug"
    t.string "full_path", null: false
    t.text "content_cache"
    t.integer "position", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.boolean "is_published", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position"
    t.index ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path"
  end

  create_table "comfy_cms_revisions", id: :serial, force: :cascade do |t|
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.index ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at"
  end

  create_table "comfy_cms_sites", id: :serial, force: :cascade do |t|
    t.string "label", null: false
    t.string "identifier", null: false
    t.string "hostname", null: false
    t.string "path"
    t.string "locale", default: "en", null: false
    t.index ["hostname"], name: "index_comfy_cms_sites_on_hostname"
  end

  create_table "comfy_cms_snippets", id: :serial, force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "label", null: false
    t.string "identifier", null: false
    t.text "content"
    t.integer "position", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true
    t.index ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position"
  end

  create_table "comfy_cms_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.integer "page_id", null: false
    t.integer "layout_id"
    t.string "label", null: false
    t.text "content_cache"
    t.boolean "is_published", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_published"], name: "index_comfy_cms_translations_on_is_published"
    t.index ["locale"], name: "index_comfy_cms_translations_on_locale"
    t.index ["page_id"], name: "index_comfy_cms_translations_on_page_id"
  end

  create_table "culture_formats", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "enum_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "culture_items", id: :serial, force: :cascade do |t|
    t.string "uid", null: false
    t.integer "culture_format_id"
    t.integer "world_id"
    t.string "title"
    t.string "funny_title"
    t.string "artist"
    t.string "color"
    t.string "director"
    t.string "actors"
    t.string "tags"
    t.boolean "required", default: false
    t.integer "level_number"
    t.string "dans_commentary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["culture_format_id"], name: "i_culture_items_cf"
    t.index ["funny_title"], name: "i_culture_items_ft"
    t.index ["required"], name: "i_culture_items_r"
    t.index ["uid"], name: "i_culture_items_u"
    t.index ["world_id"], name: "i_culture_items_w"
  end

  create_table "levels", id: :serial, force: :cascade do |t|
    t.integer "world_id"
    t.integer "next_level_id"
    t.integer "number"
    t.string "name"
    t.integer "month"
    t.boolean "minigame"
    t.boolean "boss"
    t.integer "gold_cassettes", default: 0
    t.integer "gold_vhs_tapes", default: 0
    t.integer "gold_cartridges", default: 0
    t.boolean "level_up_player"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_achievements", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "achievement_id"
    t.integer "level_awarded_id"
    t.boolean "viewed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["player_id"], name: "i_player_achievements_p"
  end

  create_table "player_items", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "culture_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["player_id"], name: "i_player_items_p"
  end

  create_table "player_levels", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "level_id"
    t.integer "solid_gold", default: 0
    t.integer "plays", default: 0
    t.integer "wins", default: 0
    t.integer "tries", default: 0
    t.integer "high_score", default: 0
    t.integer "fastest_time", default: 0
    t.string "status", default: "locked"
    t.integer "max_kills", default: 0
    t.integer "max_cartridges_collected", default: 0
    t.integer "max_vhs_tapes_collected", default: 0
    t.integer "max_cassettes_collected", default: 0
    t.integer "max_items_collected", default: 0
    t.integer "gold_cassettes_collected", default: 0
    t.integer "gold_vhs_tapes_collected", default: 0
    t.integer "gold_cartridges_collected", default: 0
    t.integer "gold_collected", default: 0
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["player_id", "level_id"], name: "i_player_levels_pl"
    t.index ["player_id"], name: "i_player_levels_p"
  end

  create_table "player_totals", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "solid_gold", default: 0
    t.integer "plays", default: 0
    t.integer "wins", default: 0
    t.integer "high_score", default: 0
    t.integer "fastest_time", default: 0
    t.string "status", default: "completed"
    t.integer "max_kills", default: 0
    t.integer "max_cartridges_collected", default: 0
    t.integer "max_vhs_tapes_collected", default: 0
    t.integer "max_cassettes_collected", default: 0
    t.integer "max_items_collected", default: 0
    t.integer "gold_cassettes_collected", default: 0
    t.integer "gold_vhs_tapes_collected", default: 0
    t.integer "gold_cartridges_collected", default: 0
    t.integer "gold_collected", default: 0
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["player_id"], name: "i_player_totals_p"
  end

  create_table "player_worlds", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "world_id"
    t.integer "solid_gold", default: 0
    t.integer "plays", default: 0
    t.integer "wins", default: 0
    t.integer "high_score", default: 0
    t.integer "fastest_time", default: 0
    t.string "status", default: "locked"
    t.integer "max_kills", default: 0
    t.integer "max_cartridges_collected", default: 0
    t.integer "max_vhs_tapes_collected", default: 0
    t.integer "max_cassettes_collected", default: 0
    t.integer "max_items_collected", default: 0
    t.integer "gold_cassettes_collected", default: 0
    t.integer "gold_vhs_tapes_collected", default: 0
    t.integer "gold_cartridges_collected", default: 0
    t.integer "gold_collected", default: 0
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["player_id", "world_id"], name: "i_player_worlds_pw"
    t.index ["player_id"], name: "i_player_worlds_p"
  end

  create_table "players", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "top_completed_level_id"
    t.string "facebook"
    t.string "twitter"
    t.string "identifier"
    t.integer "player_level", default: 1
    t.string "skills"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.text "image"
    t.text "fb_data"
    t.string "handle"
    t.boolean "pending", default: false
    t.index ["email"], name: "i_players_e"
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["name"], name: "i_players_n"
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  create_table "referer_trackings", id: :serial, force: :cascade do |t|
    t.integer "trackable_id"
    t.string "trackable_type"
    t.text "session_referer_url"
    t.text "session_first_url"
    t.text "current_request_url"
    t.text "current_request_referer_url"
    t.string "user_agent"
    t.string "ip"
    t.string "session_id"
    t.text "cookies_yaml"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "cookie_referer_url"
    t.text "cookie_first_url"
    t.datetime "cookie_time"
    t.text "infos_session"
    t.text "infos_request"
    t.text "log"
    t.string "status"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_address"
    t.boolean "is_suspect"
  end

  create_table "worlds", id: :serial, force: :cascade do |t|
    t.string "year"
    t.string "title"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
