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
      t.string :inventory_text_tmp, :limit => 20
      t.string :arch_file_text_tmp, :limit => 20
    end

    add_index :cards, :arch_file_id
    add_index :cards, :user_id

    create_table :card_labels do |t|
      t.string :title
    end

    %w(person district place organization eparchy rubric regiment).each do |name|

      p_name = name.pluralize

      create_table "card_#{p_name}" do |t|
        t.integer :card_id
        t.integer "#{name}_id"
        t.integer "#{name}_id_old"
        t.integer :user_id
        t.timestamps
      end

      %W(card #{name} user).each do |key|
        add_index "card_#{p_name}", "#{key}_id"
      end
    end

    create_table :users do |t|
      t.string :name
    end
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
      old_users
    ).each {|t| drop_table t}
  end
end
