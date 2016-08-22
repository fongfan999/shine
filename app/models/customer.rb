class Customer < ActiveRecord::Base
  has_many :customers_shipping_addresses
  has_many :shipping_addresses, through: :customers_shipping_addresses,
    source: :address

  has_many :customers_billing_addresses
  has_many :billing_addresses, through: :customers_shipping_addresses,
    source: :address

  def full_name
    first_name + " " + last_name
  end
end
