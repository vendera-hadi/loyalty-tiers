class CustomersController < ApplicationController
    before_action :prepare_data, only: %i[show]

    def show
        customer_information = {
            name: @customer.name,
            joinDate: @customer.join_date,
        }
        tier_information = TierGenerator.new(@customer).perform
        customer_information = customer_information.merge(tier_information)

        render json: customer_information
    end

    private

    def prepare_data
        @customer = Customer.find_by(id: params[:id])
        raise ActiveRecord::RecordNotFound.new("Customer Record not found") if @customer.blank?
    end
end
