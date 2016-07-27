class CustomersController < ApplicationController
  PAGE_SIZE = 10

  def index
    @page = (params[:page] || 0).to_i

    if params[:keywords].present?
      @keywords = params[:keywords]
      customer_search_term = CustomerSearchTerm.new(@keywords)

      @customers = Customer.where(
          customer_search_term.where_clause,
          customer_search_term.where_args).
        order(customer_search_term.order).
        offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
    else
      @customers = []
    end

    respond_to do |format|
      format.html {}
      format.json { render json: @customers }
    end
  end
end
