class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references  :customer, null: false, foreign_key: true
      t.string      :customer_name, null: false
      t.string      :number
      t.float       :total_in_cents, default: 0
      t.timestamps
      t.datetime    :deleted_at
    end
  end
end
