class RecalculateTier
    attr_reader :customer, :start_period, :end_period

    TIER_TARGETS = [0, 100, 500].freeze

    def initialize(customer)
        @customer       = customer
        @start_period   = (Time.now - 1.year).beginning_of_year
        @end_period     = Time.now.end_of_year
    end
    
    def perform
        curr_index = 0
        TIER_TARGETS.each_with_index do |val, idx|
            curr_index = idx if customer_spending >= val
        end
        customer.tier = curr_index
        customer.save!
    end

    private

    def customer_spending
        @customer_spending ||= customer.orders.where("created_at >= ? AND created_at <= ?", start_period, end_period).sum(:total_in_cents)
    end
end