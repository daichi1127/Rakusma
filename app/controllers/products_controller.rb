class ProductsController < ApplicationController
  # 商品一覧画面
  def index
    @products = Product.all
    @cart_item = CartItem.new
  end
end