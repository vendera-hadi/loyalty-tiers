class CustomerOrdersController < ApplicationController
    before_action :set_page, :prepare_customer, only: %i[index]

    def index
        orders = @customer.orders.order(created_at: :desc)
                                .where("created_at >= ? AND created_at <= ?", @start_period, @end_period)
                                .limit(@per_page)
                                .offset(@offset)
        render json: orders.map(&:response)
    end

    private

    def set_page
        @per_page = params[:per] || "10"
        page = params[:page] || "1"
        @offset = (page.to_i - 1) * @per_page.to_i
    end
    
    def prepare_customer
        @customer = Customer.find_by(id: params[:id])
        raise ActiveRecord::RecordNotFound.new("Customer Record not found") if @customer.blank?
    end
end
