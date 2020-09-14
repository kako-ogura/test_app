class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
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

  #fixtureテスト用に文字列のハッシュ化を返す
  class << self
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #ランダムのトークンを返す
  def new_token
    SecureRandom.urlsafe_base64
  end

  #永続セッションのためにユーザーをデータベースに記憶させる
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


 # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end


  end

  def forget
    update_attribute(:remember_digest, nil)
  end


end
