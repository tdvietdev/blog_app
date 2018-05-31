class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.page(params[:page]).per Settings.static_pages.home.microposts_per_page
    else
      @feed_items = Entry.order_by_created_at.page(params[:page]).per Settings.static_pages.home.microposts_per_page
    end

    @most_present = Entry.most_present
  end

  def help; end

  def about; end
end
