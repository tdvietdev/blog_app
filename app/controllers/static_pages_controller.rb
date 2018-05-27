class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.page(params[:page]).per Settings.static_pages.home.microposts_per_page
    end
  end

  def help; end

  def about; end
end
