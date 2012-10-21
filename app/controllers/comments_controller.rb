class CommentsController < ApplicationController
  respond_to :html

  def create
    @comment = Comment.new(params[:comment].merge(
      user_id: current_user.id,
      activation_id: params[:activation_id]
    ))

    unless @comment.save
      flash[:alert] = "Could not post update: #{@comment.errors.full_messages.join(", ")}"
    end

    redirect_to :back
  end

  def edit
    @activation = current_user.activations.find(params[:activation_id])
    @comment = @activation.comments.find(params[:id])
  end

  def update
    @activation = current_user.activations.find(params[:activation_id])
    @comment = @activation.comments.find(params[:id])
    @comment.update_attributes(params[:comment])
    
    redirect_to @activation
  end

  def destroy
    @activation = current_user.activations.find(params[:activation_id])
    @comment = @activation.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to activation_url(@activation) }
      format.json { head :no_content }
    end
  end
end
