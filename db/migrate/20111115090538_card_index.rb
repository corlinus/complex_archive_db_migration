class CardIndex < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.integer :arch_file_id
      t.text :description
      t.string :page, :limit => 50
      t.string :card_date, :limit => 50
      t.integer :card_label_id
      t.string :photo, :limit => 500
      t.integer :mark
      t.integer :user_id
      t.timestamps

      t.integer :fund_id_tmp
      t.string :invenory_text_tmp, :limit => 20
      t.string :arch_file_text_tmp, :limit => 20
    end

    add_index :cards, :arch_file_id
    add_index :cards, :user_id

    create_table :card_labels do |t|
      t.string :title
    end

    create_table :card_people do |t|
      t.integer :card_id
      t.integer :person_id
      t.integer :user_id
      t.timestamps
    end

    add_index :card_people, :card_id
    add_index :card_people, :person_id
    add_index :card_people, :user_id

    create_table :card_districts do |t|
      t.integer :card_id
      t.integer :district_id_old
      t.integer :district_id
      t.integer :user_id
      t.timestamps
    end

    add_index :card_districts, :card_id
    add_index :card_districts, :district_id
    add_index :card_districts, :user_id

    create_table :card_places do |t|
      t.integer :card_id
      t.integer :place_id_old
      t.integer :place_id
      t.integer :place_comment
      t.integer :user_id
      t.timestamps
    end

    add_index :card_places, :card_id
    add_index :card_places, :place_id
    add_index :card_places, :user_id

    create_table :card_organizations do |t|
      t.integer :card_id
      t.integer :organization_id
      t.integer :user_id
      t.timestamps
    end

    add_index :card_organizations, :card_id
    add_index :card_organizations, :organization_id
    add_index :card_organizations, :user_id

    create_table :card_eparchies do |t|
      t.integer :card_id
      t.integer :eparchy_id
      t.integer :user_id
      t.timestamps
    end

    add_index :card_eparchies, :card_id
    add_index :card_eparchies, :eparchy_id
    add_index :card_eparchies, :user_id

    create_table :card_rubrics do |t|
      t.integer :card_id
      t.integer :rubric_id
      t.integer :user_id
      t.timestamps
    end

    add_index :card_rubrics, :card_id
    add_index :card_rubrics, :rubric_id
    add_index :card_rubrics, :user_id
  end

  def self.down
    %w(
      cards
      card_labels
      card_people
      card_districts
      card_places
      card_organizations
      card_eparchies
      card_rubrics
    ).each {|t| drop_table t}
  end
end
