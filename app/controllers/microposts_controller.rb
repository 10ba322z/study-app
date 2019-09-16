class MicropostsController < ApplicationController
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "学習時間を記録しました"
      redirect_to root_url
    else
      flash[:danger] = @micropost.errors.full_messages.join(',')
      redirect_to root_url
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture, :start_at, :end_at)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
