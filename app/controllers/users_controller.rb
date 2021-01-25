class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]
  before_action :set_params, only:[:create]
  before_action :authenticate_user, {only: [:show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_corret_user, {only: [:show, :edit, :update]}

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(set_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/products")
    else
      render("users/new")
    end
  end

  def show
  end
  
  def edit
  end
  
  def update
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def login_form
  end
  
  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    # @user = User.find_by(email: params[:email], password: params[:password], cart_id: session[:cart_id])
    if @user
      if session[:cart_id] and @user.cart_id.nil?
        Cart.find_by(id: session[:cart_id]).update(user_id: @user.id)
        @user.update(cart_id: session[:cart_id])
        redirect_to("/carts/#{@user.cart_id}")
      elsif session[:cart_id]
        redirect_to("/carts/#{@user.cart_id}")
      else
        redirect_to("/products")
      end
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]

      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  def ensure_corret_user
    if @current_user != User.find_by(id: params[:id])
      redirect_to("/users/#{@current_user.id}")
    end
  end
  
  private
    def set_user
      @user = User.find_by(id: params[:id])
    end
    
    def set_params
      params.require(:user).permit(:name, :email, :password)
    end
end
