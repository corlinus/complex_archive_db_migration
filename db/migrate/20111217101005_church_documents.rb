class ChurchDocuments < ActiveRecord::Migration
  def self.up
    create_table :church_arch_files do |t|
      t.integer :arch_file_id
      t.integer :organization_id
      t.boolean :doc_type
      t.integer :year
      t.string :rbs, :limit => 15
      t.string :page
      t.integer :user_id

      t.string :rbs_old # remove
      t.integer :fund_id_tmp # remove
      t.string :inventory_text_tmp # remove
      t.string :arch_file_text_tmp # remove
      t.timestamps
    end
  end

  def self.down
    drop_table :church_arch_files
  end
end
