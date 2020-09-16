class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
     if user&.authenticate(params[:session][:password])
       if user.activated?
         log_in user
         redirect_back_or user
       else
         message  = "Account not activated. "
         message += "Check your email for the activation link."
         flash[:warning] = message
         redirect_to root_url
       end
    else
      #falsh.nowのメッセージはその後リクエストが発生したときに消滅
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
