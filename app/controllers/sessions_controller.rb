class SessionsController < ApplicationController
  
  def new 
    if current_user
      redirect_to :articles  
    else 
      @form = LoginForm.new 
      render action: "new"
    end 
  end
  
  def create 
    @form = LoginForm.new(login_form_params)
    if @form.email.present?
      user = User.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    
    if Authenticator.new(user).authenticate(@form.password)
      if user.suspended?
        flash.now.alert = "アカウントが停止しています。"
        render action: "new"
      else 
        session[:user_id] = user.id 
        flash.notice = "ログインしました。"
        redirect_to :articles 
      end
    else 
      flash.now.alert = "メールアドレスまたはパスワードが間違っています。"
      render action: "new"
    end
  end
  
  def destroy 
    session.delete(:user_id)
    flash.notice = "ログアウトしました。"
    redirect_to root_path
  end
  
  private def login_form_params 
    params.require(:login_form).permit(:email, :password)
  end
end
