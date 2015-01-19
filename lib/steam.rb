module Steam
  DB = Sequel.connect ENV['DATABASE_URL']
end

require_relative 'steam/user'
