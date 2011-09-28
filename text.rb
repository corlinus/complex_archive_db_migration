ActiveRecord::Base.logger.level = Logger::Severity::ERROR

class Table < ActiveRecord::Base
  private
  def self.attributes_protected_by_default
    []
  end
end

def process_table db, out_table_name, in_table_name, indexes
  delete_old_data = true
  Table.remove_connection
  Table.reset_column_information
  Table.class_eval do
    set_table_name out_table_name
  end

  time = nil
  time = Benchmark.measure do
    print "  in %7d" % 0
    Table.delete_all if delete_old_data
    attrs_collection = []
    amount = 0
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

  print " : out %7d" % Table.count
  puts "  time %.4fs" % time.real
  return nil
end

def write_collection_with_transaction model, attrs_collection
  model.transaction do
    attrs_collection.each do |attrs|
      model.create attrs
    end
  end
end

def load_table db, scheme
  print "=> %25s" % scheme[:out_table]
  db.query 'SELECT * FROM %s' % scheme[:in_table], 1
  fields = db.fields

  indexes = {}
  scheme[:columns].each do |k,v|
    indexes[k] = fields.find_index v
  end

  process_table db, scheme[:out_table], scheme[:in_table], indexes
end

puts "\n==== ATD ====================================================================="
db = AccessDb.new 'C:\Komplex_Arhive_ATD\ATD\atd_base.mdb'
db.open

schemes = [
  # NOTE this table has dublicate in catalog file
  #{ :in_table => 'Т_Архивы', 
  #  :out_table => 'atd_archives',
  #  :columns => {
  #    :id       => 'Код_архива',
  #    :title    => 'Название',
  #    :location => 'Место'
  #  }
  #},
  { :in_table => 'Т_ГеоКарта',
    :out_table => 'atd_geo_maps',
    :columns => {
      :id       => 'Код_гео',
      :filename => 'ИмяФайла',
      :wi       => 'Wi',
      :wj       => 'Wj',
      :x_add    => 'X_add',
      :y_add    => 'Y_add'
    }
  },
  { :in_table => 'Т_Имена_Связь', 
    :out_table => 'atd_place_name_links', 
    :columns => {
      :id            => 'Код_связь',
      :place1_id_old => 'Код_пункта_1',
      :place2_id_old => 'Код_пункта_2',
      :year          => 'Дата',
      :sign          => 'Признак',
      :source_id_old => 'Код_источника',
      :page          => 'Лист'
    }
  },
  { :in_table => 'Т_Исполнители',
    :out_table => 'atd_users',
    :columns => {
      :id   => 'Код_исполнителя',
      :name => 'Исполнитель'
    }
  },
  { :in_table => 'Т_источн_дополнит',
    :out_table => 'atd_additional_sources',
    :columns => {
      :id          => 'Код_книги',
      :autor       => 'Автор',
      :title       => 'Название',
      :description => 'Описание',
      :year        => 'Год'
    }
  },
  { :in_table => 'Т_Обьект_Дом',
    :out_table => 'atd_houses',
    :columns => {
      :id            => 'Код_Дом',
      :title         => 'Название',
      :place_id_old  => 'Код_Обьекта_Имя_н',
      :house_type_id => 'Тип_д_объекта',
      :create_year   => 'год_образования',
      :destroy_year  => 'год_ликвидации'
    }
  },
  { :in_table => 'Т_Обьекты_А',
    :out_table => 'atd_districts',
    :columns => {
      :id_old               => 'Код_обьекта',
      :district_type_id_old => 'Код_тип',
      :title                => 'Название',
      :start_year           => 'Год_основания',
      :end_year             => 'Год_прекращения',
      :href                 => 'Ссылка_пункт',
      :description          => 'Описание',
      :mark                 => 'Метка'
    }
  },
  { :in_table => 'Т_Обьекты_П',
    :out_table =>'atd_places', 
    :columns => {
      :id_old        => 'Код_обьекта',
      :title         => 'Название',
      :start_year    => 'Год_основания',
      :end_year      => 'Год_прекращения',
      :place_id_old  => 'Код_ пункта_слияния',
      :href          => 'Ссылка_пункт',
      :description   => 'Описание',
      :zipcode       => 'Почт_инд',
      :lat           => 'Широта',
      :lng           => 'Долгота',
      :mark          => 'Метка',
      :x_top         => 'XTop',
      :y_top         => 'YTop'
    }
  },
  { :in_table => 'Т_Привязка_А',
    :out_table => 'atd_district_links',
    :columns => {
      :id_old                => 'Код_привязки_вверх',
      :district1_id_old      => 'Код_обьекта',
      :district_type1_id_old => 'Код_тип0',
      :district2_id_old      => 'Код_вверх',
      :district_type2_id_old => 'Код_тип1',
      :start_year            => 'Год_начала_привязки',
      :end_year              => 'Год_конца_привязки',
      :source_id_old         => 'Код_источника',
      :annex                 => 'Вхождение',
      :rename                => 'Переименовка',
      :separate              => 'Раздел',
      :union                 => 'Обьединение',
      :action                => 'Что_сделано',
      :mark                  => 'МеткаС'
    }
  },
  { :in_table => 'Т_привязка_П',
    :out_table => 'atd_place_links',
    :columns => {
      :id_old                => 'Код_привязки_вверх',
      :place_id_old          => 'Код_обьекта',
      :district_id_old       => 'Код_вверх',
      :district_type_id_old  => 'Код_тип1',
      :start_year            => 'Год_начала_привязки',
      :end_year              => 'Год_конца_привязки',
      :annex                 => 'Вхождение',
      :rename                => 'Переименовка',
      :separate              => 'Раздел',
      :union                 => 'Обьединение',
      :mark                  => 'МеткаС',
      :region                => 'РегионА',
      :source_id_old         => 'Код_источника',
      :page                  => 'Лист'
    }
  },
  { :in_table => 'Т_Приход',
    :out_table => 'atd_parishes',
    :columns => {
      :id           => 'Код_приход',
      :place_id_old => 'Код_Обьекта_н',
      :house_id_old => 'код_объекта_дом_0',
      :start_year   => 'год_начала',
      :end_year     => 'год_конца'
    }
  },
  { :in_table => 'Т_Статус_П',
    :out_table => 'atd_place_states',
    :columns => {
      :id_old => 'Код_статус',
      :title  => 'Наименование'
    }
  },
  { :in_table => 'Т_Статус_связь',
    :out_table => 'atd_state_links',
    :columns => {
      :id_old             => 'Код_записи',
      :place_id_old       => 'Код_пункта',
      :place_state_id_old => 'Код_статус',
      :award_year         => 'Год_присвоения'
    }
  },
  { :in_table => 'Т_Тип',
    :out_table => 'atd_types',
    :columns => {
      :id    => 'Код_тип',
      :title =>'Тип'
    }
  },
  { :in_table => 'Т_Тип_А',
    :out_table => 'atd_district_types',
    :columns => {
      :id_old => 'Код_типа',
      :title  => 'Тип'
    }
  },
  { :in_table => 'Т_тип_Д_объекта',
    :out_table => 'atd_houses',
    :columns => {
      :id    => 'код_типа_д_объекта',
      :title => 'Тип_Д'
    }
  },
  { :in_table => 'Т_Церкви',
    :out_table => 'atd_churches',
    :columns => {
      :id    => 'Код_церкви',
      :title => 'Название'
    }
  },
  { :in_table => 'Т_Церкви_АТД',
    :out_table => 'atd_atd_churches',
    :columns => {
      :id            => 'код',
      :title         => 'Название',
      :house_type_id => 'Тип_д_объекта',
      :point         => 'Пункт',
      :atd           => 'АТД',
      :deanery       => 'Благочиние',
      :place_id_old  => 'Код_Обьекта_н'
    }
  },
  { :in_table => 'Т_Церковное_АТД',
    :out_table => 'atd_deaneries',
    :columns => {
      :id    => 'Код_Ц_АТД',
      :title => 'Название_Ц_АТД',
      :state => 'Статус_Ц_АТД'
    }
  },
  { :in_table => 'Таблица4',
    :out_table => 'atd_table_four',
    :columns => {
      :id          => 'Код',
      :authority   => 'Орган',
      :number      => 'Номер',
      :at          => 'Дата',
      :description => 'Текст'
    }
  },
  { :in_table => 'Т_Источн',
    :out_table => 'atd_sources',
    :columns => {
      :id_old      => 'Код_источника',
      :title       => 'Название',
      :fund        => 'Фонд',
      :inventory   => 'Опись',
      :arch_file   => 'Дело',
      :archive_id  => 'Архив',
      :description => 'Описание'
    }
  },
  { :in_table => 'Т_привязка_Д_объектов',
    :out_table => 'atd_house_links',
    :columns => {
      :id_old         => 'Код_привязки_Д',
      :house1_id_old  => 'код_объекта_дом_0',
      :house_type1_id => 'код_тип_Д_0',
      :house2_id_old  => 'код_вверх',
      :house_type2_id => 'код_тип_Д_1',
      :start_year     => 'год_начала',
      :end_year       => 'год_конца',
      :annex          => 'Вхождение',
      :rename         => 'Переименование',
      :separate       => 'Раздел',
      :union          => 'Обьединение'
    }
  },
  { :in_table => 'Т_Центр_связь',
    :out_table => 'atd_center_links',
    :columns => {
      :id_old          => 'Код_центр',
      :district_id_old => 'Код_регион',
      :place_id_old    => 'Код_столица',
      :start_year      => 'Дата_начала',
      :end_year        => 'Дата_конца'
    }
  },
]

schemes.each {|s| load_table db, s }
db.close

puts "\n==== processing relations on atd tables ======================================"


relations = {
  'atd_districts' => {
    'atd_district_links' => {:cols => [:district1_id, :district2_id]},
    'atd_place_links'    => {:cols => [:district_id]},
    'atd_center_links'   => {:cols => [:district_id]}
  },
  'atd_places' => {
    "atd_atd_churches"     => {:cols => [:place_id]},
    "atd_center_links"     => {:cols => [:place_id]},
    "atd_houses"           => {:cols => [:place_id]},
    "atd_parishes"         => {:cols => [:place_id]},
    "atd_place_links"      => {:cols => [:place_id]},
    "atd_place_name_links" => {:cols => [:place1_id, :place2_id]},
    "atd_places"           => {:cols => [:place_id]},
    "atd_state_links"      => {:cols => [:place_id]}
  },
  'atd_place_states' => {
    "atd_state_links" =>  {:cols => [:place_state_id]}
  },
  'atd_district_types' => {
    "atd_district_links" => {:cols => [:district_type1_id, :district_type2_id]},
    "atd_districts"      => {:cols => [:district_type_id]},
    "atd_place_links"    => {:cols => [:district_type_id]},
  },
  'atd_sources' => {
    "atd_district_links"   => {:cols => [:source_id]},
    "atd_place_links"      => {:cols => [:source_id]},
    "atd_place_name_links" => {:cols => [:source_id]},
  },
#  'atd_district_links' => {},
#  'atd_place_links' => {},
#  'atd_state_links' => {},
#  'atd_house_links' => {},
#  'atd_center_links' => {}
}

class T0 < ActiveRecord::Base; end
class T1 < ActiveRecord::Base; end
class T2 < ActiveRecord::Base; end
class T3 < ActiveRecord::Base; end
class T4 < ActiveRecord::Base; end
class T5 < ActiveRecord::Base; end
class T6 < ActiveRecord::Base; end
class T7 < ActiveRecord::Base; end

relations.each do |table, relations_scheme|
  models = [ T0, T1, T2, T3, T4, T5, T6, T7 ]
  # prepare main model
  Table.remove_connection
  Table.reset_column_information
  Table.class_eval do
    set_table_name table
  end

  # prepare related models
  relations_scheme.each do |rel_table, descr|
    m = models.shift
    m.remove_connection
    m.reset_column_information
    m.class_eval { set_table_name rel_table }

    descr[:model] = m
  end

  amount = 0
  time = Benchmark.measure do
    Table.all.each do |row|
      relations_scheme.each  do |table, descr|
        descr[:cols].each do |col_name|
          amount += descr[:model].update_all ["#{col_name} = ?", row.id], ["#{col_name}_old = ?", row.id_old]
        end
      end
    end
  end
  puts "=> #{table} find #{amount} relations time %.4fs" % time.real
end

puts "\n==== Common =================================================================="
db = AccessDb.new 'c:\Komplex_Arhive_ATD\ATD\Б_Ф_Общ.mdb'
db.open

schemes = [
  { :in_table => 'Т_Дело',
    :out_table => 'arch_files',
    :columns => {
      :id              => 'Код_Дела',
      :code            => 'Номер_Дела',
      :inventory_id    => 'Код_Описи',
      :fund_id         => 'Код_фонда',
      :title           => 'Наименование_дела',
      :amount_of_pages => 'Кол-во_листов',
      :state           => 'Физич_состояние',
      :mark            => 'Отметка',
      :toc             => 'Содержание',
      :start_year      => 'Год_начала',
      :end_year        => 'Год_конца',
      :title_changed   => 'Заголовок_Изменен',
      :photo           => 'Фото',
      :executor        => 'Исполнитель',
      :at              => 'Дата',
      :accurate_at     => 'Точная_дата'
    }
  }
]

schemes.each {|s| load_table db, s }
db.close

puts "\n==== Catalog ================================================================="
db = AccessDb.new 'c:\Komplex_Arhive_ATD\ATD\Комплекс_Каталог.mdb'
db.open

schemes = [
  { :in_table => 'Т_Фонд',
    :out_table => 'funds',
    :columns => {
      :id                   => 'Код_фонда',
      :code                 => 'Номер_фонда',
      :file_t_name          => 'Имя_Т_Дела',
      :title                => 'Наименование_фонда',
      :amount_of_arch_files => 'Число_дел',
      :start_year           => 'Год_начала',
      :end_year             => 'Год_конца',
      :description          => 'Аннотация',
      :archive_id           => 'Код_Архива'
    }
  },
  { :in_table => 'Т_Архивы', 
    :out_table => 'archives',
    :columns => {
      :id       => 'Код_архива',
      :title    => 'Название',
      :location => 'Место'
    }
  },
  { :in_table => 'Т_Рубрики', 
    :out_table => 'rubrics',
    :columns => {
      :id        => 'Код_рубрики',
      :title     => 'Название',
      :level_1   => 'Уровень_1',
      :level_2   => 'Уровень_2',
      :level_3   => 'Уровень_3',
      :level_4   => 'Уровень_4',
      :level_5   => 'Уровень_5',
      :level_6   => 'Уровень_6',
      :comment   => 'Добавление',
      :parent_id => 'Вхождение'
    }
  },
  { :in_table => 'Т_фонд_рубрики', 
    :out_table => 'fund_rubrics',
    :columns => {
      :fund_id   => 'Код_фонда',
      :rubric_id => 'Код_рубрики'
    }
  },
  { :in_table => 'Т_Путеводитель', 
    :out_table => 'guides',
    :columns => {
      :id        => 'Код_рубрики',
      :title     => 'Название',
      :level_1   => 'Уровень_1',
      :level_2   => 'Уровень_2',
      :level_3   => 'Уровень_3',
      :level_4   => 'Уровень_4',
      :level_5   => 'Уровень_5',
      :comment   => 'Добавление',
      :parent_id => 'Вхождение'
    }
  },
  { :in_table => 'Т_Фонд_Путеводитель', 
    :out_table => 'fund_guides',
    :columns => {
      :fund_id  => 'Код_фонда',
      :guide_id => 'Код_рубрики'
    }
  },
  { :in_table => 'Т_Описи', 
    :out_table => 'inventories',
    :columns => {
      :id                   => 'Код_Описи',
      :code                 => 'Номер_Описи',
      :title                => 'Название_описи',
      :start_year           => 'Год_начала',
      :end_year             => 'Год_конца',
      :fund_id              => 'Код_фонда',
      :amount_of_arch_files => 'Кол_дел',
      :description          => 'Аннотация',
      :copies               => 'Кол_экземп',
      :shelf                => 'Полка',
      :sheafs               => 'Кол_связок',
      :boxes                => 'Кол_коробок',
      :photo                => 'Фото'
    }
  }
]

schemes.each {|s| load_table db, s }
db.close
nil
