class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase) #有効なアドレスをキャッチする
    if user && user.authenticate(params[:session][:password])
      log_in user
      #remember_me送信処理
      params[:session][:remember_me] == '1' ? remember(user) :forget(user) #1はON
      redirect_to user
    else
      #falsh.nowのメッセージはその後リクエストが発生したときに消滅
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    #ログイン中の場合のみログアウトする
    log_out if logged_in?
    redirect_to root_url
  end
end
