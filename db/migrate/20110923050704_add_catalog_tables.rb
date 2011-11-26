class AddCatalogTables < ActiveRecord::Migration
  def self.up
    create_table :funds do |t|
      t.string :code, :limit => 20
      t.string :title, :limit => 255
      t.integer :amount_of_arch_files
      t.integer :start_year
      t.integer :end_year
      t.text :description
      t.integer :archive_id
      t.integer :user_id
      t.timestamps
    end

    add_index :funds, :code
    add_index :funds, :user_id

    create_table :archives do |t|
      t.string :title, :limit => 50
      t.string :location, :limit => 50
    end

    create_table :rubrics do |t|
      t.string :title, :limit => 255
      t.string :code, :limit => 20
      t.integer :level_1
      t.integer :level_2
      t.integer :level_3
      t.integer :level_4
      t.integer :level_5
      t.integer :level_6
      t.string :comment, :limit => 255
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
    end

    add_index :rubrics, [:parent_id, :lft, :rgt]
    add_index :rubrics, [:lft, :rgt]

    create_table :fund_rubrics do |t|
      t.integer :fund_id
      t.integer :rubric_id
      t.integer :user_id
      t.timestamps
    end

    add_index :fund_rubrics, :fund_id
    add_index :fund_rubrics, :rubric_id
    add_index :fund_rubrics, :user_id

    create_table :guides do |t|
      t.string :title, :limit => 255
      t.string :code, :limit => 20
      t.integer :level_1
      t.integer :level_2
      t.integer :level_3
      t.integer :level_4
      t.integer :level_5
      t.string :comment, :limit => 255
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
    end

    add_index :guides, [:parent_id, :lft, :rgt]
    add_index :guides, [:lft, :rgt]

    create_table :fund_guides do |t|
      t.integer :fund_id
      t.integer :guide_id
      t.integer :user_id
      t.timestamps
    end

    add_index :fund_guides, :fund_id
    add_index :fund_guides, :guide_id
    add_index :fund_guides, :user_id

    create_table :inventories do |t|
      t.string :code, :limit => 20
      t.string :title, :limit => 255
      t.integer :start_year
      t.integer :end_year
      t.integer :fund_id
      t.integer :amount_of_arch_files
      t.text :description
      t.integer :copies
      t.string :shelf, :limit => 50
      t.integer :sheafs
      t.integer :boxes
      t.string :photo, :limit => 500
      t.integer :user_id
      t.timestamps
    end

    add_index :inventories, :fund_id
    add_index :inventories, :user_id

    create_table :arch_files do |t|
      t.string :code, :limit => 20
      t.integer :inventory_id
      t.integer :fund_id
      t.text :title
      t.integer :amount_of_pages
      t.string :safety_mark_old, :limit => 50
      t.integer :safety_mark_id
      t.string :uniqueness_mark_old, :limit => 50
      t.string :uniqueness_mark_id, :limit => 50
      t.text :toc
      t.integer :start_year
      t.integer :end_year
      t.boolean :title_changed
      t.string :photo, :limit => 500
      t.string :accurate_date
      t.integer :user_id
      t.timestamps
    end

    add_index :arch_files, :inventory_id
    add_index :arch_files, :user_id

    create_table :safety_marks do |t|
      t.string :title, :limit => 50
    end

    create_table :uniqueness_marks do |t|
      t.string :title, :limit => 50
    end
  end

  def self.down
  end
end
