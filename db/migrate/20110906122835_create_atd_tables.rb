class CreateAtdTables < ActiveRecord::Migration
  def self.up
#  NOTE this table has dublicate in catalog file
#    # Т_Архивы
#    create_table :atd_archives do |t|
#      t.string :title, :limit => 50
#      t.string :location, :limit => 50
#    end

    # Т_ГеоКарта;
    create_table :atd_geo_maps do |t|
      t.string :filename, :limit => 60
      t.integer :wi
      t.integer :wj
      t.integer :x_add
      t.integer :y_add
    end

    # Т_Исполнители
    create_table :atd_users do |t| # FIXME this table must be replaced with global users
      t.string :name, :limit => 30
    end

    # Т_Источн
    create_table :atd_sources do |t|
      t.integer :id_old
      t.string :title, :limit => 50
      t.string :fund, :limit => 50
      t.string :inventory, :limit => 50
      t.string :arch_file, :limit => 50
      t.integer :archive_id
      t.text :description
    end

    # Т_источн_дополнит
    create_table :atd_additional_sources do |t|
      t.string :autor, :limit => 50
      t.string :title, :limit => 250
      t.text :description
      t.integer :year
    end

    # houses #

    # Т_Обьект_Дом
    create_table :atd_houses do |t|
      t.string :title, :limit => 50
      t.integer :place_id_old
      t.integer :place_id # FIXME !!! query
      t.integer :house_type_id
      t.integer :create_year
      t.integer :destroy_year
    end

    # Т_тип_Д_объекта
    create_table :atd_house_types do |t|
      t.string :title, :limit => 50
    end

    # Т_привязка_Д_объектов
    create_table :atd_house_links do |t|
      t.integer :id_old
      t.integer :house1_id_old
      t.integer :house1_id
      t.integer :house_type1_id
      t.integer :house2_id_old
      t.integer :house2_id
      t.integer :house_type2_id
      t.integer :start_year
      t.integer :end_year
      t.boolean :annex
      t.boolean :rename
      t.boolean :separate
      t.boolean :union
    end

    # districts #

    # Т_Обьекты_А
    create_table :atd_districts do |t|
      t.integer :id_old
      t.integer :district_type_id_old
      t.integer :district_type_id
      t.string :title, :limit => 50
      t.integer :start_year
      t.integer :end_year
      t.string :href, :limit => 500
      t.text :description
      t.integer :mark
    end

    # Т_Тип_А
    create_table :atd_district_types do |t|
      t.integer :id_old
      t.string :title, :limit => 50
    end

    # Т_Привязка_А
    create_table :atd_district_links do |t|
      t.integer :id_old
      t.integer :district1_id_old
      t.integer :district1_id
      t.integer :district_type1_id_old
      t.integer :district_type1_id
      t.integer :district2_id_old
      t.integer :district2_id
      t.integer :district_type2_id_old
      t.integer :district_type2_id
      t.integer :start_year
      t.integer :end_year
      t.integer :source_id_old
      t.integer :source_id
      t.boolean :annex
      t.boolean :rename
      t.boolean :separate
      t.boolean :union
      t.string :action
      t.integer :mark
    end

    # Т_Центр_связь
    create_table :atd_center_links do |t|
      t.integer :id_old
      t.integer :district_id_old
      t.integer :district_id
      t.integer :place_id_old
      t.integer :place_id
      t.integer :start_year
      t.integer :end_year
    end

    # places #

    # Т_Обьекты_П
    create_table :atd_places do |t|
      t.integer :id_old
      t.string :title, :limit => 255
      t.integer :start_year
      t.integer :end_year
      t.integer :place_id_old
      t.integer :place_id
      t.string :href, :limit => 500
      t.text :description
      t.string :zipcode, :limit => 30
      t.string :lat, :limit => 50
      t.string :lng, :limit => 50
      t.integer :mark
      t.string :x_top, :limit => 50
      t.string :y_top, :limit => 50
    end

    # Т_привязка_П
    create_table :atd_place_links do |t|
      t.integer :id_old
      t.integer :place_id_old
      t.integer :place_id
      t.integer :district_id_old
      t.integer :district_id
      t.integer :district_type_id_old
      t.integer :district_type_id
      t.integer :start_year
      t.integer :end_year
      t.boolean :annex
      t.boolean :rename
      t.boolean :separate
      t.boolean :union
      t.integer :mark
      t.integer :region
      t.integer :source_id_old
      t.integer :source_id
      t.string :page, :limit => 20
    end

    # Т_Имена_Связь
    create_table :atd_place_name_links do |t|
      t.integer :place1_id_old
      t.integer :place1_id
      t.integer :place2_id_old
      t.integer :place2_id
      t.integer :year
      t.string :sign, :limit => 50
      t.integer :source_id_old
      t.integer :source_id
      t.string :page, :limit => 20
    end

    # Т_Приход
    create_table :atd_parishes do |t|
      t.integer :place_id_old # FIXME !!!query
      t.integer :place_id
      t.integer :house_id_old # FIXME !!!query
      t.integer :house_id
      t.integer :start_year
      t.integer :end_year
    end

    # Т_Статус_П
    create_table :atd_place_states do |t|
      t.integer :id_old
      t.string :title, :limit => 50
    end

    # Т_Статус_связь
    create_table :atd_state_links do |t|
      t.integer :id_old
      t.integer :place_id_old
      t.integer :place_id
      t.integer :place_state_id_old
      t.integer :place_state_id
      t.integer :award_year
    end

    # Т_Тип
    create_table :atd_types do |t| # FIXME unused table?
      t.string :title, :limit => 50
    end

    # Т_Церкви
    create_table :atd_churches do |t|
      t.string :title, :limit => 100
    end

    # Т_Церкви_АТД
    create_table :atd_atd_churches do |t|
      t.string :title, :limit => 100
      t.integer :house_type_id
      t.string :point, :limit => 100
      t.string :atd, :limit => 50
      t.string :deanery, :limit => 50
      t.integer :place_id_old
      t.integer :place_id
    end

    # Т_Церковное_АТД
    create_table :atd_deaneries do |t|
      t.string :title, :limit => 50
      t.string :state, :limit => 50 
    end

    # Таблица4
    create_table :atd_table_four do |t|
      t.string :authority, :limit => 50
      t.integer :number
      t.date :at
      t.text :description
    end
  end

  def self.down
  end
end
