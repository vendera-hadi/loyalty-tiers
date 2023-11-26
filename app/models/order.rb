class Order < ApplicationRecord
    belongs_to :customer

    def response
        {
            customerId: customer_id,
            customerName: customer.name,
            orderId: number,
            totalInCents: total_in_cents,
            date: created_at
        }
    end
end
