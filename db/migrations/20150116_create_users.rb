Sequel.migration do
  change do
    run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'

    create_table :users do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), null: false
      column :uid, :text, unique: true
      column :name, :text
      column :avatar, :text
      column :is_public, :boolean, default: true
      column :games, :json
      column :created_at, :timestamp
      column :updated_at, :timestamp

      primary_key [:id]
      index :uid
    end
  end
end
