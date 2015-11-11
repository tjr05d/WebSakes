class AddContactNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact_number, :integer, :limit => 8
  end
end
