class PagesController < ApplicationController
  def index
    # @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

end
