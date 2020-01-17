class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = Micropost.new
      @microposts = current_user.microposts.paginate(page: params[:page], per_page: 5).order(created_at: "DESC")
      render "users/home_feed"
    end
  end

  def about
  end
end
