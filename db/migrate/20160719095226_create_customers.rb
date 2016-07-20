class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :username, null: false

      t.timestamps null: false
    end

    add_index :customers, :email, unique: true
    add_index :customers, :username, unique: true
  end
end
