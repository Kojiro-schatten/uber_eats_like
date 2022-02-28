class CreateLineFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :line_foods do |t|
      t.references :food, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.references :order, foreign_key: true #order確定まで、line_foodsレコードは、order知らなくても良いため
      t.integer :count, null: false, default: 0
      t.boolean :active, null: false, default: false
      t.timestamps
    end
  end
end
