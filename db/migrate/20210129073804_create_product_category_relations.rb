class CreateProductCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :product_category_relations do |t|
      t.references :product, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
