class Customer < ApplicationRecord
    has_many :orders

    enum :tier, %i[bronze silver gold]
end
