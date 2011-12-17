class ChurchDocuments < ActiveRecord::Migration
  def self.up
    add_table :church_arch_files do |t|
      t.integer :arch_file_id
      t.integer :organization_id
      t.boolean :doc_type
      t.integer :year
      t.string :rbs_old
      t.string :rbs, :limit => 15
      t.string :page
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    remove_table :church_arch_files
  end
end
