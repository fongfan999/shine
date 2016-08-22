class CreateCustomerDetailsMaterializedView < ActiveRecord::Migration
  def up
    execute %{
      CREATE MATERIALIZED VIEW customer_details AS
        SELECT
          customers.id AS customer_id,
          customers.first_name AS first_name,
          customers.last_name AS last_name,
          customers.email AS email,
          customers.username AS username,
          customers.created_at AS joined_at,
          billing_address.id AS billing_address_id,
          billing_address.street AS billing_street,
          billing_address.city AS billing_city,
          billing_address.zipcode AS billing_zipcode,
          billing_state.code AS billing_state,
          shipping_address.id AS shipping_address_id,
          shipping_address.street AS shipping_street,
          shipping_address.city AS shipping_city,
          shipping_address.zipcode AS shipping_zipcode,
          shipping_state.code AS shipping_state
        FROM
          customers
        JOIN customers_billing_addresses ON
          customers.id = customers_billing_addresses.customer_id
        JOIN addresses billing_address ON
          billing_address.id = customers_billing_addresses.address_id
        JOIN states billing_state ON
          billing_state.id = billing_address.state_id
        JOIN customers_shipping_addresses ON
          customers.id = customers_shipping_addresses.customer_id
          AND customers_shipping_addresses.primary = TRUE
        JOIN addresses shipping_address ON
          shipping_address.id = customers_shipping_addresses.address_id
        JOIN states shipping_state ON
          shipping_state.id = shipping_address.state_id
    }
    execute %{
      CREATE UNIQUE INDEX
        customer_details_customer_id
      ON
        customer_details(customer_id)
    }
  end

  def down
    execute "DROP MATERIALIZED VIEW customer_details"
  end
end
