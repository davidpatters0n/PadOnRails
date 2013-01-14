class CommentsController < ApplicationController
before_filter :authenticate, :only => [:create, :destroy]
  def create
    @object = find_object
    @comment = @object.comments.create(params[:comment])
    
    respond_to do |format|
      if @comment.save

        format.html { redirect_to(@object, :notice => "Comment added.")}
        format.js
      else
        format.html { redirect_to(@object) }
      end
    end
  end

  def destroy
    @object = find_object
    @comment = @object.comments.find(params[:id])
    @comment.destroy
    
    respond_to do |format|
      format.html { redirect_to(@object) }
      format.js
    end
  end

private

  def find_object
    @object = if params[:contact_id]
      Contact.find(params[:contact_id])
    elsif params[:company_id]
      Company.find(params[:company_id])
    end
  end
end