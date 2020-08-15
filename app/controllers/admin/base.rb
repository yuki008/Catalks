class Admin::Base < ApplicationController
  before_action :authorize_user
  before_action :current_user_admin
 
  private def authorize_user
    unless current_user
      flash.alert = "ログインしてください。"
      redirect_to :sign_in
    end
  end
  
  private def current_user_admin
    unless current_user&.administrator?
        flash.alert = "管理者ではありません。"
        redirect_to :articles 
    end
  end
end