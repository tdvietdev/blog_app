class UsersController < ApplicationController
  include UsersHelper
  before_action :load_user, except: %i(index new)
  before_action :logged_in_user, only: %i(index edit update)
  before_action :verify_user, only: %i(edit update)
  before_action :verify_admin, only: :destroy

  def index
    @users = User.search(params[:search]).page(params[:page]).per Settings.per_page
  end

  def show
    @entries = @user.entries.page(params[:page]).per Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t ".info"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".success"
    redirect_to users_url
  end

  def following
    @title = t ".title"
    @users = @user.following.page(params[:page]).per Settings.per_page
    render "show_follow"
  end

  def followers
    @title = t ".title"
    @users = @user.followers.page(params[:page]).per Settings.per_page
    render "show_follow"
  end

  def liked
    @entries = current_user.liking.page(params[:page]).per Settings.per_page
  end

  def draft
    @entries = Entry.draft(current_user).page(params[:page]).per Settings.per_page
  end

  def actived
    @entries = Entry.actived(current_user).page(params[:page]).per Settings.per_page
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
