class Admin::UsersController < ApplicationController
  layout "sign_in"
   
  
  def index 
    @users = User.all 
    @users = @users.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    redirect_to [ :edit, :admin, user]
  end
  
  def edit 
    @user = User.find(params[:id])
  end
  
  def update 
    @user =  User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      flash.notice = "指定したユーザーアカウントを変更しました。"
      redirect_to :admin_users 
    else
      render action: "edit"
    end
  end
  
  def destroy 
    @user = User.find(params[:id])
    @user.destroy!
    flash.notice = "指定したユーザーアカウントを削除しました。"
    redirect_to :admin_users
  end
  
  private def user_params
    params.require(:user).permit(:username, :email, :suspended, :administrator)
  end
end
