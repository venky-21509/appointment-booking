class AddUniqueIndexToAppointments < ActiveRecord::Migration[8.0]
  def change 
    add_index :appointments, [:provider, :time], unique: true
  end
end
