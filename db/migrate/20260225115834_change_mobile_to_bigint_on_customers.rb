class ChangeMobileToBigintOnCustomers < ActiveRecord::Migration[8.0]
  def change
    change_column :customers, :mobile, :integer, limit: 8
  end
end
