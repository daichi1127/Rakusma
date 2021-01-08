class CartsController < ApplicationController
  before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]
  # before_action :setup_cart_item!, only: [:add_item, :update_item]
  protect_from_forgery :except => [:destroy]
  
  def empty
    flash[:notice] = "カートの中身は空です。"
    redirect_to("/products")
  end

  def show
    if current_cart
      @cart_items = current_cart.cart_items
      sub_totals_hash = {}
      @cart_items.each do |cart_item|
        sub_totals_hash.store(cart_item.product_id, (cart_item.product.price * cart_item.quantity))
      end
      @sub_totals_hash = sub_totals_hash
      @total = sub_totals_hash.values.inject(:+)
    end
  end

  # 商品一覧画面から、「商品購入」を押した時のアクション
  def add_item
    @cart_items = current_cart.cart_items
    exist_cart_products = []
    @cart_items.each do |cart_item|
      exist_cart_products.push(cart_item[:product_id])
    end

    if @cart_items.empty? or !exist_cart_products.include?(params[:cart_item][:product_id].to_i)
      @cart_item = current_cart.cart_items.create(product_id: params[:cart_item][:product_id], quantity: params[:cart_item][:quantity].to_i)
    else
      @cart_items.each do |cart_item|
        if cart_item.product_id == params[:cart_item][:product_id].to_i
          cart_item.quantity += params[:cart_item][:quantity].to_i
          cart_item.save!
          break
        end
      end
    end
    
    redirect_to current_cart
  end

  # カート詳細画面から、「更新」を押した時のアクション
  def update_item
    @cart_item.update(quantity: params[:quantity].to_i)
    redirect_to current_cart
  end
  
  # カート詳細画面から、「削除」を押した時のアクション
  def delete_item
    @cart_item.destroy
    redirect_to current_cart
  end

  private

    def setup_cart_item!
      @cart_item = current_cart.cart_items.find_by(product_id: params[:product_id])
    end
end