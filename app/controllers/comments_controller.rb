class CommentsController < ApplicationController
  before_action :load_comment, except: %i(index new)
  before_action :verify_comment, only: %i(update delete)
  def new; end

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save!
      respond_to do |format|
        format.html {redirect_to @comment.entry}
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.html {redirect_to @comment.entry}
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html {redirect_to @comment.entry}
        format.js
      end
    else

    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to @comment.entry}
      format.js
    end
  end

  def new_reply
    respond_to do |format|
      format.html {redirect_to @comment.entry}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :entry_id, :parent_id)
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
  end

  def verify_comment
    @comment = Comment.find_by id: params[:id]
    redirect_to root_url unless @comment.user.current_user?(current_user)
  end
end
