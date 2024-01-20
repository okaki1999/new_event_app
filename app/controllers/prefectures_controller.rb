class PrefecturesController < ApplicationController
  def index
    @prefectures = Prefecture.all
  end
  
  def show
    @prefectures = Prefecture.all
  end
  
  def new
    @prefecture = Prefecture.new
  end
  
  def create
    @prefecture = Prefecture.new(prefecture_params)
    if @prefecture.save
      redirect_to request.referrer,notice: "新規エリアの作成に成功しました。"
    else
      render :new,　status: :unprocessable_entity
    end
  end
  
  def destroy
    @prefecture = Prefecture.find(params[:id])
    @prefecture.destroy
    redirect_to request.referrer, status: :see_other
  end
  
  private
  
  def prefecture_params
    params.require(:prefecture).permit(:prefecturename, :region_id, :user_id)
  end
end
