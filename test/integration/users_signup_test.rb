require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "h1",
                                         email: "user@jundy.com",
                                         password: "12345",
                                         password_confirmation: "bar" } }
      
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "h2",
                                         email: "h2@jundy.com",
                                         password: "123456",
                                         password_confirmation: "123456"} }
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    assert is_logged_in?
  end
end
