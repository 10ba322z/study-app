class UsersController < ApplicationController
  def index
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
  end
end
