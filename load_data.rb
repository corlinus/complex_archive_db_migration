# encoding: UTF-8
require 'pp'
ActiveRecord::Base.logger.level = Logger::Severity::ERROR

class Table < ActiveRecord::Base
  private
  def self.attributes_protected_by_default; []; end
end
class T0 < ActiveRecord::Base; end
class T1 < ActiveRecord::Base; end
class T2 < ActiveRecord::Base; end
class T3 < ActiveRecord::Base; end
class T4 < ActiveRecord::Base; end
class T5 < ActiveRecord::Base; end
class T6 < ActiveRecord::Base; end
class T7 < ActiveRecord::Base; end
class T8 < ActiveRecord::Base; end
class T9 < ActiveRecord::Base; end
class T10 < ActiveRecord::Base; end
class T11 < ActiveRecord::Base; end
class T12 < ActiveRecord::Base; end
class T13 < ActiveRecord::Base; end

def process_table db, out_table_name, in_table_name, indexes, keep=false
  #puts
  #pp indexes.inspect
  #puts
  set_model Table, out_table_name

  time = nil
  amount = 0
  time = Benchmark.measure do
    print "  in %7d" % 0
    Table.delete_all unless keep
    attrs_collection = []
    cache_size = 1000
    db.each_in_query "SELECT * FROM #{in_table_name}" do |record|
      attrs = {}
      indexes.each {|k,v| attrs[k] = record[v]}
      attrs_collection << attrs
      if attrs_collection.size == cache_size
        write_collection_with_transaction Table, attrs_collection
        print "\b"*7, ("%7d" % amount += attrs_collection.size)
        attrs_collection.clear
      end
    end
    # save last records
    write_collection_with_transaction Table, attrs_collection
    print "\b"*7, ("%7d" % amount += attrs_collection.size)
  end

  Table.connection.execute "SELECT SETVAL('#{out_table_name}_id_seq', MAX(id) ) FROM #{out_table_name}"
  print " : out %7d" % Table.count
  print "  time %.4fs" % time.real
  puts Table.count == amount ? " OK" : " ERR"
  return nil
end

def set_model model, table_name
  model.remove_connection
  model.reset_column_information
  model.class_eval { set_table_name table_name }
end

def write_collection_with_transaction model, attrs_collection
  model.transaction do
    attrs_collection.each do |attrs|
      begin
        model.create attrs
      rescue Exception => e
        puts "Error in data"
        puts attrs[:id]
        raise e
      end
    end
  end
end

def load_table db, scheme
  print "=> %25s" % scheme['out_table']
  db.query 'SELECT * FROM %s' % scheme['in_table'], 1
  fields = db.fields

  indexes = {}
  scheme['columns'].each do |k,v|
    indexes[k] = fields.find_index v
  end

  process_table db, scheme['out_table'], scheme['in_table'], indexes, scheme['keep_present_rows']
end

def test_files schemes
  puts "Testing files"

  mdb_dir = schemes['mdb_dir']
  schemes['process_sections'].each do |key|
    scheme = schemes[key].symbolize_keys

    print " Testing #{key}: #{scheme[:filename]}"
    db = AccessDb.new File.join(mdb_dir, scheme[:filename])
    db.open
    db.close
    print " OK\n"
  end

end

schemes = YAML.load_file('tablemappings.yml')
mdb_dir = schemes['mdb_dir']

test_files schemes
#///////////////////////////////////////////
#  main block
#///////////////////////////////////////////
schemes['process_sections'].each do |f|
  scheme = schemes[f].symbolize_keys

  puts "\n=== #{f}"
  db = AccessDb.new File.join(mdb_dir, scheme[:filename])
  db.open
  scheme[:tables].each {|s| load_table db, s }
  db.close
end

#///////////////////////////////////////////
#  relations block
#///////////////////////////////////////////
puts "\n==== processing relations on atd tables ======================================"
schemes['relations'].each do |table, relations_scheme|
  models = [ T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13 ]

  # prepare main model
  set_model Table, table

  # prepare related models
  relations_scheme.each do |rel_table, descr|
    m = models.shift
    set_model m, rel_table
    descr['model'] = m
  end

  amount = 0
  time = Benchmark.measure do
    Table.all.each do |row|
      relations_scheme.each  do |table, descr|
        descr['cols'].each do |col_name|
          amount += descr['model'].update_all ["#{col_name} = ?", row.id], ["#{col_name}_old = ?", row.id_old]
        end
      end
    end
  end
  puts "=> #{table} found #{amount} relations time %.4fs" % time.real
end

#///////////////////////////////////////////
#  fixing lists columns
#///////////////////////////////////////////
puts "\n==== Updating arch files marks ==============================================="
set_model T0, :safety_marks
T0.destroy_all
[
  "Грибок",
  "Россыпь",
  "Ветхое",
  "Неисправимо поврежденное",
  "Обгорелое",
  "Обгорелое, грибок",
  "Угасающий текст",
  "Грибок, россыпь"
].each {|x| T0.create :title => x }

set_model T1, :uniqueness_marks
T1.destroy_all
[
  "ОЦ",
  "Уникальное",
  "Книга-уникум",
  "ОЦ, оцифровано",
  "Уникальное, оцифровано",
  "Оцифровано"
].each {|x| T1.create :title => x }

set_model Table, :arch_files

total_marks = 0
time = Benchmark.measure do
  T0.all.each do |mark|
    total_marks += Table.update_all ['safety_mark_id = ?', mark.id],
                                    ['lower(safety_mark_old) = lower(?)', mark.title]
  end
end
total = Table.where('safety_mark_old IS NOT NULL').count
puts "=> updated safety marks #{total_marks} total: #{total} time %.4fs" % time.real

total_marks = 0
time = Benchmark.measure do
  T1.all.each do |mark|
    total_marks += Table.update_all ['uniqueness_mark_id = ?', mark.id],
                                    ['lower(uniqueness_mark_old) = lower(?)', mark.title]
  end
end
total = Table.where('uniqueness_mark_old IS NOT NULL').count
puts "=> updated uniqueness marks #{total_marks} total: #{total} time %.4fs" % time.real

set_model T0, :church_arch_files
total_marks = 0
time = Benchmark.measure do
  T0.where(:rbs_old => 'Браки').update_all :rbs => 'marriage'
  T0.where(:rbs_old => 'Рождение').update_all :rbs => 'birth'
  T0.where(:rbs_old => 'Умершие').update_all :rbs => 'death'
end
#///////////////////////////////////////////
#  fixing lists columns
#///////////////////////////////////////////
puts "\n==== Updating genders"
set_model T0, :people
T0.where(:gender_old => 'Муж').update_all :gender => true
T0.where(:gender_old => 'муж').update_all :gender => true
T0.where(:gender => nil).update_all :gender => false

set_model T0, :human_names
T0.where(:gender_old => 'Муж').update_all :gender => true
T0.where(:gender_old => 'муж').update_all :gender => true
T0.where(:gender => nil).update_all :gender => false

#///////////////////////////////////////////
#  removig empty linkages
#///////////////////////////////////////////
puts "\n==== Removing empty linkages"
{
  :card_districts => :district_id,
  :card_places => :place_id,
  :card_organizations => :organization_id,
  :fund_rubrics => :fund_id,
  :fund_rubrics => :rubric_id,
  :fund_guides => :fund_id,
  :fund_guides => :guide_id
}.each do |k,v|
  set_model T0, k
  T0.where(v => nil).destroy_all
end

exit 0
