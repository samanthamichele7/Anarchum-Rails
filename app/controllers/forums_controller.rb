class ForumsController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :forum, :through => :category, :shallow => true
  
  def create
    if @forum.save
      flash[:notice] = "Forum was successfully created."
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end
  
  def update
    if @forum.update_attributes(params[:forum])
      flash[:notice] = "Forum was updated successfully."
      redirect_to forum_url(@forum)
    end
  end
  
  def destroy
    if @forum.destroy
      flash[:notice] = "Category was deleted."
      redirect_to forums_url
    end
  end
end