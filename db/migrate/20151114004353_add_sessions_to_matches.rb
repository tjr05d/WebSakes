class AddSessionsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :session_id, :string
    add_column :matches, :token, :string
  end
end
