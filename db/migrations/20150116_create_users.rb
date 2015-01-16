Sequel.migration do
  change do
    create_table :users do
      column :id, "uuid", default: Sequel::LiteralString.new("uuid_generate_v4()"), null: false
      column :uid, "text"
      column :auth, "json"
      column :games, "json"
      column :created_at, "timestamp without time zone"
      column :updated_at, "timestamp without time zone"

      primary_key [:id]
    end
  end
end
