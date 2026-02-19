class AddCustomerToAppointments < ActiveRecord::Migration[8.0]
  def change
    add_reference :appointments, :customer, foreign_key: true
  end
end
