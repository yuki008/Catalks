class TopController < ApplicationController
  def index
    if current_user
      render :layout => "sign_in"
     
    else
      render action: "index"
    end
  end
end
