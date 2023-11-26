namespace :customer do
  desc "TODO"
  task recalculate: :environment do
    Customer.pluck(:id).each do |customer_id|
      puts "Add Recalculate Job to Queue for Customer ID: #{customer_id}"
      RecalculateTierJob.perform_later(customer_id)
    end
  end

end
