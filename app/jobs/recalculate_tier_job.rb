class RecalculateTierJob < ApplicationJob
  queue_as :default

  def perform(customer_id)
    customer = Customer.find_by(id: customer_id)
    return if customer.blank?

    RecalculateTier.new(customer).perform
  end
end
