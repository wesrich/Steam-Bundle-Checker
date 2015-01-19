module Steam
  DB = Sequel.connect ENV['DATABASE_URL']
  Sequel::Model.plugin :json_serializer
end

require_relative 'steam/user'
