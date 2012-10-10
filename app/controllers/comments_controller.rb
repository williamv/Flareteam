class CommentsController < ApplicationController
  respond_to :html

  def create
    @comment = Comment.new(params[:comment].merge(
      user_id: current_user.id,
      activation_id: params[:activation_id]
    ))

    if @comment.save
      redirect_to :back
    end 
  end

  def edit
    @activation = Activation.find(params[:activation_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @activation = Activation.find(params[:activation_id])
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    
    redirect_to @activation
  end
end
