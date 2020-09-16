require 'faker'

# メインのサンプルユーザーを1人作成する
User.create!(firstname:  "Kako",
             lastname:  "Ogura",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             #メインのユーザーをここでは管理人とする
             admin:true,
             activated: true,
             activated_at: Time.zone.now)


# 追加のユーザーをまとめて生成する
99.times do |n|
  firstname  = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = Faker::Internet.email
  password = "password"
  User.create!(firstname:  firstname,
               lastname: lastname,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

#follow and followerのリレーション
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }