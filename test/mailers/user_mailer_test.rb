require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
    test "account activation" do
        user = users()
        user.activation_token = User.new_token
        mail = UserMailer.account_activation(user)
        
    end
    
    test "password reset" do
        user = users()
        user.reset_token = User.new_token
        mail = UserMailer.password_reset(user)
    end
end