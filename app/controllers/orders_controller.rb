class OrdersController < ApplicationController
    skip_before_action  :verify_authenticity_token
    before_action       :validate_params, :validate_customer, :validate_order_number, :validate_date, only: %i[create]

    def create
        # store new order
        order = Order.new(insert_params)
        order.save
        # recalculate tier
        RecalculateTier.new(@customer).perform
        render json: { message: "Insert Success", order: order.response }
    end

    private

    def validate_params
        attributes = {customerId: Integer, customerName: String, orderId: String, totalInCents: Integer, date: String}
        attributes.each do |k,v| 
            raise ActionController::BadRequest.new("Parameter #{k} is required") if !params.has_key?(k)
            raise ActionController::BadRequest.new("Wrong data type for parameter #{k}, It should be #{v.to_s}") if !params[k].is_a?(v)
        end
    end

    def validate_customer
        @customer = Customer.find_by(id: params[:customerId], name: params[:customerName])
        raise ActiveRecord::RecordNotFound.new("Customer Record not found") if @customer.blank?
    end

    def validate_order_number
        order = Order.find_by(number: params[:orderId])
        raise "Order Id already exists" if order.present?
    end

    def validate_date
        date = params[:date].to_date
    rescue StandardError
        raise ActionController::BadRequest.new("Wrong date format")
    end

    def insert_params
        {
            customer_id: params[:customerId],
            customer_name: params[:customerName],
            number: params[:orderId],
            total_in_cents: params[:totalInCents],
            created_at: params[:date],
            updated_at: params[:date]
        }
    end
end
