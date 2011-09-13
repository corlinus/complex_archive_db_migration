class AddFilesTable < ActiveRecord::Migration
  def self.up
    create_table :files do |t|
      t.string :number, :limit => 20
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
