class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :city, null: false
      t.string :zipcode, null: false
      t.references :state, index: true, foreign_key: true, null: false
    end
  end
end
