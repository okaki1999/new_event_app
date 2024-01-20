class CommentsController < ApplicationController
    def create
    event = Event.find(params[:event_id])
    comment = current_user.comments.new(comment_params)
    comment.event_id = event.id
    comment.save
    redirect_back(fallback_location: root_path)
    end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :event_id)
  end
end
