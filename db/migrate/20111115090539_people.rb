class People < ActiveRecord::Migration
  def self.up
    create_table :human_names do |t|
      t.string :name
      t.string :gender_old
      t.boolean :gender
    end

    create_table :people do |t|
      t.string :full_name
      t.string :last_name,  :limit => 50
      t.string :last_name_comment
      t.string :name,       :limit => 50
      t.string :patronymic, :limit => 50
      t.string :gender_old
      t.boolean :gender
      t.date :date_of_birth
      t.string :date_of_birth_comment, :limit => 80
      t.boolean :exact_date_of_birth
      t.integer :place_of_birth_id_old
      t.integer :place_of_birth_id
      t.integer :place_of_birth_comment, :limit => 50
      t.boolean :exact_place_of_birth
      t.date :date_of_death
      t.string :date_of_death_comment, :limit => 80
      t.boolean :exact_date_of_death
      t.integer :place_of_death_id_old
      t.integer :place_of_death_id
      t.integer :place_of_death_comment, :limit => 50
      t.boolean :exact_place_of_death
      t.integer :mother_id
      t.boolean :foster_mother
      t.integer :father_id
      t.boolean :foster_father
      t.integer :religion_id
      t.string :nationality_old
      t.string :nationality_id
      t.string :citizenship_old
      t.string :citizenship_id
      t.string :title_old
      t.string :title_id
      t.text :description
      t.text :add_sources
      t.integer :user_id
      t.timestamps
    end

    add_index :people, :full_name
    add_index :people, :last_name
    add_index :people, :name
    add_index :people, :gender
    add_index :people, :mother_id
    add_index :people, :father_id
    add_index :people, :user_id

    create_table :religions do |t|
      t.string :title, :limit => 50
    end

    # NOTE new
    create_table :nationalities do |t|
      t.string :title, :limit => 50
    end

    # NOTE new
    create_table :citizenships do |t|
      t.string :title, :limit => 50
    end

    # NOTE new
    create_table :titles do |t|
      t.string :title, :limit => 50
    end

    # NOTE new
    create_table :person_religions do |t|
      t.integer :person_id
      t.integer :religion_id
      t.integer :start_year
      t.integer :start_year_card_id
      t.string :start_year_page
      t.integer :end_year
      t.integer :end_year_card_id
      t.string :end_year_page
      t.integer :user_id
      t.timestamps
    end

    add_index :person_religions, :person_id
    add_index :person_religions, :user_id


    create_table :marriages do |t|
      t.string :document_type, :limit => 15
      t.date :registered_at
      t.date :divorced_at
      t.integer :place_id_old
      t.integer :place_id
      t.string :place_comment
      t.integer :district_id_old
      t.integer :district_id
      t.integer :organization_id
      t.integer :arch_file_id
      t.string :page
      t.string :registry_office, :limit => 80
      t.string :certificate, :limit => 50
      t.integer :bridegroom_id
      t.integer :bridegroom_age
      t.integer :bridegroom_marriages
      t.string :bridegroom_comment
      t.integer :bride_id
      t.integer :bride_age
      t.integer :bride_marriages
      t.string :bride_comment
      t.integer :bridegroom_guarantor1_id
      t.integer :bridegroom_guarantor2_id
      t.integer :bride_guarantor1_id
      t.integer :bride_guarantor2_id
      t.integer :user_id
      t.timestamps
    end

    add_index :marriages, :bridegroom_id
    add_index :marriages, :bride_id
    add_index :marriages, :place_id
    add_index :marriages, :district_id
    add_index :marriages, :organization_id
    add_index :marriages, :user_id

    create_table :births do |t|
      t.integer :person_id
      t.string :document_type, :limit => 15
      t.date :christened_at
      t.date :registered_at
      t.integer :organization_id
      t.integer :arch_file_id
      t.string :document_code, :limit => 50
      t.boolean :legitimate, :default => true
      t.boolean :founded, :default => false
      t.integer :godfather_id
      t.integer :godmother_id
      t.string :comment
      t.integer :user_id
      t.timestamps
    end

    add_index :births, :person_id
    add_index :births, :arch_file_id
    add_index :births, :user_id

    create_table :deaths do |t|
      t.integer :person_id
      t.integer :arch_file_id
      t.integer :organization_id
      t.string :document_code, :limit => 50
      t.integer :age
      t.integer :cause_of_death_id
      t.string :comment, :limit => 100
      t.integer :user_id
      t.timestamps
    end

    add_index :deaths, :person_id
    add_index :deaths, :arch_file_id
    add_index :deaths, :user_id

    create_table :death_causes do |t|
      t.string :title, :limit => 50
    end

    create_table :revisions do |t|
      t.date :revision_date
      t.integer :place_id
      t.integer :district_id_old
      t.integer :district_id
      t.integer :arch_file_id
      t.integer :person_id
      t.integer :user_id
      t.timestamps
    end

    add_index :revisions, :person_id
    add_index :revisions, :arch_file_id
    add_index :revisions, :user_id

    create_table :positions do |t|
      t.string :title, :limit => 60
    end

    create_table :person_positions do |t|
      t.integer :person_id
      t.integer :organization_id
      t.integer :position_id
      t.date :start_at
      t.date :end_at
      t.integer :start_at_card_id
      t.integer :end_at_card_id
      t.integer :user_id
      t.timestamps
    end

    add_index :person_positions, :person_id
    add_index :person_positions, :organization_id
    add_index :person_positions, :user_id

    create_table :ranks do |t|
      t.string :title, :limit => 65
      t.string :description, :limit => 150
      t.text :about
    end

    create_table :services do |t|
      t.integer :person_id
      t.integer :rank_id
      t.integer :organization_id
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page
      t.date :end_at
      t.integer :end_at_card_id
      t.string :end_at_page
      t.integer :user_id
      t.timestamps
    end

    add_index :services, :person_id
    add_index :services, :organization_id
    add_index :services, :user_id

    create_table :decorations do |t|
      t.string :title, :limit => 80
      t.text :description
    end

    create_table :person_decorations do |t|
      t.integer :person_id
      t.integer :decoration_id
      t.date :award_at
      t.string :desert
      t.string :order_title
      t.integer :card_id
      t.string :page, :limit => 30
      t.integer :user_id
      t.timestamps
    end

    add_index :person_decorations, :person_id
    add_index :person_decorations, :user_id

    create_table :residences do |t|
      t.integer :person_id
      t.integer :place_id_old
      t.integer :place_id
      t.integer :start_year
      t.integer :start_year_card_id
      t.integer :end_year
      t.integer :end_year_card_id
      t.integer :user_id
      t.timestamps
    end

    add_index :residences, :person_id
    add_index :residences, :place_id
    add_index :residences, :user_id

    # NOTE empty table
    create_table :professions do |t|
      t.string :title, :limit => 50
    end

    # NOTE empty table
    create_table :person_professions do |t|
      t.integer :person_id
      t.integer :profession_id
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page, :limit => 30
      t.date :end_at
      t.integer :end_at_card_id
      t.string :endt_at_page, :limit => 30
      t.integer :user_id
      t.timestamps
    end

    add_index :person_professions, :person_id
    add_index :person_professions, :user_id

    # NOTE new table
    create_table :educations do |t|
      t.integer :person_id
      t.integer :organization_id
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page, :limit => 30
      t.date :end_at
      t.integer :end_at_card_id
      t.string :endt_at_page, :limit => 30
      t.integer :user_id
      t.timestamps
    end

    add_index :educations, :person_id
    add_index :educations, :organization_id
    add_index :educations, :user_id

    create_table :estates do |t|
      t.string :title
      t.text :description
    end

    create_table :person_estates do |t|
      t.integer :person_id
      t.integer :estate_id
      t.string :description
      t.date :start_at
      t.integer :card_id
      t.string :page
      t.integer :user_id
      t.timestamps
    end

    add_index :person_estates, :person_id
    add_index :person_estates, :user_id

    create_table :property_types do |t|
      t.string :title
    end

    create_table :properties do |t|
      t.string :title
      t.integer :property_type_id
    end

    add_index :properties, [:property_type_id, :title]

    create_table :person_properties do |t|
      t.integer :person_id
      t.integer :property_id
      t.integer :place_id
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page
      t.date :end_at
      t.integer :end_at_card_id
      t.string :end_at_page
      t.integer :user_id
      t.timestamps
    end

    add_index :person_properties, :person_id
    add_index :person_properties, :place_id
    add_index :person_properties, :user_id

    create_table :activities do |t|
      t.integer :person_id
      t.string :title
      t.text :description
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page
      t.date :end_at
      t.integer :end_at_card_id
      t.string :end_at_page
      t.integer :user_id
      t.timestamps
    end

    add_index :activities, :person_id
    add_index :activities, :user_id

    create_table :event_types do |t|
      t.string :title
    end

    create_table :events do |t|
      t.string :title
      t.integer :event_type_id
    end

    add_index :events, [:event_type_id, :title]

    create_table :person_events do |t|
      t.integer :person_id
      t.integer :event_id
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page
      t.date :end_at
      t.integer :end_at_card_id
      t.string :end_at_page
      t.integer :user_id
      t.timestamps
    end

    add_index :person_events, :person_id
    add_index :person_events, :user_id
  end

  def self.down
    %w(
      human_names
      people
      religions
      nationalities
      citizenships
      titles
      person_religions
      marriages
      births
      deaths
      death_causes
      revisions
      positions
      person_positions
      ranks
      services
      decorations
      person_decorations
      residences
      professions
      person_professions
      educations
      estates
      person_estates
      property_types
      properties
      person_properties
      activities
      event_types
      events
      person_events
    ).each {|t| drop_table t}
  end
end
