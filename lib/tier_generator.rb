class TierGenerator
    attr_reader :customer, :start_period, :end_period, :tier_index
    
    TIER_TARGETS = [0, 100, 500].freeze

    def initialize(customer)
        @customer       = customer
        @start_period   = (Time.now - 1.year).beginning_of_year
        @end_period     = Time.now.end_of_year
        @tier_index     = Customer.tiers[customer.tier]
    end

    def perform
        {
            currentTier: current_tier,
            nextTier: next_tier,
            prevTier: prev_tier
        }
    end

    private

    def current_tier
        {
            name: customer.tier,
            startDate: @start_period,
            amountSpent: current_spending
        }
    end

    def next_tier
        next_index = tier_index + 1
        return {} if next_index >= Customer.tiers.size
        
        next_tier = Customer.tiers.select {|k,v| v == next_index}.keys.first
        {
            name: next_tier,
            deadline: @end_period,
            amountToSpend: TIER_TARGETS[next_index] - current_spending
        }
    end

    def prev_tier
        prev_index = tier_index - 1
        return {} if prev_index < 0

        prev_tier = Customer.tiers.select {|k,v| v == prev_index}.keys.first
        prevent_amount = TIER_TARGETS[tier_index] - next_period_balance
        {
            name: prev_tier,
            deadline: @end_period,
            amountToPreventDowngrade: prevent_amount < 0 ? 0 : prevent_amount
        }
    end

    def current_spending
        @current_spending ||= customer.orders.where("created_at >= ? AND created_at <= ?", start_period, end_period).sum(:total_in_cents)
    end

    # spending of this year (kept for next period)
    def next_period_balance
        @next_period_balance ||= customer.orders.where("created_at >= ? AND created_at <= ?", end_period.beginning_of_year, end_period).sum(:total_in_cents)
    end
end