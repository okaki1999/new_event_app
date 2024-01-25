class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(event_id: params[:event_id])
    @event = Event.find(params[:event_id])
    user_id = ENV['LINE_USER_ID'] # ユーザーのIDに実際のIDを設定
    event_link = url_for(@event)
    message = "#{@favorite.user.username}さんが#{@event.start_time.strftime("%m月/%d日")}のイベント「#{@event.title}」に参加する予定です\nまだ未定の方も早めの参加、不参加、保留の投票をお願いします!\nURLは\n#{event_link}"
    LineService.broadcast(message)
    session[:previous_url] = request.referer
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @event = Event.find(params[:event_id])
    @favorite = current_user.favorites.find_by(event_id: @event.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path, status: :see_other)
  end
end
