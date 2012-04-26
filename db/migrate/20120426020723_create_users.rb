class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :force => true do |t|
      t.string :name, :null => false
      t.integer :money, :null => false, :default => 0

      t.timestamps
    end
  end
end
