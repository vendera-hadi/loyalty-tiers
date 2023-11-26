# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create first 5 customers
(1..5).each do |number|
  customer = Customer.find_or_initialize_by(name: "Customer#{number}")
  random_year = rand(1..5) # random 1 til 5 years ago
  customer.join_date = rand(random_year.years).seconds.ago.to_date
  customer.save
  puts "#{customer.name} was created."
end

# Truncate Order table
Order.destroy_all
# Create dummy Order Data (customer 2 until customer 5). customer 1 for testing new user
(2..5).each do |cust_number|
    total_order_created = rand(1..3)
    customer = Customer.find_by(name: "Customer#{cust_number}")
    break if customer.blank?

    puts "Customer #{cust_number} has #{total_order_created} orders :"
    (1..total_order_created).each do |order_index|
        random_order_id = (0...5).map { ('A'..'Z').to_a[rand(26)] }.join
        order = Order.find_or_initialize_by(number: random_order_id)
        order.customer = customer
        order.customer_name = customer.name
        random_total_spend = rand(10..50)
        order.total_in_cents = random_total_spend
        order.save
        puts "Order #{random_order_id} created with total spending in cents: #{random_total_spend}"
    end
end
