class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
  end
end
