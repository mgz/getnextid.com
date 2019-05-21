class AddReadPasswordToCounters < ActiveRecord::Migration[5.2]
  def change
    add_column :counters, :read_password, :text
  end
end
