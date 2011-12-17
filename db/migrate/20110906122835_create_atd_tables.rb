class CreateAtdTables < ActiveRecord::Migration
  def self.up
    # Т_Источн
    create_table :sources do |t|
      t.integer :id_old
      t.string :title, :limit => 50
      t.string :fund, :limit => 50
      t.string :inventory, :limit => 50
      t.string :arch_file, :limit => 50
      t.integer :archive_id
      t.text :description
      t.integer :user_id
      t.timestamps
    end

    # Т_источн_дополнит
    create_table :additional_sources do |t|
      t.string :autor, :limit => 50
      t.string :title, :limit => 250
      t.text :description
      t.integer :year
      t.timestamps
    end

    # organizations #

    # Т_Обьект_Дом
    create_table :organizations do |t|
      t.string :type, :limit => 15
      t.string :title, :limit => 50
      t.integer :place_id_old
      t.integer :place_id
      t.integer :organization_type_id
      t.integer :start_year
      t.integer :end_year
      t.integer :start_year_source_id
      t.integer :end_year_source_id
      t.integer :user_id
      t.timestamps
    end

    add_index :organizations, [:place_id, :type]
    add_index :organizations, :organization_type_id
    add_index :organizations, :user_id

    # Т_тип_Д_объекта
    create_table :organization_types do |t|
      t.string :title, :limit => 50
      t.string :subtype, :limit => 10, :default => 'org'
      t.string :in_list, :limit => 10, :default => 'other'
    end

    # Т_привязка_Д_объектов
    create_table :organization_links do |t|
      t.integer :id_old
      t.integer :organization_id_old
      t.integer :organization_id
      t.integer :organization_type_id
      t.integer :organization1_id_old
      t.integer :organization1_id
      t.integer :organization_type1_id
      t.integer :start_year
      t.integer :end_year
      t.integer :start_year_source_id
      t.integer :end_year_source_id
      t.boolean :annex
      t.boolean :rename
      t.boolean :separate
      t.boolean :union
      t.integer :user_id
      t.timestamps
    end

    add_index :organization_links, :organization_id
    add_index :organization_links, :organization1_id
    add_index :organization_links, :user_id

    # districts #

    # Т_Обьекты_А
    create_table :districts do |t|
      t.integer :id_old
      t.integer :district_type_id_old
      t.integer :district_type_id
      t.string :title, :limit => 50
      t.integer :start_year
      t.integer :end_year
      t.integer :start_year_source_id
      t.integer :end_year_source_id
      t.string :href, :limit => 500
      t.text :description
      t.integer :mark
      t.integer :user_id
      t.timestamps
    end

    add_index :districts, :district_type_id
    add_index :districts, :user_id

    # Т_Тип_А
    create_table :district_types do |t|
      t.integer :id_old
      t.string :title, :limit => 50
    end

    # Т_Привязка_А
    create_table :district_links do |t|
      t.integer :id_old
      t.integer :district_id_old
      t.integer :district_id
      t.integer :district_type_id_old
      t.integer :district_type_id
      t.integer :district1_id_old
      t.integer :district1_id
      t.integer :district_type1_id_old
      t.integer :district_type1_id
      t.integer :district2_id
      t.integer :start_year
      t.integer :end_year
      t.integer :source_id_old
      t.integer :source_id
      t.boolean :annex
      t.boolean :rename
      t.boolean :separate
      t.boolean :union
      t.string :action, :limit => 50
      t.integer :mark
      t.integer :user_id
      t.timestamps
    end

    add_index :district_links, :district_id
    add_index :district_links, :district1_id
    add_index :district_links, :user_id

    # Т_Центр_связь
    create_table :center_links do |t|
      t.integer :id_old
      t.integer :district_id_old
      t.integer :district_id
      t.integer :place_id_old
      t.integer :place_id
      t.integer :start_year
      t.integer :end_year
      t.integer :source_id
      t.integer :user_id
      t.timestamps
    end

    add_index :center_links, :district_id
    add_index :center_links, :place_id
    add_index :center_links, :user_id

    # places #

    # Т_Обьекты_П
    create_table :places do |t|
      t.integer :id_old
      t.string :title, :limit => 255
      t.integer :start_year
      t.integer :end_year
      t.integer :start_year_source_id
      t.integer :end_year_source_id
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
      t.integer :user_id
      t.timestamps
    end

    add_index :places, :place_id
    add_index :places, :user_id

    # Т_привязка_П
    create_table :place_links do |t|
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
      t.integer :user_id
      t.timestamps
    end

    add_index :place_links, :place_id
    add_index :place_links, :district_id
    add_index :place_links, :user_id

    # Т_Имена_Связь
    create_table :place_name_links do |t|
      t.integer :place_id_old
      t.integer :place_id
      t.integer :place1_id_old
      t.integer :place1_id
      t.integer :place2_id
      t.integer :year
      t.string :action, :limit => 50
      t.integer :source_id_old
      t.integer :source_id
      t.string :page, :limit => 20
      t.integer :user_id
      t.timestamps
    end

    add_index :place_name_links, :place_id
    add_index :place_name_links, :place1_id
    add_index :place_name_links, :place2_id
    add_index :place_name_links, :user_id

    # Т_Приход
    create_table :parishes do |t|
      t.integer :place_id_old # FIXME !!!query
      t.integer :place_id
      t.integer :organization_id_old # FIXME !!!query
      t.integer :organization_id
      t.integer :start_year
      t.integer :end_year
      t.integer :start_year_source_id
      t.integer :end_year_source_id
      t.integer :user_id
      t.timestamps
    end

    add_index :parishes, :place_id
    add_index :parishes, :organization_id
    add_index :parishes, :user_id

    # Т_Статус_П
    create_table :place_states do |t|
      t.integer :id_old
      t.string :title, :limit => 50
    end

    # Т_Статус_связь
    create_table :state_links do |t|
      t.integer :id_old
      t.integer :place_id_old
      t.integer :place_id
      t.integer :place_state_id_old
      t.integer :place_state_id
      t.integer :award_year
      t.integer :source_id
      t.integer :user_id
      t.timestamps
    end

    add_index :state_links, :place_id
    add_index :state_links, :user_id

    # Т_Тип
    create_table :atd_types do |t| # FIXME unused table?
      t.string :title, :limit => 50
    end

    # Т_Церкви
    create_table :churches do |t|
      t.string :title, :limit => 100
    end

    # Т_Церкви_АТД
    create_table :atd_churches do |t|
      t.string :title, :limit => 100
      t.integer :organization_type_id
      t.string :point, :limit => 100
      t.string :atd, :limit => 50
      t.string :deanery, :limit => 50
      t.integer :place_id_old
      t.integer :place_id
      t.timestamps
    end

    # Т_Церковное_АТД
    create_table :deaneries do |t|
      t.string :title, :limit => 50
      t.string :state, :limit => 50 
    end

    # Таблица4
    create_table :table_four do |t|
      t.string :authority, :limit => 50
      t.integer :number
      t.date :at
      t.text :description
    end
  end

  def self.down
  end
end
