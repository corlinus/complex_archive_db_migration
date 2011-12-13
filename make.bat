rake db:rollback && rake db:migrate && rails runner load_data.rb && "C:/Program Files/PostgreSQL/9.0/bin\pg_dump.exe" --host localhost --port 5432 --username "postgres" --format plain --no-owner --no-privileges --verbose --file "E:\complexarch.sql" "complex_archive_dev" > nul

rem "C:/Program Files/PostgreSQL/9.0/bin\pg_dump.exe" --host localhost --port 5432 --username "postgres" --format plain --no-owner --no-privileges --verbose --file "E:\complexarch.sql" "complex_archive_dev"
