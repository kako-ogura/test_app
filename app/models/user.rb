class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  #なんのバリデーションか記述する
  validates :firstname,presence:true,length:{maximum:50} #存在性(presence) / 長さ(length)
  validates :lastname,presence:true,length:{maximum:50}

  #メールアドレスのフォーマットを検証する
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence:true,length:{maximum:255},
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true

  #パスワードのセキュリティ強化
  has_secure_password
  validates :password, presence:true, length:{minimum:4},allow_nil: true #空のパスワードでも有効にする


  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end


  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email = email.downcase
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


end
