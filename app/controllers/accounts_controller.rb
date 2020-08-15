class AccountsController < ApplicationController
  
  layout "sign_in"
  before_action :authorize_user
  
  def show
    @user = current_user 
   
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.assign_attributes(account_params)
    if @user.save
      flash.notice = "アカウントを更新しました。"
      redirect_to :account
    else
      flash.now.alert = "アカウントを更新できませんでした。"
      render action: "edit"
    end
  end
  
  private def authorize_user
    unless current_user
      flash.alert = "ログインしてください。"
      redirect_to :sign_in
    end
  end
  
  private def account_params
    params.require(:user).permit(:username, :email, :profile, :image)
  end
  
  
  
end
