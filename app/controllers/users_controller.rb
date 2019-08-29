class UsersController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @micropost  = @user.microposts.build
      @feed_items = @user.feed.page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end
end
　
