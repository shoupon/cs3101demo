class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    before_filter :require_user
    protect_from_forgery with: :exception

    def current_user
        if @u && @u.id == session[:user_id]
            return @u
        else
            @u = User.find(session[:user_id]) if session[:user_id]
            return @u
        end
    end
    helper_method :current_user

    def require_user
        if current_user
            return true
        end
        redirect_to login_url
    end

    # Allow user to edit their own information, except being :admin
    def allow_edit(owner)
       u = User.find(session[:user_id])
       if u.role == :admin
          return true
       else
          if u.id == owner.id
             return true
          else
             respond_to do |format|
                format.html { redirect_to users_path, notice: 'You are not authorized to perform the action' }
             end
          end
       end
    end

end
