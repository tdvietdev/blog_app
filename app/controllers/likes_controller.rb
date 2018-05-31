class LikesController < ApplicationController
  before_action :logged_in_user
  def create
    @entry = Entry.find_by id: params[:entry_id]
    current_user.like @entry
    respond_to do |format|
      format.html {redirect_to @entry}
      format.js
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    @entry = @like.entry
    @like.destroy
    respond_to do |format|
      format.html {redirect_to @entry}
      format.js
    end
  end
end

