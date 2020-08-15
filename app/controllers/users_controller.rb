class UsersController < ApplicationController
  
  layout "sign_in", except: [:new, :create]
  before_action :authorize_user, except: [:index, :new, :create]
  
  def index
    @users = User.all 
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    
    @user = User.new 
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id 
      flash.notice = "新規登録ができました。"
      redirect_to :articles 
    else 
      flash.now.alert = "新規登録に失敗しました。"
      render action: "new"
    end 
  end
  
  private def authorize_user
    unless current_user
      flash.alert = "ログインしてください。"
      redirect_to :sign_in
    end
  end
  
  private def user_params 
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
