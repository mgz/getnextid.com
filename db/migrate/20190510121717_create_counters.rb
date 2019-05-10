class CreateCounters < ActiveRecord::Migration[5.2]
    def change
        create_table :counters do |t|
            t.timestamps
            t.text :name, null: false
            t.integer :value, null: false, default: 0
            t.references :created_from_ip, foreign_key: {to_table: :ips}, null: false
            t.references :incremented_from_ip, foreign_key: {to_table: :ips}, null: false
            t.text :password, null: false
        end
    end
end
