class ChangeIntegerLimitInEmployeers < ActiveRecord::Migration[6.1]
  def change
    change_column :employeers, :identification, :integer, limit: 8
    change_column :employeers, :phone, :integer, limit: 8
  end
end
