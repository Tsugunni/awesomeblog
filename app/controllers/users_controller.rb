class UsersController < ApplicationController
    def show 
        @user = User.find(params[:id])
        @microposts = @user.microposts.paginate(page: params[:page], per_page: 5)
        # current_user はログインしている自分のアカウント
        # @user はクリックして得た他のアカウントの情報
    end

    def new
        @user = User.new
    end
    
    def create 
        @user = User.new(user_params)

        if @user.save 
            redirect_to root_url
        else
            render "new"
        end
    end

    def edit 
        @user = User.find(params[:id])
    end

    def update 
        @user = User.find(params[:id])
    
        if @user.update(user_params)
            redirect_to user_url(@user)
        else
          render "edit"
        end
    end

    def index 
        @users = User.paginate(page: params[:page], per_page: 10)
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
