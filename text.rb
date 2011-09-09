
db = AccessDb.new 'C:\Komplex_Arhive_ATD\ATD\atd_base.mdb'
db.open
class Table < ActiveRecord::Base
end

def process_table table_name, indexes, db_data
  delete_old_data = true
  Table.remove_connection
  Table.reset_column_information
  Table.class_eval do
    set_table_name table_name
  end

  Table.delete_all if delete_old_data
  db_data.each do |record|
    attrs = {}
    indexes.each {|k,v| attrs[k] = record[v]}
    Table.create attrs
  end
  puts "#{db_data.size} : #{Table.count}"
end

#-------------------------------------------
#Т_Архивы
table_name = 'atd_archives'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Архивы'
fields = db.fields

indexes = {}
indexes[:id]       = fields.find_index 'Код_архива'
indexes[:title]    = fields.find_index 'Название'
indexes[:location] = fields.find_index 'Место'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_ГеоКарта
table_name = 'atd_geo_maps'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_ГеоКарта'
fields = db.fields

indexes = {}
indexes[:id]       = fields.find_index 'Код_гео'
indexes[:filename] = fields.find_index 'ИмяФайла'
indexes[:wi]       = fields.find_index 'Wi'
indexes[:wj]       = fields.find_index 'Wj'
indexes[:x_add]    = fields.find_index 'X_add'
indexes[:y_add]    = fields.find_index 'Y_add'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Имена_Связь
table_name = 'atd_place_name_links'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Имена_Связь'
fields = db.fields

indexes = {}
indexes[:id]            = fields.find_index 'Код_связь'
indexes[:place1_id_old] = fields.find_index 'Код_пункта_1'
indexes[:place2_id_old] = fields.find_index 'Код_пункта_2'
indexes[:year]          = fields.find_index 'Дата'
indexes[:sign]          = fields.find_index 'Признак'
indexes[:source_id_old] = fields.find_index 'Код_источника'
indexes[:page]          = fields.find_index 'Лист'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Исполнители
table_name = 'atd_users'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Исполнители'
fields = db.fields

indexes = {}
indexes[:id]            = fields.find_index 'Код_исполнителя'
indexes[:name]          = fields.find_index 'Исполнитель'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_источн_дополнит
table_name = 'atd_additional_sources'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_источн_дополнит'
fields = db.fields

indexes = {}
indexes[:id]            = fields.find_index 'Код_книги'
indexes[:autor]         = fields.find_index 'Автор'
indexes[:title]         = fields.find_index 'Название'
indexes[:description]   = fields.find_index 'Описание'
indexes[:year]          = fields.find_index 'Год'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Обьект_Дом
table_name = 'atd_houses'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Обьект_Дом'
fields = db.fields

indexes = {}
indexes[:id]            = fields.find_index 'Код_Дом'
indexes[:title]         = fields.find_index 'Название'
indexes[:place_id_old]  = fields.find_index 'Код_Обьекта_Имя_н'
indexes[:house_type_id] = fields.find_index 'Тип_д_объекта'
indexes[:create_year]   = fields.find_index 'год_образования'
indexes[:destroy_year]  = fields.find_index 'год_ликвидации'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Обьекты_А
table_name = 'atd_districts'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Обьекты_А'
fields = db.fields

indexes = {}
indexes[:id_old]      = fields.find_index 'Код_обьекта'
indexes[:district_type_id_old] = fields.find_index 'Код_тип'
indexes[:title]       = fields.find_index 'Название'
indexes[:start_year]  = fields.find_index 'Год_основания'
indexes[:end_year]    = fields.find_index 'Год_прекращения'
indexes[:href]        = fields.find_index 'Ссылка_пункт'
indexes[:description] = fields.find_index 'Описание'
indexes[:mark]        = fields.find_index 'Метка'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Обьекты_П
table_name = 'atd_places'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Обьекты_П'
fields = db.fields

indexes = {}
indexes[:id_old]      = fields.find_index 'Код_обьекта'
indexes[:title]      = fields.find_index 'Название'
indexes[:start_year]      = fields.find_index 'Год_основания'
indexes[:end_year]      = fields.find_index 'Год_прекращения'
indexes[:place_id_old]      = fields.find_index 'Код_ пункта_слияния'
indexes[:href]      = fields.find_index 'Ссылка_пункт'
indexes[:description]      = fields.find_index 'Описание'
indexes[:zipcode]      = fields.find_index 'Почт_инд'
indexes[:lat]      = fields.find_index 'Широта'
indexes[:lng]      = fields.find_index 'Долгота'
indexes[:mark]      = fields.find_index 'Метка'
indexes[:x_top]      = fields.find_index 'XTop'
indexes[:y_top]      = fields.find_index 'YTop'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Привязка_А
table_name = 'atd_district_links'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Привязка_А'
fields = db.fields

indexes = {}
indexes[:id_old] = fields.find_index 'Код_привязки_вверх'
indexes[:district1_id_old] = fields.find_index 'Код_обьекта'
indexes[:district_type1_id_old] = fields.find_index 'Код_тип0'
indexes[:district2_id_old] = fields.find_index 'Код_вверх'
indexes[:district_type2_id_old] = fields.find_index 'Код_тип1'
indexes[:start_year]       = fields.find_index 'Год_начала_привязки'
indexes[:end_year]         = fields.find_index 'Год_конца_привязки'
indexes[:source_id_old]    = fields.find_index 'Код_источника'
indexes[:annex]            = fields.find_index 'Вхождение'
indexes[:rename]           = fields.find_index 'Переименовка'
indexes[:separate]         = fields.find_index 'Раздел'
indexes[:union]            = fields.find_index 'Обьединение'
indexes[:action]           = fields.find_index 'Что_сделано'
indexes[:mark]             = fields.find_index 'МеткаС'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_привязка_П
table_name = 'atd_place_links'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_привязка_П'
fields = db.fields

indexes = {}
indexes[:id_old]          = fields.find_index 'Код_привязки_вверх'
indexes[:place_id_old]    = fields.find_index 'Код_обьекта'
indexes[:district_id_old] = fields.find_index 'Код_вверх'
indexes[:district_type_id_old] = fields.find_index 'Код_тип1'
indexes[:start_year]      = fields.find_index 'Год_начала_привязки'
indexes[:end_year]        = fields.find_index 'Год_конца_привязки'
indexes[:annex]           = fields.find_index 'Вхождение'
indexes[:rename]          = fields.find_index 'Переименовка'
indexes[:separate]        = fields.find_index 'Раздел'
indexes[:union]           = fields.find_index 'Обьединение'
indexes[:mark]            = fields.find_index 'МеткаС'
indexes[:region]          = fields.find_index 'РегионА'
indexes[:source_id_old]   = fields.find_index 'Код_источника'
indexes[:page]            = fields.find_index 'Лист'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Приход
table_name = 'atd_parishes'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Приход'
fields = db.fields

indexes = {}
indexes[:id]       = fields.find_index 'Код_приход'
indexes[:place_id_old] = fields.find_index 'Код_Обьекта_н'
indexes[:house_id_old] = fields.find_index 'код_объекта_дом_0'
indexes[:start_year]   = fields.find_index 'год_начала'
indexes[:end_year]     = fields.find_index 'год_конца'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Статус_П
table_name = 'atd_place_states'
puts 'Converting ' + table_name
db.query 'SELECT * FROM Т_Статус_П'
fields = db.fields

indexes = {}
indexes[:id_old]       = fields.find_index 'Код_статус'
indexes[:title]       = fields.find_index 'Наименование'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Статус_связь
table_name = 'atd_state_links'
db.query 'SELECT * FROM Т_Статус_связь'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id_old]             = fields.find_index 'Код_записи'
indexes[:place_id_old]       = fields.find_index 'Код_пункта'
indexes[:place_state_id_old] = fields.find_index 'Код_статус'
indexes[:award_year]         = fields.find_index 'Год_присвоения'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Тип
table_name = 'atd_types'
db.query 'SELECT * FROM Т_Тип'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id]    = fields.find_index 'Код_тип'
indexes[:title] = fields.find_index 'Тип'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Тип_А
table_name = 'atd_district_types'
db.query 'SELECT * FROM Т_Тип_А'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id_old] = fields.find_index 'Код_типа'
indexes[:title]  = fields.find_index 'Тип'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_тип_Д_объекта
table_name = 'atd_houses'
db.query 'SELECT * FROM Т_тип_Д_объекта'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id]       = fields.find_index 'код_типа_д_объекта'
indexes[:title]       = fields.find_index 'Тип_Д'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Церкви
table_name = 'atd_churches'
db.query 'SELECT * FROM Т_Церкви'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id]       = fields.find_index 'Код_церкви'
indexes[:title]       = fields.find_index 'Название'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Церкви_АТД
table_name = 'atd_atd_churches'
db.query 'SELECT * FROM Т_Церкви_АТД'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id]            = fields.find_index 'код'
indexes[:title]         = fields.find_index 'Название'
indexes[:house_type_id] = fields.find_index 'Тип_д_объекта'
indexes[:point]         = fields.find_index 'Пункт'
indexes[:atd]           = fields.find_index 'АТД'
indexes[:deanery]       = fields.find_index 'Благочиние'
indexes[:place_id_old]  = fields.find_index 'Код_Обьекта_н'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Церковное_АТД
table_name = 'atd_deaneries'
db.query 'SELECT * FROM Т_Церковное_АТД'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id]    = fields.find_index 'Код_Ц_АТД'
indexes[:title] = fields.find_index 'Название_Ц_АТД'
indexes[:state] = fields.find_index 'Статус_Ц_АТД'

process_table table_name, indexes, db.data

#-------------------------------------------
#Таблица4
table_name = 'atd_table_four'
db.query 'SELECT * FROM Таблица4'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id]          = fields.find_index 'Код'
indexes[:authority]   = fields.find_index 'Орган'
indexes[:number]      = fields.find_index 'Номер'
indexes[:at]          = fields.find_index 'Дата'
indexes[:description] = fields.find_index 'Текст'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Источн
table_name = 'atd_sources'
db.query 'SELECT * FROM Т_Источн'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id_old]     = fields.find_index 'Код_источника'
indexes[:title]      = fields.find_index 'Название'
indexes[:fund]       = fields.find_index 'Фонд'
indexes[:inventory]  = fields.find_index 'Опись'
indexes[:file]       = fields.find_index 'Дело'
indexes[:archive_id] = fields.find_index 'Архив'
indexes[:description]= fields.find_index 'Описание'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_привязка_Д_объектов
table_name = 'atd_house_links'
db.query 'SELECT * FROM Т_привязка_Д_объектов'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id_old]         = fields.find_index 'Код_привязки_Д'
indexes[:house1_id_old]  = fields.find_index 'код_объекта_дом_0'
indexes[:house_type1_id] = fields.find_index 'код_тип_Д_0'
indexes[:house2_id_old]  = fields.find_index 'код_вверх'
indexes[:house_type2_id] = fields.find_index 'код_тип_Д_1'
indexes[:start_year]     = fields.find_index 'год_начала'
indexes[:end_year]       = fields.find_index 'год_конца'
indexes[:annex]          = fields.find_index 'Вхождение'
indexes[:rename]         = fields.find_index 'Переименование'
indexes[:separate]       = fields.find_index 'Раздел'
indexes[:union]          = fields.find_index 'Обьединение'

process_table table_name, indexes, db.data

#-------------------------------------------
#Т_Центр_связь
table_name = 'atd_center_links'
db.query 'SELECT * FROM Т_Центр_связь'
puts 'Converting ' + table_name
fields = db.fields

indexes = {}
indexes[:id_old]          = fields.find_index 'Код_центр'
indexes[:district_id_old] = fields.find_index 'Код_регион'
indexes[:place_id_old]    = fields.find_index 'Код_столица'
indexes[:start_year]      = fields.find_index 'Дата_начала'
indexes[:end_year]        = fields.find_index 'Дата_конца'

process_table table_name, indexes, db.data

