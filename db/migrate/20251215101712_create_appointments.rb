class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.datetime :time
      t.string :status
      t.string :package
      t.string :provider
      t.string :unique_id

      t.timestamps
    end
  end
end
