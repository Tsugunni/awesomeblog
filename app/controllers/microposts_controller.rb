class MicropostsController < ApplicationController
    def create 
        @micropost = current_user.microposts.new(micropost_params)

        if @micropost.save 
            redirect_to root_url
        else
            render "users/home_feed"
            # ↑今のページ
        end
    end

    def destroy 
       @micropost = Micropost.find(params[:id])
       @micropost.destroy
       
       redirect_to root_url
    end
    private
        def micropost_params
            params.require(:micropost).permit(:content)
        end
end
