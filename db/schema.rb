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

  create_table "activities", :force => true do |t|
    t.integer  "person_id"
    t.string   "title"
    t.text     "description"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page"
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "end_at_page"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["person_id"], :name => "index_activities_on_person_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

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
    t.string   "accurate_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "arch_files", ["inventory_id"], :name => "index_arch_files_on_inventory_id"
  add_index "arch_files", ["user_id"], :name => "index_arch_files_on_user_id"

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

  create_table "births", :force => true do |t|
    t.integer  "person_id"
    t.string   "document_type",   :limit => 15
    t.date     "christened_at"
    t.date     "registered_at"
    t.integer  "organization_id"
    t.integer  "arch_file_id"
    t.string   "document_code",   :limit => 50
    t.boolean  "legitimate",                    :default => true
    t.boolean  "founded",                       :default => false
    t.integer  "godfather_id"
    t.integer  "godmother_id"
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "births", ["arch_file_id"], :name => "index_births_on_arch_file_id"
  add_index "births", ["person_id"], :name => "index_births_on_person_id"
  add_index "births", ["user_id"], :name => "index_births_on_user_id"

  create_table "card_districts", :force => true do |t|
    t.integer  "card_id"
    t.integer  "district_id_old"
    t.integer  "district_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_districts", ["card_id"], :name => "index_card_districts_on_card_id"
  add_index "card_districts", ["district_id"], :name => "index_card_districts_on_district_id"
  add_index "card_districts", ["user_id"], :name => "index_card_districts_on_user_id"

  create_table "card_eparchies", :force => true do |t|
    t.integer  "card_id"
    t.integer  "eparchy_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_eparchies", ["card_id"], :name => "index_card_eparchies_on_card_id"
  add_index "card_eparchies", ["eparchy_id"], :name => "index_card_eparchies_on_eparchy_id"
  add_index "card_eparchies", ["user_id"], :name => "index_card_eparchies_on_user_id"

  create_table "card_labels", :force => true do |t|
    t.string "title"
  end

  create_table "card_organizations", :force => true do |t|
    t.integer  "card_id"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_organizations", ["card_id"], :name => "index_card_organizations_on_card_id"
  add_index "card_organizations", ["organization_id"], :name => "index_card_organizations_on_organization_id"
  add_index "card_organizations", ["user_id"], :name => "index_card_organizations_on_user_id"

  create_table "card_people", :force => true do |t|
    t.integer  "card_id"
    t.integer  "person_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_people", ["card_id"], :name => "index_card_people_on_card_id"
  add_index "card_people", ["person_id"], :name => "index_card_people_on_person_id"
  add_index "card_people", ["user_id"], :name => "index_card_people_on_user_id"

  create_table "card_places", :force => true do |t|
    t.integer  "card_id"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "place_comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_places", ["card_id"], :name => "index_card_places_on_card_id"
  add_index "card_places", ["place_id"], :name => "index_card_places_on_place_id"
  add_index "card_places", ["user_id"], :name => "index_card_places_on_user_id"

  create_table "card_rubrics", :force => true do |t|
    t.integer  "card_id"
    t.integer  "rubric_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_rubrics", ["card_id"], :name => "index_card_rubrics_on_card_id"
  add_index "card_rubrics", ["rubric_id"], :name => "index_card_rubrics_on_rubric_id"
  add_index "card_rubrics", ["user_id"], :name => "index_card_rubrics_on_user_id"

  create_table "cards", :force => true do |t|
    t.integer  "arch_file_id"
    t.text     "description"
    t.string   "page",               :limit => 50
    t.string   "card_date",          :limit => 50
    t.integer  "card_label_id"
    t.string   "photo",              :limit => 500
    t.integer  "mark"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fund_id_tmp"
    t.string   "invenory_text_tmp",  :limit => 20
    t.string   "arch_file_text_tmp", :limit => 20
  end

  add_index "cards", ["arch_file_id"], :name => "index_cards_on_arch_file_id"
  add_index "cards", ["user_id"], :name => "index_cards_on_user_id"

  create_table "center_links", :force => true do |t|
    t.integer  "id_old"
    t.integer  "district_id_old"
    t.integer  "district_id"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "source_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "center_links", ["district_id"], :name => "index_center_links_on_district_id"
  add_index "center_links", ["place_id"], :name => "index_center_links_on_place_id"
  add_index "center_links", ["user_id"], :name => "index_center_links_on_user_id"

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

  create_table "death_causes", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "deaths", :force => true do |t|
    t.integer  "person_id"
    t.integer  "arch_file_id"
    t.integer  "organization_id"
    t.string   "document_code",     :limit => 50
    t.integer  "age"
    t.integer  "cause_of_death_id"
    t.string   "comment",           :limit => 100
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deaths", ["arch_file_id"], :name => "index_deaths_on_arch_file_id"
  add_index "deaths", ["person_id"], :name => "index_deaths_on_person_id"
  add_index "deaths", ["user_id"], :name => "index_deaths_on_user_id"

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "district_links", ["district1_id"], :name => "index_district_links_on_district1_id"
  add_index "district_links", ["district_id"], :name => "index_district_links_on_district_id"
  add_index "district_links", ["user_id"], :name => "index_district_links_on_user_id"

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["district_type_id"], :name => "index_districts_on_district_type_id"
  add_index "districts", ["user_id"], :name => "index_districts_on_user_id"

  create_table "educations", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page",    :limit => 30
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "endt_at_page",     :limit => 30
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["organization_id"], :name => "index_educations_on_organization_id"
  add_index "educations", ["person_id"], :name => "index_educations_on_person_id"
  add_index "educations", ["user_id"], :name => "index_educations_on_user_id"

  create_table "estates", :force => true do |t|
    t.string "title"
    t.text   "description"
  end

  create_table "event_types", :force => true do |t|
    t.string "title"
  end

  create_table "events", :force => true do |t|
    t.string  "title"
    t.integer "event_type_id"
  end

  add_index "events", ["event_type_id", "title"], :name => "index_events_on_event_type_id_and_title"

  create_table "fund_guides", :force => true do |t|
    t.integer  "fund_id"
    t.integer  "guide_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fund_guides", ["fund_id"], :name => "index_fund_guides_on_fund_id"
  add_index "fund_guides", ["guide_id"], :name => "index_fund_guides_on_guide_id"
  add_index "fund_guides", ["user_id"], :name => "index_fund_guides_on_user_id"

  create_table "fund_rubrics", :force => true do |t|
    t.integer  "fund_id"
    t.integer  "rubric_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fund_rubrics", ["fund_id"], :name => "index_fund_rubrics_on_fund_id"
  add_index "fund_rubrics", ["rubric_id"], :name => "index_fund_rubrics_on_rubric_id"
  add_index "fund_rubrics", ["user_id"], :name => "index_fund_rubrics_on_user_id"

  create_table "funds", :force => true do |t|
    t.string   "code",                 :limit => 20
    t.string   "title"
    t.integer  "amount_of_arch_files"
    t.integer  "start_year"
    t.integer  "end_year"
    t.text     "description"
    t.integer  "archive_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "funds", ["code"], :name => "index_funds_on_code"
  add_index "funds", ["user_id"], :name => "index_funds_on_user_id"

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

  create_table "human_names", :force => true do |t|
    t.string  "name"
    t.string  "gender_old"
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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventories", ["fund_id"], :name => "index_inventories_on_fund_id"
  add_index "inventories", ["user_id"], :name => "index_inventories_on_user_id"

  create_table "marriages", :force => true do |t|
    t.string   "document_type",            :limit => 15
    t.date     "registered_at"
    t.date     "divorced_at"
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.string   "place_comment"
    t.integer  "district_id_old"
    t.integer  "district_id"
    t.integer  "organization_id"
    t.integer  "arch_file_id"
    t.string   "page"
    t.string   "registry_office",          :limit => 80
    t.string   "certificate",              :limit => 50
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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "marriages", ["bride_id"], :name => "index_marriages_on_bride_id"
  add_index "marriages", ["bridegroom_id"], :name => "index_marriages_on_bridegroom_id"
  add_index "marriages", ["district_id"], :name => "index_marriages_on_district_id"
  add_index "marriages", ["organization_id"], :name => "index_marriages_on_organization_id"
  add_index "marriages", ["place_id"], :name => "index_marriages_on_place_id"
  add_index "marriages", ["user_id"], :name => "index_marriages_on_user_id"

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_links", ["organization1_id"], :name => "index_organization_links_on_organization1_id"
  add_index "organization_links", ["organization_id"], :name => "index_organization_links_on_organization_id"
  add_index "organization_links", ["user_id"], :name => "index_organization_links_on_user_id"

  create_table "organization_types", :force => true do |t|
    t.string "title",   :limit => 50
    t.string "subtype", :limit => 10, :default => "org"
    t.string "in_list", :limit => 10, :default => "other"
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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["organization_type_id"], :name => "index_organizations_on_organization_type_id"
  add_index "organizations", ["place_id", "type"], :name => "index_organizations_on_place_id_and_type"
  add_index "organizations", ["user_id"], :name => "index_organizations_on_user_id"

  create_table "parishes", :force => true do |t|
    t.integer  "place_id_old"
    t.integer  "place_id"
    t.integer  "organization_id_old"
    t.integer  "organization_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "start_year_source_id"
    t.integer  "end_year_source_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parishes", ["organization_id"], :name => "index_parishes_on_organization_id"
  add_index "parishes", ["place_id"], :name => "index_parishes_on_place_id"
  add_index "parishes", ["user_id"], :name => "index_parishes_on_user_id"

  create_table "people", :force => true do |t|
    t.string   "full_name"
    t.string   "last_name",              :limit => 50
    t.string   "last_name_comment"
    t.string   "name",                   :limit => 50
    t.string   "patronymic",             :limit => 50
    t.string   "gender_old"
    t.boolean  "gender"
    t.date     "date_of_birth"
    t.string   "date_of_birth_comment",  :limit => 80
    t.boolean  "exact_date_of_birth"
    t.integer  "place_of_birth_id_old"
    t.integer  "place_of_birth_id"
    t.integer  "place_of_birth_comment"
    t.boolean  "exact_place_of_birth"
    t.date     "date_of_death"
    t.string   "date_of_death_comment",  :limit => 80
    t.boolean  "exact_date_of_death"
    t.integer  "place_of_death_id_old"
    t.integer  "place_of_death_id"
    t.integer  "place_of_death_comment"
    t.boolean  "exact_place_of_death"
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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["father_id"], :name => "index_people_on_father_id"
  add_index "people", ["full_name"], :name => "index_people_on_full_name"
  add_index "people", ["gender"], :name => "index_people_on_gender"
  add_index "people", ["last_name"], :name => "index_people_on_last_name"
  add_index "people", ["mother_id"], :name => "index_people_on_mother_id"
  add_index "people", ["name"], :name => "index_people_on_name"
  add_index "people", ["user_id"], :name => "index_people_on_user_id"

  create_table "person_decorations", :force => true do |t|
    t.integer  "person_id"
    t.integer  "decoration_id"
    t.date     "award_at"
    t.string   "desert"
    t.string   "order_title"
    t.integer  "card_id"
    t.string   "page",          :limit => 30
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_decorations", ["person_id"], :name => "index_person_decorations_on_person_id"
  add_index "person_decorations", ["user_id"], :name => "index_person_decorations_on_user_id"

  create_table "person_estates", :force => true do |t|
    t.integer  "person_id"
    t.integer  "estate_id"
    t.string   "description"
    t.date     "start_at"
    t.integer  "card_id"
    t.string   "page"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_estates", ["person_id"], :name => "index_person_estates_on_person_id"
  add_index "person_estates", ["user_id"], :name => "index_person_estates_on_user_id"

  create_table "person_events", :force => true do |t|
    t.integer  "person_id"
    t.integer  "event_id"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page"
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "end_at_page"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_events", ["person_id"], :name => "index_person_events_on_person_id"
  add_index "person_events", ["user_id"], :name => "index_person_events_on_user_id"

  create_table "person_positions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.integer  "position_id"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "start_at_card_id"
    t.integer  "end_at_card_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_positions", ["organization_id"], :name => "index_person_positions_on_organization_id"
  add_index "person_positions", ["person_id"], :name => "index_person_positions_on_person_id"
  add_index "person_positions", ["user_id"], :name => "index_person_positions_on_user_id"

  create_table "person_professions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "profession_id"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page",    :limit => 30
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "endt_at_page",     :limit => 30
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_professions", ["person_id"], :name => "index_person_professions_on_person_id"
  add_index "person_professions", ["user_id"], :name => "index_person_professions_on_user_id"

  create_table "person_properties", :force => true do |t|
    t.integer  "person_id"
    t.integer  "property_id"
    t.integer  "place_id"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page"
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "end_at_page"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_properties", ["person_id"], :name => "index_person_properties_on_person_id"
  add_index "person_properties", ["place_id"], :name => "index_person_properties_on_place_id"
  add_index "person_properties", ["user_id"], :name => "index_person_properties_on_user_id"

  create_table "person_religions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "religion_id"
    t.integer  "start_year"
    t.integer  "start_year_card_id"
    t.string   "start_year_page"
    t.integer  "end_year"
    t.integer  "end_year_card_id"
    t.string   "end_year_page"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_religions", ["person_id"], :name => "index_person_religions_on_person_id"
  add_index "person_religions", ["user_id"], :name => "index_person_religions_on_user_id"

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "place_links", ["district_id"], :name => "index_place_links_on_district_id"
  add_index "place_links", ["place_id"], :name => "index_place_links_on_place_id"
  add_index "place_links", ["user_id"], :name => "index_place_links_on_user_id"

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "place_name_links", ["place1_id"], :name => "index_place_name_links_on_place1_id"
  add_index "place_name_links", ["place2_id"], :name => "index_place_name_links_on_place2_id"
  add_index "place_name_links", ["place_id"], :name => "index_place_name_links_on_place_id"
  add_index "place_name_links", ["user_id"], :name => "index_place_name_links_on_user_id"

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "places", ["place_id"], :name => "index_places_on_place_id"
  add_index "places", ["user_id"], :name => "index_places_on_user_id"

  create_table "positions", :force => true do |t|
    t.string "title", :limit => 60
  end

  create_table "professions", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "properties", :force => true do |t|
    t.string  "title"
    t.integer "property_type_id"
  end

  add_index "properties", ["property_type_id", "title"], :name => "index_properties_on_property_type_id_and_title"

  create_table "property_types", :force => true do |t|
    t.string "title"
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
    t.integer  "start_year"
    t.integer  "start_year_card_id"
    t.integer  "end_year"
    t.integer  "end_year_card_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "residences", ["person_id"], :name => "index_residences_on_person_id"
  add_index "residences", ["place_id"], :name => "index_residences_on_place_id"
  add_index "residences", ["user_id"], :name => "index_residences_on_user_id"

  create_table "revisions", :force => true do |t|
    t.date     "revision_date"
    t.integer  "place_id"
    t.integer  "district_id_old"
    t.integer  "district_id"
    t.integer  "arch_file_id"
    t.integer  "person_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "revisions", ["arch_file_id"], :name => "index_revisions_on_arch_file_id"
  add_index "revisions", ["person_id"], :name => "index_revisions_on_person_id"
  add_index "revisions", ["user_id"], :name => "index_revisions_on_user_id"

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

  create_table "safety_marks", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "services", :force => true do |t|
    t.integer  "person_id"
    t.integer  "rank_id"
    t.integer  "organization_id"
    t.date     "start_at"
    t.integer  "start_at_card_id"
    t.string   "start_at_page"
    t.date     "end_at"
    t.integer  "end_at_card_id"
    t.string   "end_at_page"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["organization_id"], :name => "index_services_on_organization_id"
  add_index "services", ["person_id"], :name => "index_services_on_person_id"
  add_index "services", ["user_id"], :name => "index_services_on_user_id"

  create_table "sources", :force => true do |t|
    t.integer  "id_old"
    t.string   "title",       :limit => 50
    t.string   "fund",        :limit => 50
    t.string   "inventory",   :limit => 50
    t.string   "arch_file",   :limit => 50
    t.integer  "archive_id"
    t.text     "description"
    t.integer  "user_id"
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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "state_links", ["place_id"], :name => "index_state_links_on_place_id"
  add_index "state_links", ["user_id"], :name => "index_state_links_on_user_id"

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
