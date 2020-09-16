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
