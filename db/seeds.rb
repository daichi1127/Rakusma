# PRODUCT

# init categories
Category.destroy_all
category1 = Category.create({:name=>"food"})
category2 = Category.create({:name=>"drink"})
puts "Total number of categories: #{Category.all.count}"
puts "Category names: #{Category.all.pluck("name")}"
puts "Category1: #{category1.name}"
puts "Category2: #{category2.name}"

# init products
Product.destroy_all
product1 = Product.create({:name=>"tomato", :price => 100})
product2 = Product.create({:name=>"milk", :price => 120})
product3 = Product.create({:name=>"bread", :price => 80})
product4 = Product.create({:name=>"bacon", :price => 200})
product5 = Product.create({:name=>"cheese", :price => 230})

puts "Total number of products: #{Product.all.count}"
puts "Product names: #{Product.all.pluck("name")}"
puts "Product1: #{product1.name} price: #{product1.price.round(2)}"
puts "Product2: #{product2.name} price: #{product2.price.round(2)}"
puts "Product3: #{product3.name} price: #{product3.price.round(2)}"
puts "Product4: #{product4.name} price: #{product4.price.round(2)}"
puts "Product5: #{product5.name} price: #{product5.price.round(2)}"

# init ProductCategoryRelation
ProductCategoryRelation.destroy_all
product_category1 = ProductCategoryRelation.create({:product_id=>1, :category_id=>1})
product_category2 = ProductCategoryRelation.create({:product_id=>2, :category_id=>2})
product_category3 = ProductCategoryRelation.create({:product_id=>3, :category_id=>1})
product_category4 = ProductCategoryRelation.create({:product_id=>4, :category_id=>1})
product_category5 = ProductCategoryRelation.create({:product_id=>5, :category_id=>1})
puts "Total number of product_category_relations: #{ProductCategoryRelation.all.count}"
# puts "product_category_relations names: #{ProductCategoryRelation.all.pluck("name")}"
# puts "ProductCategoryRelation: #{product_category1} price: #{product1.price.round(2)}"


# CART
Cart.destroy_all
puts "\nTotal cart count: #{Cart.all.count}"