class AddDetailsToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :mobile, :integer
    add_column :customers, :gender, :string
    add_column :customers, :date, :date
  end
end
