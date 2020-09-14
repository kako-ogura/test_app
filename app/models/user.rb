class User < ApplicationRecord
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
  validates :password, presence:true, length:{minimum:4}

  #fixtureテスト用に文字列のハッシュ化を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
