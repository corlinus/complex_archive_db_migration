class AddCatalogTables < ActiveRecord::Migration
  def self.up
    create_table 'funds' do |t|
      t.string :code, :limit => 20
      t.string :file_t_name, :limit => 20
      t.string :title, :limit => 255
      t.integer :amount_of_arch_files
      t.integer :start_year
      t.integer :end_year
      t.text :description
      t.integer :archive_id
    end

    create_table 'archives' do |t|
      t.string :title, :limit => 50
      t.string :location, :limit => 50
    end

    create_table 'rubrics' do |t|
      t.string :title, :limit => 255
      t.integer :level_1
      t.integer :level_2
      t.integer :level_3
      t.integer :level_4
      t.integer :level_5
      t.integer :level_6
      t.string :comment, :limit => 255
      t.integer :parent_id
      #t.integer :lft
      #t.integer :rgt
    end

    create_table 'fund_rubrics' do |t|
      t.integer :fund_id
      t.integer :rubric_id
    end

    create_table 'guides' do |t|
      t.string :title, :limit => 255
      t.integer :level_1
      t.integer :level_2
      t.integer :level_3
      t.integer :level_4
      t.integer :level_5
      t.string :comment, :limit => 255
      t.integer :parent_id
      #t.integer :lft
      #t.integer :rgt
    end

    create_table 'fund_guides' do |t|
      t.integer :fund_id
      t.integer :guide_id
    end

    create_table 'inventories' do |t|
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
    end

    create_table :arch_files do |t|
      t.string :code, :limit => 20
      t.integer :invetnory_id
      t.integer :fund_id
      t.text :title
      t.integer :amount_of_pages
      t.string :state, :limit => 50
      t.string :mark, :limit => 50
      t.text :toc
      t.integer :start_year
      t.integer :end_year
      t.boolean :title_changed
      t.string :photo, :limit => 500
      t.integer :executor
      t.datetime :at
      t.datetime :accurate_at
    end
  end

  def self.down
  end
end
