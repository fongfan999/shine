class CreateCustomersShippingAddresses < ActiveRecord::Migration
  def change
    create_table :customers_shipping_addresses do |t|
      t.references :customer, index: true, foreign_key: true, null: false
      t.references :address, index: true, foreign_key: true, null: false
      t.boolean :primary, null: false, default: false
    end
  end
end
