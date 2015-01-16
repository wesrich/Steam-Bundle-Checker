module Steam
  if ENV['RACK_ENV'] == 'production'
    DB = Sequel.postgres ENV['DATABASE_URL']
  else
    DB = Sequel.sqlite "db/#{ENV['RACK_ENV']}.sqlite3"
  end
end

require_relative 'steam/user'
