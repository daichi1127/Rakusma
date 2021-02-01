class Product < ApplicationRecord
    has_many :cart_items
    has_many :carts, through: :cart_items
    
    has_many :product_category_relations
    has_many :categories, through: :product_category_relations
end
