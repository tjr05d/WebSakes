class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_id
      t.integer :connection_id
      t.boolean :active, default: false


      t.timestamps null: false
    end
  end
end
