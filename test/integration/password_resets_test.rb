require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest
    def setup 
        ActionMailer::Base.deliveries.clear
        @user = users()
    end
    
    test "password resets" do
        get new_password_reset_path
        assert_template 'password_resets/new'
        
        # For an invalid email address
        post password_resets_path, password_reset: {email: ""}
        assert_not flash.empty?
        assert_template 'password_resets/new'
        
        # For a valid email address
        post password_resets_path, password_reset: {email: @user.email}
        assert_not_equal @user.reset_digest, @user.reload.reset_digest
        assert_equal 1, ActionMailer::Base.deliveries.size
        assert_not flash.empty?
        assert_redirected_to root_url
    end
end