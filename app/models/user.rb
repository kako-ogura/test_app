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
  validates :password, presence:true, length:{minimum:4},allow_nil: true #空のパスワードでも有効にする
  

  def forget
    update_attribute(:remember_digest, nil)
  end


end
