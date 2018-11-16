class SessionsController
    def new
    end

    def create
        user = User.find_by_credentials(email: params[:user][:email], password: params[:user][:email])
        
        if user
            log_in_user!(user)
            redirect_to user_url(user)
        else
            flash[:errors] = user.errors.full_messages
            redirect_to new_session_url
        end
    end

    def destroy
        current_user.reset_session_token! if current_user

        session[:session_token] = nil

        @current_user = nil

        redirect_to new_session_url
    end

end