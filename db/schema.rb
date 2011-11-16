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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111115090539) do

  create_table "additional_sources", :force => true do |t|
    t.string   "autor",       :limit => 50
    t.string   "title",       :limit => 250
    t.text     "description"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arch_files", :force => true do |t|
    t.string   "code",                :limit => 20
    t.integer  "inventory_id"
    t.integer  "fund_id"
    t.text     "title"
    t.integer  "amount_of_pages"
    t.string   "safety_mark_old",     :limit => 50
    t.integer  "safety_mark_id"
    t.string   "uniqueness_mark_old", :limit => 50
    t.string   "uniqueness_mark_id",  :limit => 50
    t.text     "toc"
    t.integer  "start_year"
    t.integer  "end_year"
    t.boolean  "title_changed"
    t.string   "photo",               :limit => 500
    t.integer  "user_id"
    t.string   "accurate_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "arch_files", ["fund_id"], :name => "index_arch_files_on_fund_id"

  create_table "archives", :force => true do |t|
    t.string "title",    :limit => 50
    t.string "location", :limit => 50
  end

  create_table "atd_churches", :force => true do |t|
    t.string   "title",                :limit => 100
    t.integer  "organization_type_id"
    t.string   "point",                :limit => 100
    t.string   "atd",                  :limit => 50
    t.string   "deanery",              :limit => 50
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "atd_types", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "atd_users", :force => true do |t|
    t.string "name", :limit => 30
  end

  create_table "center_links", :force => true do |t|
    t.integer  "id_old"
    t.integer  "district_id_old"
    t.integer  "district_id"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "churches", :force => true do |t|
    t.string "title", :limit => 100
  end

  create_table "citizenships", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "deaneries", :force => true do |t|
    t.string "title", :limit => 50
    t.string "state", :limit => 50
  end

  create_table "decorations", :force => true do |t|
    t.string "title",       :limit => 80
    t.text   "description"
  end

  create_table "district_links", :force => true do |t|
    t.integer  "id_old"
    t.integer  "district_id_old"
    t.integer  "district_id"
    t.integer  "district_type_id_old"
    t.integer  "district_type_id"
    t.integer  "district1_id_old"
    t.integer  "district1_id"
    t.integer  "district_type1_id_old"
    t.integer  "district_type1_id"
    t.integer  "district2_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "source_id_old"
    t.integer  "source_id"
    t.boolean  "annex"
    t.boolean  "rename"
    t.boolean  "separate"
    t.boolean  "union"
    t.string   "action",                :limit => 50
    t.integer  "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "district_types", :force => true do |t|
    t.integer "id_old"
    t.string  "title",  :limit => 50
  end

  create_table "districts", :force => true do |t|
    t.integer  "id_old"
    t.integer  "district_type_id_old"
    t.integer  "district_type_id"
    t.string   "title",                :limit => 50
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "start_year_source_id"
    t.integer  "end_year_source_id"
    t.string   "href",                 :limit => 500
    t.text     "description"
    t.integer  "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educations", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page",    :limit => 30
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "endt_at_page",     :limit => 30
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_guides", :force => true do |t|
    t.integer "fund_id"
    t.integer "guide_id"
  end

  add_index "fund_guides", ["fund_id"], :name => "index_fund_guides_on_fund_id"

  create_table "fund_rubrics", :force => true do |t|
    t.integer "fund_id"
    t.integer "rubric_id"
  end

  add_index "fund_rubrics", ["fund_id"], :name => "index_fund_rubrics_on_fund_id"

  create_table "funds", :force => true do |t|
    t.string   "code",                 :limit => 20
    t.string   "title"
    t.integer  "amount_of_arch_files"
    t.integer  "start_year"
    t.integer  "end_year"
    t.text     "description"
    t.integer  "archive_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geo_maps", :force => true do |t|
    t.string  "filename", :limit => 60
    t.integer "wi"
    t.integer "wj"
    t.integer "x_add"
    t.integer "y_add"
  end

  create_table "guides", :force => true do |t|
    t.string  "title"
    t.string  "code",      :limit => 20
    t.integer "level_1"
    t.integer "level_2"
    t.integer "level_3"
    t.integer "level_4"
    t.integer "level_5"
    t.string  "comment"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
  end

  add_index "guides", ["lft", "rgt"], :name => "index_guides_on_lft_and_rgt"
  add_index "guides", ["parent_id", "lft", "rgt"], :name => "index_guides_on_parent_id_and_lft_and_rgt"
  add_index "guides", ["parent_id"], :name => "index_guides_on_parent_id"

  create_table "human_names", :force => true do |t|
    t.string  "name"
    t.boolean "gender"
  end

  create_table "inventories", :force => true do |t|
    t.string   "code",                 :limit => 20
    t.string   "title"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "fund_id"
    t.integer  "amount_of_arch_files"
    t.text     "description"
    t.integer  "copies"
    t.string   "shelf",                :limit => 50
    t.integer  "sheafs"
    t.integer  "boxes"
    t.string   "photo",                :limit => 500
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventories", ["fund_id"], :name => "index_inventories_on_fund_id"

  create_table "marriages", :force => true do |t|
    t.string   "document_type"
    t.datetime "registered_at"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.string   "place_comment"
    t.integer  "district_id_old"
    t.integer  "district_id"
    t.integer  "organization_id"
    t.integer  "arch_file_id"
    t.integer  "bridegroom_id"
    t.integer  "bridegroom_age"
    t.integer  "bridegroom_marriages"
    t.string   "bridegroom_comment"
    t.integer  "bride_id"
    t.integer  "bride_age"
    t.integer  "bride_marriages"
    t.string   "bride_comment"
    t.integer  "bridegroom_guarantor1_id"
    t.integer  "bridegroom_guarantor2_id"
    t.integer  "bride_guarantor1_id"
    t.integer  "bride_guarantor2_id"
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nationalities", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "organization_links", :force => true do |t|
    t.integer  "id_old"
    t.integer  "organization_id_old"
    t.integer  "organization_id"
    t.integer  "organization_type_id"
    t.integer  "organization1_id_old"
    t.integer  "organization1_id"
    t.integer  "organization_type1_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "start_year_source_id"
    t.integer  "end_year_source_id"
    t.boolean  "annex"
    t.boolean  "rename"
    t.boolean  "separate"
    t.boolean  "union"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_types", :force => true do |t|
    t.string "title",   :limit => 50
    t.string "subtype", :limit => 10
  end

  create_table "organizations", :force => true do |t|
    t.string   "type",                 :limit => 15
    t.string   "title",                :limit => 50
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "organization_type_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "start_year_source_id"
    t.integer  "end_year_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parishes", :force => true do |t|
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "organization_id_old"
    t.integer  "organization_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "start_year_source_id"
    t.integer  "end_year_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_decorations", :force => true do |t|
    t.integer  "person_id"
    t.integer  "decoration_id"
    t.date     "award_at"
    t.string   "service"
    t.string   "document"
    t.integer  "card_id"
    t.string   "page",          :limit => 30
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_positions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.integer  "position_id"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "start_at_card_id"
    t.integer  "end_at_card_id"
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_professions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "profession_id"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page",    :limit => 30
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "endt_at_page",     :limit => 30
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_ranks", :force => true do |t|
    t.integer  "person_id"
    t.integer  "rank_id"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "start_at_card_id"
    t.integer  "end_at_card_id"
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_religions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "religion_id"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page"
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "end_at_page"
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "persons", :force => true do |t|
    t.string   "last_name",                :limit => 50
    t.string   "name",                     :limit => 50
    t.string   "patronymic",               :limit => 50
    t.boolean  "gender"
    t.date     "date_of_birth"
    t.string   "date_of_birth_comment",    :limit => 80
    t.boolean  "exact_date_of_birth"
    t.integer  "place_of_birth_id_old"
    t.integer  "place_of_birth_id"
    t.integer  "place_of_birth_comment"
    t.integer  "district_of_birth_id_old"
    t.integer  "district_of_birth_id"
    t.date     "date_of_death"
    t.string   "date_of_death_comment",    :limit => 80
    t.boolean  "exact_date_of_death"
    t.integer  "place_of_death_id_old"
    t.integer  "place_of_death_id"
    t.integer  "place_of_death_comment"
    t.integer  "district_of_death_id_old"
    t.integer  "district_of_death_id"
    t.integer  "mother_id"
    t.boolean  "foster_mother"
    t.integer  "father_id"
    t.boolean  "foster_father"
    t.integer  "religion_id"
    t.string   "nationality_old"
    t.string   "nationality_id"
    t.string   "citizenship_old"
    t.string   "citizenship_id"
    t.string   "title_old"
    t.string   "title_id"
    t.text     "description"
    t.text     "add_sources"
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "place_links", :force => true do |t|
    t.integer  "id_old"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "district_id_old"
    t.integer  "district_id"
    t.integer  "district_type_id_old"
    t.integer  "district_type_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.boolean  "annex"
    t.boolean  "rename"
    t.boolean  "separate"
    t.boolean  "union"
    t.integer  "mark"
    t.integer  "region"
    t.integer  "source_id_old"
    t.integer  "source_id"
    t.string   "page",                 :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "place_name_links", :force => true do |t|
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "place1_id_old"
    t.integer  "place1_id"
    t.integer  "place2_id"
    t.integer  "year"
    t.string   "action",        :limit => 50
    t.integer  "source_id_old"
    t.integer  "source_id"
    t.string   "page",          :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "place_states", :force => true do |t|
    t.integer "id_old"
    t.string  "title",  :limit => 50
  end

  create_table "places", :force => true do |t|
    t.integer  "id_old"
    t.string   "title"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "start_year_source_id"
    t.integer  "end_year_source_id"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.string   "href",                 :limit => 500
    t.text     "description"
    t.string   "zipcode",              :limit => 30
    t.string   "lat",                  :limit => 50
    t.string   "lng",                  :limit => 50
    t.integer  "mark"
    t.string   "x_top",                :limit => 50
    t.string   "y_top",                :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", :force => true do |t|
    t.string "title", :limit => 60
  end

  create_table "professions", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "ranks", :force => true do |t|
    t.string "title",       :limit => 65
    t.string "description", :limit => 150
    t.text   "about"
  end

  create_table "religions", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "residences", :force => true do |t|
    t.integer  "person_id"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.date     "start_at"
    t.integer  "staet_at_card_id"
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.integer  "executor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubrics", :force => true do |t|
    t.string  "title"
    t.string  "code",      :limit => 20
    t.integer "level_1"
    t.integer "level_2"
    t.integer "level_3"
    t.integer "level_4"
    t.integer "level_5"
    t.integer "level_6"
    t.string  "comment"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
  end

  add_index "rubrics", ["lft", "rgt"], :name => "index_rubrics_on_lft_and_rgt"
  add_index "rubrics", ["parent_id", "lft", "rgt"], :name => "index_rubrics_on_parent_id_and_lft_and_rgt"
  add_index "rubrics", ["parent_id"], :name => "index_rubrics_on_parent_id"

  create_table "safety_marks", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "sources", :force => true do |t|
    t.integer  "id_old"
    t.string   "title",       :limit => 50
    t.string   "fund",        :limit => 50
    t.string   "inventory",   :limit => 50
    t.string   "arch_file",   :limit => 50
    t.integer  "archive_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "state_links", :force => true do |t|
    t.integer  "id_old"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "place_state_id_old"
    t.integer  "place_state_id"
    t.integer  "award_year"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "table_four", :force => true do |t|
    t.string  "authority",   :limit => 50
    t.integer "number"
    t.date    "at"
    t.text    "description"
  end

  create_table "titles", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "uniqueness_marks", :force => true do |t|
    t.string "title", :limit => 50
  end

end
