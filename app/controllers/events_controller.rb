
class EventsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index]

  
def index
  # 開始時刻が現在時刻より後のイベントを取得し、開始時刻で並べ替える
  @events = Event.where("events.start_time > ?", DateTime.now).order(:start_time)
  
  # 全ての地域を取得
  @regions = Region.all

  # ログインしている場合、ログインユーザーの地域を取得
  if user_signed_in?
    @region = current_user.region || Region.first
  else
    # ログインしていない場合はデフォルトの地域を取得
    @region = Region.first
  end

  # @region が Region オブジェクトであることを確認
  unless @region.is_a?(Region)
    # もしくは適切な処理を行う
    redirect_to root_path, alert: "無効な地域が指定されました"
    return
  end

  # 特定の地域でフィルターしたイベントを取得し、再度開始時刻で並べ替える
  @r_events = @region.events.where("events.start_time > ?", DateTime.now).order(:start_time)

end

  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
    @post_comment = PostComment.new
    
  end

  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.privacy = params[:event][:privacy].to_i unless params[:event][:privacy].nil?
    if @event.save
      user_id = ENV['LINE_USER_ID'] # ユーザーのIDに実際のIDを設定
      event_link = url_for(@event)
      message = "#{@event.user.username}さんによる新しいイベント「#{@event.title}」が企画されました。\n開催日は#{@event.start_time.strftime("%m月/%d日")}です!\n「#{@event.body}」\nURLは\n#{event_link}"
      LineService.broadcast(message)
      redirect_to event_path(@event),notice: "投稿に成功しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
    #アクセス制限（ログインユーザーと違うユーザーがイベントを編集にアクセスできなくする）
    if @event.user != current_user
      redirect_to events_path, alert: "不正なアクセスです。"
    end
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event),notice: "更新に成功しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_path, status: :see_other
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :body, :start_time, :thumbnail, :privacy, :region_id, :prefecture_id, :address, :latitude, :longitude, :genre_id )
  end
  
end