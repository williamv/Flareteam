class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment].merge(
      user_id: current_user.id,
      activation_id: params[:activation_id]
    ))

    if @comment.save
      redirect_to :back
    end 
  end
end
