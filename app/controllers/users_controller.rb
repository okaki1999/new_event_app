class UsersController < ApplicationController
  #アクセス制限（ログインしていない時index以外にアクセスできなくなる）
  before_action :authenticate_user!, except: [:index]
  def index
    @users = User.all
    @q = User.ransack(params[:q])
    @s_users = @q.result(distinct: true)
  end
  


  def show
    @user = User.find(params[:id])
    @following_users = @user.following_users
    @follower_users = @user.follower_users
    @name = @user.username
        @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id then
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      if @is_room
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    
  end

  def edit
    @user = User.find(params[:id])
    #アクセス制限（ログインユーザーと違うユーザーがプロフィール編集にアクセスできなくする）
    if @user != current_user
      redirect_to users_path, alert: "不正なアクセスです。"
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user) ,notice: "更新に成功しました。"
    else
      render :edit
    end
  end
  
 def follows
   user = User.find(params[:id])
   @c_user = User.find(params[:id])
   @users = user.following_users
   @name = user.username
   @img = user.avatar
 end

 def followers
   user = User.find(params[:id])
   @c_user = User.find(params[:id])
   @user = user.follower_users
   @name = user.username
   @img = user.avatar
 end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to request.referrer || root_path
  end
  
  def search
    word = params[:search_word]
    @posts = Post.search(word)
  end
  
  private

  
  def user_params
    params.require(:user).permit(:username, :email, :profile, :avatar, :region_id, :gender, :age )
  end
  
end
