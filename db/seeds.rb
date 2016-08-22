# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Customer.count == 0
  350_000.times do |i|
    Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: "#{Faker::Internet.user_name}#{i}",
      email: Faker::Internet.user_name + i.to_s +
        "@#{Faker::Internet.domain_name}")
  end
end

if State.count == 0 
  # Create all 50 states in the US
  State.create!(name: "Alabama"           , code: "AL")
  State.create!(name: "Alaska"            , code: "AK")
  State.create!(name: "Arizona"           , code: "AZ")
  State.create!(name: "Arkansas"          , code: "AR")
  State.create!(name: "California"        , code: "CA")
  State.create!(name: "Colorado"          , code: "CO")
  State.create!(name: "Connecticut"       , code: "CT")
  State.create!(name: "Delaware"          , code: "DE")
  State.create!(name: "Dist. of Columbia" , code: "DC")
  State.create!(name: "Florida"           , code: "FL")
  State.create!(name: "Georgia"           , code: "GA")
  State.create!(name: "Hawaii"            , code: "HI")
  State.create!(name: "Idaho"             , code: "ID")
  State.create!(name: "Illinois"          , code: "IL")
  State.create!(name: "Indiana"           , code: "IN")
  State.create!(name: "Iowa"              , code: "IA")
  State.create!(name: "Kansas"            , code: "KS")
  State.create!(name: "Kentucky"          , code: "KY")
  State.create!(name: "Louisiana"         , code: "LA")
  State.create!(name: "Maine"             , code: "ME")
  State.create!(name: "Maryland"          , code: "MD")
  State.create!(name: "Massachusetts"     , code: "MA")
  State.create!(name: "Michigan"          , code: "MI")
  State.create!(name: "Minnesota"         , code: "MN")
  State.create!(name: "Mississippi"       , code: "MS")
  State.create!(name: "Missouri"          , code: "MO")
  State.create!(name: "Montana"           , code: "MT")
  State.create!(name: "Nebraska"          , code: "NE")
  State.create!(name: "Nevada"            , code: "NV")
  State.create!(name: "New Hampshire"     , code: "NH")
  State.create!(name: "New Jersey"        , code: "NJ")
  State.create!(name: "New Mexico"        , code: "NM")
  State.create!(name: "New York"          , code: "NY")
  State.create!(name: "North Carolina"    , code: "NC")
  State.create!(name: "North Dakota"      , code: "ND")
  State.create!(name: "Ohio"              , code: "OH")
  State.create!(name: "Oklahoma"          , code: "OK")
  State.create!(name: "Oregon"            , code: "OR")
  State.create!(name: "Pennsylvania"      , code: "PA")
  State.create!(name: "Rhode Island"      , code: "RI")
  State.create!(name: "South Carolina"    , code: "SC")
  State.create!(name: "South Dakota"      , code: "SD")
  State.create!(name: "Tennessee"         , code: "TN")
  State.create!(name: "Texas"             , code: "TX")
  State.create!(name: "Utah"              , code: "UT")
  State.create!(name: "Vermont"           , code: "VT")
  State.create!(name: "Virginia"          , code: "VA")
  State.create!(name: "Washington"        , code: "WA")
  State.create!(name: "West Virginia"     , code: "WV")
  State.create!(name: "Wisconsin"         , code: "WI")
  State.create!(name: "Wyoming"           , code: "WY")
end

# Helper method to create a billing address for a customer
def create_billing_address(customer_id, num_states)
  billing_state   = State.all[rand(num_states)]
  billing_address = Address.create!(
     street: Faker::Address.street_address,
       city: Faker::Address.city,
      state_id: billing_state.id,
    zipcode: Faker::Address.zip
  )

  CustomersBillingAddress.create!(customer_id: customer_id, 
                                   address_id: billing_address.id)
end

# Helper method to create a shipping address for a customer
def create_shipping_address(customer_id,num_states,is_primary)
  shipping_state   = State.all[rand(num_states)]
  shipping_address = Address.create!(
       street: Faker::Address.street_address,
         city: Faker::Address.city,
        state_id: shipping_state.id,
      zipcode: Faker::Address.zip
  )

  CustomersShippingAddress.create!(customer_id: customer_id,
                                    address_id: shipping_address.id,
                                       primary: is_primary)
end

# Cache the number of states so we don't have to query
# ecah time through
num_states = State.count

if CustomersBillingAddress.count == 0
  # For all customers
  Customer.pluck(:id).each do |customer_id|

    # Create a billing address for them
    create_billing_address(customer_id, num_states)

    # Create a random number of shipping addresses, making
    # sure we create at least 1
    num_shipping_addresses = rand(2) + 1

    num_shipping_addresses.times do |i|
      # Create the shipping address, setting the first one
      # we create as the "primary"
      create_shipping_address(customer_id, num_states, i == 0)
    end
  end
end