class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|

      t.integer :user_id, null: false
      t.string :license, null: false
      t.string :colour, null: false
      t.string :make, null: false
      t.string :model, null: false
      t.integer :year, null:false, limit:4
      t.string :paid, default: "Not Paid", null: false

      t.timestamps null: false
    end
  end
end
