class UsersController < ApplicationController
  before_action :search_users

  def index
    @users = User.all
    if user_signed_in?
      @user = current_user
      @micropost  = @user.microposts.build
      @feed_items = @user.feed.page(params[:page]).per(15)
      @daytime    = @user.daytime
      @weektime   = @user.weektime
      @monthtime  = @user.monthtime
      @daytime_before   = @user.daytime_before
      @weektime_before  = @user.weektime_before
      @monthtime_before = @user.monthtime_before
      @total_studytime  = @user.total_studytime
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(15)
    ta  = (0..4).map{|i| Time.new.ago(i.days)}
    tar = ta.reverse
    @day_labels = tar.map{|i| i.strftime("%m-%d")}
    ma  = (0..4).map{|i| Time.new.ago(i.months)}
    mar = ma.reverse
    @month_labels = mar.map{|i| i.strftime("%m")}
    @daytime = @user.daytime
    @daytime_before = @user.daytime_before
    @daytime_before_2days = @user.daytime_before_2days
    @daytime_before_3days = @user.daytime_before_3days
    @daytime_before_4days = @user.daytime_before_4days
    @weektime = @user.weektime
    @weektime_before = @user.weektime_before
    @weektime_before_2weeks = @user.weektime_before_2weeks
    @weektime_before_3weeks = @user.weektime_before_3weeks
    @weektime_before_4weeks = @user.weektime_before_4weeks
    @monthtime = @user.monthtime
    @monthtime_before = @user.monthtime_before
    @monthtime_before_2months = @user.monthtime_before_2months
    @monthtime_before_3months = @user.monthtime_before_3months
    @monthtime_before_4months = @user.monthtime_before_4months
  end

  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def search_users
    @search = User.ransack(params[:q])
    @search_users = @search.result.page(params[:page])
  end
end
