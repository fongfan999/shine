class CustomerDetail < ActiveRecord::Base
  self.primary_key = "customer_id"

  def update(params)
    Customer.find(self.customer_id).update(
      params.permit(:first_name, :last_name, :username, :email))

    Address.find(self.billing_address_id).update(
      address_attributes(params, "billing"))

    Address.find(self.shipping_address_id).update(
      address_attributes(params, "shipping"))
  end

  private

  def address_attributes(params, type)
    {
      street: params["#{type}_street"],
      city: params["#{type}_city"],
      state: State.find_by_code(params["#{type}_state"]),
      zipcode: params["#{type}_zipcode"]
    }
  end
end