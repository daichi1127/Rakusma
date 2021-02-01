class Category < ApplicationRecord
    has_many :product_category_relations
    has_many :products, through: :product_category_relations
end
