class HomeController < ApplicationController
  def index
    @regions = Region.all
  
    if user_signed_in?
      @region = current_user.region || Region.first
    else
      @region = Region.first
    end
  
    @region = Region.find_by(id: params[:region]) || @region
    #クローンやデータの消去をしてregionがない状態だと無限リダイレクトになる
    unless @region
      redirect_to root_path, alert: "Invalid region specified"
      return
    end
  
    @events = @region.events
    @sp_events = @region.events.where("start_time > ?", DateTime.now).order(:start_time)
  end
  
  
  private
  
  def event_params
    params.require(:event).permit(:title, :body, :image, :start_time, :region_id , :prefecture_id)
  end
  
end