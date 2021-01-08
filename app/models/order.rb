class Order < ApplicationRecord
    has_many :order_details, dependent: :destroy
    has_many :products, through: :order_details
    belongs_to :user
end
