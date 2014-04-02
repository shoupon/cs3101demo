class SessionsController < ApplicationController
    skip_before_action :require_user, only: [:new, :create]

    def new
      if session[:user_id]
        redirect_to root_url
      end
    end

    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && BCrypt::Password.new(@user.password_hash) == params[:session][:password]
            session[:user_id] = @user.id
            redirect_to users_url
        elsif @user
            redirect_to new_session_url, notice: 'Password incorrect.'
        else
            redirect_to new_session_url, notice: 'Account does not exist.'
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to new_session_url
    end
end
