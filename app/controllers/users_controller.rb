class UsersController < ApplicationController
    before_action :require_login, except: [:create, :new]
    
    def new
    end

    def create
        user = User.new(email: params[:user][:email], password: params[:user][:password])
        
        if user.save
            log_in_user!(user)
            redirect_to user_url(user)
        else
            flash[:errors] = user.errors.full_messages
            redirect_to :new_user_url
        end
    end

    def show
        @user = User.find(params[:id])
        
        render :show
    end
    
    
end