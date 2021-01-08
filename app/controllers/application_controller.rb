class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end
  
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/products")
    end
  end
  
    
  helper_method :current_cart
  
  def current_cart
    # if session[:cart_id] and session[:cart_id] == params[:id].to_i
    if session[:cart_id]
      begin 
        @cart = Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound => ex
        @cart = Cart.create
        session[:cart_id] = @cart.id
        @cart
      end
    else
      @cart = Cart.create!
      session[:cart_id] = @cart.id
      @cart
    end
  end
end