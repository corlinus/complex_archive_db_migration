namespace :data do
  desc 'recreate db, load data, make backup'
  task :full_load do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['data:load_data'].invoke
    Rake::Task['data:backup_db'].invoke
  end

  desc 'load all data from mdb files'
  task :load_data do
    sh %{rails runner load_data.rb}
  end

  desc 'load all data from mdb files'
  task :recreate_db do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end

  desc 'backup data'
  task :backup_db do
    sh %{"C:/Program Files/PostgreSQL/9.0/bin/pg_dump.exe" --host localhost --port 5432 --username "postgres" --format plain --no-owner --no-privileges --verbose --file "E:/complexarch.sql" "complex_archive_dev"}
  end
end
