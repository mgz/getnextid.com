class UniqName < ActiveRecord::Migration[5.2]
    def change
        add_index :counters, :name, unique: true
    end
end
