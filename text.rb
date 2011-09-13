class Table < ActiveRecord::Base
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
  { :in_table => 'Т_Архивы', 
    :out_table => 'atd_archives',
    :columns => {
      :id       => 'Код_архива',
      :title    => 'Название',
      :location => 'Место'
    }
  },
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
  }
]
schemes = [
  { :in_table => 'Т_Архивы', 
    :out_table => 'atd_archives',
    :columns => {
      :id       => 'Код_архива',
      :title    => 'Название',
      :location => 'Место'
    }
  },
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
      :file        => 'Дело',
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

puts "\n==== Common =================================================================="
db = AccessDb.new 'c:\Komplex_Arhive_ATD\ATD\Б_Ф_Общ.mdb'
db.open

schemes = [
  { :in_table => 'Т_Дело',
    :out_table => 'files',
    :columns => {
      :id              => 'Код_Дела',
      :number          => 'Номер_Дела',
      :invetnory_id    => 'Код_Описи',
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
