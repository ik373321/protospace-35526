class CommentsController < ApplicationController
  def create
    #binding.pry
   @comment = Comment.new(comments_params)
   if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render:"prototype/show"
    end
  end
  private

  def comments_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
