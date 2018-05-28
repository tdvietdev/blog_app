class EntriesController < ApplicationController
  before_action :load_entry, except: %i(index, new)
  before_action :verify_entry, only: %i(edit, update, destroy)
  def new
    @entry = current_user.entries.build if logged_in?
  end

  def show
    @comments = @entry.comments.root_comment
  end

  def edit; end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @entry.update_attributes entry_params
      flash[:success] = t ".success"
      redirect_to @entry
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    flash[:success] = t ".success"
    redirect_to request.referrer || root_url
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :content, :description, :active)
  end

  def verify_entry
    @entries = current_user.entries.find_by(id: params[:id])
    redirect_to root_url if @entries.nil?
  end
end
