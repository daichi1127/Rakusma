class OrdersController < ApplicationController
    
    def new
        @cart = current_cart
        if @cart.cart_items.empty?
            redirect_to products_path, notice: "カートは空です"
            return
        end
        sub_totals_hash = {}
        @cart.cart_items.each do |item|
            sub_totals_hash.store(item.product_id, (item.product.price * item.quantity))
        end
        @sub_totals_hash = sub_totals_hash
        @total = sub_totals_hash.values.inject(:+)
    end
    
    
    def create
        @cart = current_cart
        if @cart.cart_items.empty?
            redirect_to products_path, notice: "カートは空です"
            return
        end
        # @order = Order.create(user_id: 8, cart_id: @cart.id)
        puts set_current_user.nil?
        if set_current_user.nil?
            puts "nil"
            redirect_to login_form_path
        else
            @order = Order.create(user_id: set_current_user.id, cart_id: @cart.id)
            @cart.cart_items.each do |item|
                @order.order_details.create(order_id: @order.id, product_id: item.product_id, cart_id: @cart.id, quantity: item.quantity, total_price: (item.quantity*item.product.price))
            end
            redirect_to complete_path
        end
    end
    
    def complete
        @current_user.update(cart_id: nil)
        session[:cart_id] = nil
    end
end

