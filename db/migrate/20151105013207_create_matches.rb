class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :first_selector
      t.integer :second_selector
      t.boolean :active

      t.timestamps null: false
    end
  end
end
