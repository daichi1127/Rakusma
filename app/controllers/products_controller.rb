class ProductsController < ApplicationController

include ActionController::Streaming
include Zipline

  before_action :set_product_images, only: %i[categorized_index]
  before_action :set_categorized_products, only: %i[categorized_index]
  before_action :set_category, only: %i[categorized_index]
  

  # 商品一覧画面
  def index
    @categories = Category.all
    @cart_item = CartItem.new
  end
  
  def categorized_index
    @products = Product.all
    @cart_item = CartItem.new
  end
  
  def set_product_images
    @image_url_array = Hash.new
    s3 = Aws::S3::Resource.new(
        region: 'ap-northeast-1',
        credentials: Aws::Credentials.new(
          "AKIA5A4FPCPRVUXNNREK",
          "TJrC/Cn3KiYZojdoTI4BJD3bsUVor0ohBUi1I6wR"
        )
      )
    signer = Aws::S3::Presigner.new(client: s3.client)
    
    Product.all.each do |product|
      presigned_url = signer.presigned_url(
          :get_object,
          bucket: 'rakusma-product-info',
          key: "products/product_#{product.id}.jpeg"
        )
      @image_url_array.store(product.id, presigned_url)
    end
  end
  
  private
    def set_categorized_products
      @categories_products = Product.joins(:product_category_relations).where(product_category_relations: { category_id: params[:id] })
    end
    
    def set_category
      @category = Category.find(set_category_id)
    end
    
    def set_category_id
      params[:id]
    end
end