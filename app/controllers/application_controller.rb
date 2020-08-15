class ApplicationController < ActionController::Base
  before_action :check_account
  
  class Forbidden < ActionController::ActionControllerError; end 
  class IpAddressRejected < ActionController::ActionControllerError; end
  
  rescue_from StandardError, with: :rescue500
  rescue_from Forbidden, with: :rescue403
  rescue_from IpAddressRejected, with: :rescue403

  
  private def current_user
    if session[:user_id]
      @current_user ||= 
        User.find_by(id: session[:user_id])
    end
  end
  
  private def check_account
    if current_user && !current_user.active?
      session.delete(:user_id)
      flash.alert = "アカウントが停止しています。"
      redirect_to :root 
    end
  end
  
  
  private def rescue403(e)
    @exception = e 
    render "errors/forbidden", status: 403 
  end
  
  private def rescue500(e)
    render "errors/server_error", status: 500 
  end
  
  helper_method :current_user 
end
