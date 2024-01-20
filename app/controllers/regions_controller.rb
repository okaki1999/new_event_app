class RegionsController < ApplicationController
  
  def index
    @regions = Region.all
  end
  
def show
  @regions = Region.all
end

def edit
  @region = Region.find(params[:id])
end

  def update
    @region = Region.find(params[:id])
    if @region.update(region_params)
      redirect_to region_path ,notice: "更新に成功しました。"
    else
      render :edit
    end
  end
  
  def new
    @region = Region.new
  end
  
  def create
    @region = Region.new(region_params)
    if @region.save
      redirect_to request.referrer,notice: "新規エリアの作成に成功しました。"
    else
      render :new,　status: :unprocessable_entity
    end
  end
  
  def destroy
    @region = Region.find(params[:id])
    @region.destroy
    redirect_to request.referrer, status: :see_other
  end
  
  private
  
  def region_params
    params.require(:region).permit(:regionname, :event_id, :user_id, :prefecture_id)
  end
  
end
