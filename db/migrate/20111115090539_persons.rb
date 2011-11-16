class Persons < ActiveRecord::Migration
  def self.up
    create_table :persons do |t|
      t.string :last_name,  :limit => 50
      t.string :name,       :limit => 50
      t.string :patronymic, :limit => 50
      t.boolean :gender

      t.date :date_of_birth
      t.string :date_of_birth_comment, :limit => 80
      t.boolean :exact_date_of_birth
      t.integer :place_of_birth_id_old
      t.integer :place_of_birth_id
      t.integer :place_of_birth_comment, :limit => 50
      t.integer :district_of_birth_id_old
      t.integer :district_of_birth_id

      t.date :date_of_death
      t.string :date_of_death_comment, :limit => 80
      t.boolean :exact_date_of_death
      t.integer :place_of_death_id
      t.integer :place_of_death_id_old
      t.integer :place_of_death_comment, :limit => 50
      t.integer :district_of_death_id
      t.integer :district_of_death_id_old

      t.integer :mother_id
      t.boolean :foster_mother
      t.integer :father_id
      t.boolean :foster_father

      t.integer :religion_id
      t.string :nationality_old
      t.string :nationality_id
      t.string :citizenship_id
      t.string :citizenship_old
      t.string :title_old
      t.string :title_id

      t.text :description
      t.text :add_sources

      t.integer :executor_id
      t.timestamps
    end

    create_table :religions do |t|
      t.string :title, :limit => 50
    end

    create_table :nationalities do |t|
      t.string :title, :limit => 50
    end

    create_table :citizenships do |t|
      t.string :title, :limit => 50
    end

    create_table :titles do |t|
      t.string :title, :limit => 50
    end

    create_table :person_religions do |t|
      t.integer :person_id
      t.integer :religion_id
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page
      t.date :end_at
      t.integer :end_at_card_id
      t.string :end_at_page
      t.integer :executor_id
      t.timestamps
    end

    create_table :marriages do |t|
      t.string :document_type, :string => 15
      t.datetime :registered_at

      t.integer :place_id
      t.integer :place_id_old
      t.string :place_comment
      t.integer :district_id
      t.integer :district_id_old
      t.integer :organization_id
      t.integer :arch_file_id
      
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
      t.timestamps
    end

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

      t.integer :executor_id
      t.timestamps
    end

    create_table :ranks do |t|
      t.string :title, :limit => 65
      t.string :description, :limit => 150
      t.text :about
    end

    # TODO !!!!
    create_table :person_ranks do |t|
      t.integer :person_id
      t.integer :rank_id
      t.date :start_at
      t.date :end_at
      t.integer :start_at_card_id
      t.integer :end_at_card_id
    end

    create_table :decorations do |t|
      t.string :title, :limit => 80
      t.text :description
    end

    create_table :person_decorations do |t|
      t.integer :person_id
      t.integer :decoration_id
      t.date :award_at
      t.string :service
      t.string :document
      t.integer :card_id
      t.string :page, :limit => 30
      t.integer :executor_id
      t.timestamps
    end

    create_table :residences do |t|
      t.integer :person_id
      t.integer :place_id
      t.date :start_at
      t.integer :staet_at_card_id
      t.date :end_at
      t.integer :end_at_card_id
      t.integer :executor_id
      t.timestamps
    end

    # NOTE new table
    create_table :professions do |t|
      t.string :title, :limit => 50
    end

    # FIXME ???
    create_table :person_professions do |t|
      t.integer :person_id
      t.integer :profession_id
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page, :limit => 30
      t.date :end_at
      t.integer :end_at_card_id
      t.string :endt_at_page, :limit => 30
      t.integer :executor_id
      t.timestamps
    end

    create_table :educations do |t|
      t.integer :person_id
      t.integer :organization_id
      t.date :start_at
      t.integer :start_at_card_id
      t.string :start_at_page, :limit => 30
      t.date :end_at
      t.integer :end_at_card_id
      t.string :endt_at_page, :limit => 30
      t.integer :executor_id
      t.timestamps
    end

    # TODO add all the rest

  end

  def self.down
    %w(
      persons
      religions
      nationalities
      citizenships
      titles
      person_religions
      marriages
      positions
      person_positions
      ranks
      person_ranks
      decorations
      person_decorations
      residences
      professions
      person_professions
      educations
    ).each {|t| drop_table t}
  end
end
