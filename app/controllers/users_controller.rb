class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  #管理人のみdestroyメゾットを実行できるようにする
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

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

  def edit
   @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # ログイン済みユーザーかどうか確認
   def logged_in_user
     unless logged_in?
       store_location
       flash[:danger] = "Please log in."
       redirect_to login_url
     end
   end

   # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


  def destroy
  User.find(params[:id]).destroy
  flash[:success] = "User deleted"
  redirect_to users_url
  end

  # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


  #キーワード以降のコードを強調させるため
  private

   def user_params
     #:user属性を必須とし、名前、メールアドレス、パスワード、パスワードの確認の属性をそれぞれ許可し、それ以外を許可しないようにする
     params.require(:user).permit(:firstname,:lastname,:email,:password,:password_confirmation)
   end
end
