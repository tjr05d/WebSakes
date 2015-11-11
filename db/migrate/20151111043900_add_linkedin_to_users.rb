class AddLinkedinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin
  end
end
