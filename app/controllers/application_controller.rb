class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    before_filter :require_user
    protect_from_forgery with: :exception

    def current_user
        if @user
            return @user
        else
            @user = User.find(session[:user_id]) if session[:user_id]
        end
    end
    helper_method :current_user

    def require_user
        puts "Current_user (in require_user): "
        puts current_user[:email] if current_user
        puts "marker"
        if current_user
            return true
        end
        redirect_to login_url
    end
end
