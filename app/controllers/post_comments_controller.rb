class PostCommentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.event_id = event.id
    comment.save
    redirect_to event_path(event)
  end
  
 def destroy
    PostComment.find(params[:id]).destroy
    redirect_to event_path(params[:event_id])
 end 
  
  private
  
  def post_comment_params
     params.require(:post_comment).permit(:comment)
  end
end
