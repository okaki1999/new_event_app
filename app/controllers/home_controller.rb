class HomeController < ApplicationController
def index
  @regions = Region.all

  # ログインしている場合、ログインユーザーの地域を取得
  if user_signed_in?
    @region = current_user.region || Region.first
  else
    # ログインしていない場合はデフォルトの地域を取得
    @region = Region.first
  end

  # パラメータで地域が指定されている場合はそれを使用
  @region = Region.find_by(id: params[:region]) || @region

  # ここで @region が Region オブジェクトであることを確認しましょう
  unless @region.is_a?(Region)
    # もしくは適切な処理を行ってください
    redirect_to root_path, alert: "Invalid region specified"
    return
  end

  @events = @region.events
  @sp_events = @region.events && Event.where("events.start_time > ?", DateTime.now).order(:start_time)
end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :body, :image, :start_time, :region_id , :prefecture_id)
  end
  
end