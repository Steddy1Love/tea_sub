class Api::V0::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: CustomerSerializer.new(customer), status: :created
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end
