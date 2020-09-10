class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  #ハッシュ化して認証を送信する
  def change
    add_column :users, :password_digest, :string
  end
end
