class CreateIps < ActiveRecord::Migration[5.2]
    def change
        create_table :ips do |t|
            t.inet :addr, null: false
        end
        
        add_index :ips, :addr, unique: true
    end
end
