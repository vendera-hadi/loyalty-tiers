class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string    :name
      t.date      :join_date
      t.integer   :tier, default: 0   
      t.timestamps
      t.datetime  :deleted_at
    end
  end
end
