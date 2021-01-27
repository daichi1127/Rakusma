class ProductsController < ApplicationController

include ActionController::Streaming
include Zipline

  # 商品一覧画面
  def index
    download
    @products = Product.all
    @cart_item = CartItem.new
  end
  
  def download
    # region = 'ap-northeast-1'
    # bucket = "rakusma-product-info"
    # key = params[:]

    # myBacket = 'rakusma-product-info'
    # bucket = Aws::S3::Client.new(
    #       :region => 'ap-northeast-1',
    #         :access_key_id => 'AKIA5A4FPCPRVUXNNREK',
    #         :secret_access_key => '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'
    #       )
    # lists = []
    # bucket.list_objects(:bucket => myBacket).contents.each do |b|
    #   lists.push(b)
    # end
    # lists.lazy.map do |list|
    #   s3_object = bucket.get_object(bucket: myBacket, key: list.key)
    #   puts s3_object
    #   # [s3_object.body, list.key+".png"]
    # end
    # puts lists
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
end