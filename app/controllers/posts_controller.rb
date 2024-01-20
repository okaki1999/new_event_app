class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @event = Event.find(params[:event_id])
    @post = @event.posts.build(post_params)
    @post.event_id = event.id
    if @post.save
      flash[:success] = "コメントしました"
      redirect_to event_path(@event)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def post_params
   params.require(:post).permit(:title, :content)
  end
  
end
