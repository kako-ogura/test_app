require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(firstname:"kako",lastname:"ogura",email:"kako@ogura.com",
    password: "foobar", password_confirmation:"foobar")
  end

  test "should be vailed?" do
    assert @user.valid?
  end


  #ここでもし空の場合バリデーションが起こるテスト
  test "firstname should be present" do
    @user.firstname = ""
    assert_not @user.valid?
  end

  test "lastname should be present" do
    @user.lastname = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  #文字数を指定するテスト
  test "firstname should not be too long" do
    @user.firstname = "a" * 51
    assert_not @user.valid?
  end

  test "lastname should not be too long" do
    @user.lastname = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244
    assert_not @user.valid?
  end

  #有効なメールフォーマットをテストする
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid" #inspectメゾットでどのメールアドレスが間違っているか返す
    end
  end

  #重複したメールアドレスの拒否
  test "email addresses should be unique" do
     duplicate_user = @user.dup
     @user.save
     assert_not duplicate_user.valid?
   end

   #小文字で保存するテスト
   test "email addresses should be saved as lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_case_email
      @user.save
      assert_equal mixed_case_email.downcase, @user.reload.email
    end

    #パスワードの最小文字数を４文字に指定する
    test "password should be present (nonblank)" do
      @user.password = @user.password_confirmation = " " * 4
      assert_not @user.valid?
    end

    test "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a" * 3
      assert_not @user.valid?
    end
end
