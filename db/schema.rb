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

ActiveRecord::Schema.define(:version => 20110923050704) do

  create_table "arch_files", :force => true do |t|
    t.string   "code",            :limit => 20
    t.integer  "invetnory_id"
    t.integer  "fund_id"
    t.text     "title"
    t.integer  "amount_of_pages"
    t.string   "state",           :limit => 50
    t.string   "mark",            :limit => 50
    t.text     "toc"
    t.integer  "start_year"
    t.integer  "end_year"
    t.boolean  "title_changed"
    t.string   "photo",           :limit => 500
    t.integer  "executor"
    t.datetime "at"
    t.datetime "accurate_at"
  end

  create_table "archives", :force => true do |t|
    t.string "title",    :limit => 50
    t.string "location", :limit => 50
  end

  create_table "atd_additional_sources", :force => true do |t|
    t.string  "autor",       :limit => 50
    t.string  "title",       :limit => 250
    t.text    "description"
    t.integer "year"
  end

  create_table "atd_atd_churches", :force => true do |t|
    t.string  "title",         :limit => 100
    t.integer "house_type_id"
    t.string  "point",         :limit => 100
    t.string  "atd",           :limit => 50
    t.string  "deanery",       :limit => 50
    t.integer "place_id_old"
    t.integer "place_id"
  end

  create_table "atd_center_links", :force => true do |t|
    t.integer "id_old"
    t.integer "district_id_old"
    t.integer "district_id"
    t.integer "place_id_old"
    t.integer "place_id"
    t.integer "start_year"
    t.integer "end_year"
  end

  create_table "atd_churches", :force => true do |t|
    t.string "title", :limit => 100
  end

  create_table "atd_deaneries", :force => true do |t|
    t.string "title", :limit => 50
    t.string "state", :limit => 50
  end

  create_table "atd_district_links", :force => true do |t|
    t.integer "id_old"
    t.integer "district1_id_old"
    t.integer "district1_id"
    t.integer "district_type1_id_old"
    t.integer "district_type1_id"
    t.integer "district2_id_old"
    t.integer "district2_id"
    t.integer "district_type2_id_old"
    t.integer "district_type2_id"
    t.integer "start_year"
    t.integer "end_year"
    t.integer "source_id_old"
    t.integer "source_id"
    t.boolean "annex"
    t.boolean "rename"
    t.boolean "separate"
    t.boolean "union"
    t.string  "action"
    t.integer "mark"
  end

  create_table "atd_district_types", :force => true do |t|
    t.integer "id_old"
    t.string  "title",  :limit => 50
  end

  create_table "atd_districts", :force => true do |t|
    t.integer "id_old"
    t.integer "district_type_id_old"
    t.integer "district_type_id"
    t.string  "title",                :limit => 50
    t.integer "start_year"
    t.integer "end_year"
    t.string  "href",                 :limit => 500
    t.text    "description"
    t.integer "mark"
  end

  create_table "atd_geo_maps", :force => true do |t|
    t.string  "filename", :limit => 60
    t.integer "wi"
    t.integer "wj"
    t.integer "x_add"
    t.integer "y_add"
  end

  create_table "atd_house_links", :force => true do |t|
    t.integer "id_old"
    t.integer "house1_id_old"
    t.integer "house1_id"
    t.integer "house_type1_id"
    t.integer "house2_id_old"
    t.integer "house2_id"
    t.integer "house_type2_id"
    t.integer "start_year"
    t.integer "end_year"
    t.boolean "annex"
    t.boolean "rename"
    t.boolean "separate"
    t.boolean "union"
  end

  create_table "atd_house_types", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "atd_houses", :force => true do |t|
    t.string  "title",         :limit => 50
    t.integer "place_id_old"
    t.integer "place_id"
    t.integer "house_type_id"
    t.integer "create_year"
    t.integer "destroy_year"
  end

  create_table "atd_parishes", :force => true do |t|
    t.integer "place_id_old"
    t.integer "place_id"
    t.integer "house_id_old"
    t.integer "house_id"
    t.integer "start_year"
    t.integer "end_year"
  end

  create_table "atd_place_links", :force => true do |t|
    t.integer "id_old"
    t.integer "place_id_old"
    t.integer "place_id"
    t.integer "district_id_old"
    t.integer "district_id"
    t.integer "district_type_id_old"
    t.integer "district_type_id"
    t.integer "start_year"
    t.integer "end_year"
    t.boolean "annex"
    t.boolean "rename"
    t.boolean "separate"
    t.boolean "union"
    t.integer "mark"
    t.integer "region"
    t.integer "source_id_old"
    t.integer "source_id"
    t.string  "page",                 :limit => 20
  end

  create_table "atd_place_name_links", :force => true do |t|
    t.integer "place1_id_old"
    t.integer "place1_id"
    t.integer "place2_id_old"
    t.integer "place2_id"
    t.integer "year"
    t.string  "sign",          :limit => 50
    t.integer "source_id_old"
    t.integer "source_id"
    t.string  "page",          :limit => 20
  end

  create_table "atd_place_states", :force => true do |t|
    t.integer "id_old"
    t.string  "title",  :limit => 50
  end

  create_table "atd_places", :force => true do |t|
    t.integer "id_old"
    t.string  "title"
    t.integer "start_year"
    t.integer "end_year"
    t.integer "place_id_old"
    t.integer "place_id"
    t.string  "href",         :limit => 500
    t.text    "description"
    t.string  "zipcode",      :limit => 30
    t.string  "lat",          :limit => 50
    t.string  "lng",          :limit => 50
    t.integer "mark"
    t.string  "x_top",        :limit => 50
    t.string  "y_top",        :limit => 50
  end

  create_table "atd_sources", :force => true do |t|
    t.integer "id_old"
    t.string  "title",       :limit => 50
    t.string  "fund",        :limit => 50
    t.string  "inventory",   :limit => 50
    t.string  "arch_file",   :limit => 50
    t.integer "archive_id"
    t.text    "description"
  end

  create_table "atd_state_links", :force => true do |t|
    t.integer "id_old"
    t.integer "place_id_old"
    t.integer "place_id"
    t.integer "place_state_id_old"
    t.integer "place_state_id"
    t.integer "award_year"
  end

  create_table "atd_table_four", :force => true do |t|
    t.string  "authority",   :limit => 50
    t.integer "number"
    t.date    "at"
    t.text    "description"
  end

  create_table "atd_types", :force => true do |t|
    t.string "title", :limit => 50
  end

  create_table "atd_users", :force => true do |t|
    t.string "name", :limit => 30
  end

  create_table "fund_guides", :force => true do |t|
    t.integer "fund_id"
    t.integer "guide_id"
  end

  create_table "fund_rubrics", :force => true do |t|
    t.integer "fund_id"
    t.integer "rubric_id"
  end

  create_table "funds", :force => true do |t|
    t.string  "code",                 :limit => 20
    t.string  "file_t_name",          :limit => 20
    t.string  "title"
    t.integer "amount_of_arch_files"
    t.integer "start_year"
    t.integer "end_year"
    t.text    "description"
    t.integer "archive_id"
  end

  create_table "guides", :force => true do |t|
    t.string  "title"
    t.integer "level_1"
    t.integer "level_2"
    t.integer "level_3"
    t.integer "level_4"
    t.integer "level_5"
    t.string  "comment"
    t.integer "parent_id"
  end

  create_table "inventories", :force => true do |t|
    t.string  "code",                 :limit => 20
    t.string  "title"
    t.integer "start_year"
    t.integer "end_year"
    t.integer "fund_id"
    t.integer "amount_of_arch_files"
    t.text    "description"
    t.integer "copies"
    t.string  "shelf",                :limit => 50
    t.integer "sheafs"
    t.integer "boxes"
    t.string  "photo",                :limit => 500
  end

  create_table "rubrics", :force => true do |t|
    t.string  "title"
    t.integer "level_1"
    t.integer "level_2"
    t.integer "level_3"
    t.integer "level_4"
    t.integer "level_5"
    t.integer "level_6"
    t.string  "comment"
    t.integer "parent_id"
  end

end
