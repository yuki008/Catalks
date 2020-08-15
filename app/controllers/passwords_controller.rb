class PasswordsController < ApplicationController
  layout "sign_in"
  before_action :authorize_user 
  
  def show
    redirect_to :edit_password
  end
  
  def edit
    @change_password_form = 
      ChangePasswordForm.new(object: current_user)
  end
  
  def update
    @change_password_form = ChangePasswordForm.new(user_params)
    @change_password_form.object = current_user
    if @change_password_form.save
      flash.notice = "パスワードを変更しました。"
      redirect_to :account
    else 
      flash.now.alert = "入力に間違いがあります。"
      render action: "edit"
    end
  end
  
  private def user_params
    params.require(:change_password_form).permit(
      :current_password, :new_password, :new_password_confirmation)
  end
  
   private def authorize_user
    unless current_user
      flash.alert = "ログインしてください。"
      redirect_to :sign_in
    end
  end
end
