class CreateCustomersBillingAddresses < ActiveRecord::Migration
  def change
    create_table :customers_billing_addresses do |t|
      t.references :customer, index: true, foreign_key: true, null: false
      t.references :address, index: true, foreign_key: true, null: false
    end
  end
end
