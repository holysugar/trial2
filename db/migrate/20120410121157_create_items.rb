class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.integer :kind
      t.boolean :enabled

      t.timestamps
    end
    add_index :items, :name, :unique => true
    add_index :items, :kind
  end
end
