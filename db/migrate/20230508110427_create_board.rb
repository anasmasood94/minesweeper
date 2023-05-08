class CreateBoard < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.string :email
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :number_of_mines, null: false
      t.integer :grid, array: true, default: []

      t.timestamps
    end
  end
end
