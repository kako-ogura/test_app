class UsersController < ApplicationController

  #ユーザーの一覧が見ることができる
  def show
    @user = User.find(params[:id])
  end

  #signupする
  def new
    @user = User.new
  end

  #保存する
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Test App!"
      redirect_to @user
    else
      render "new"
    end
  end

  #キーワード以降のコードを強調させるため
  private

   def user_params
     #:user属性を必須とし、名前、メールアドレス、パスワード、パスワードの確認の属性をそれぞれ許可し、それ以外を許可しないようにする
     params.require(:user).permit(:firstname,:lastname,:email,:password,:password_confirmation)
   end
end
