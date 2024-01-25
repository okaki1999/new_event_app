class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def line
      basic_action
    end
  
    private
  
    def basic_action
      @omniauth = request.env["omniauth.auth"]
      if @omniauth.present?
        @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
  
        # デフォルトで region_id を 1 に設定
        @profile.region_id = Region.first
  
        if @profile.email.blank?
          email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
          @profile = current_user || User.create!(
            provider: @omniauth["provider"],
            uid: @omniauth["uid"],
            email: email,
            username: @omniauth["info"]["name"],
            password: Devise.friendly_token[0, 20]
            region: @profile.region_id
          )
        end
  
        @profile.set_values(@omniauth)
        sign_in(:user, @profile)
      end
  
      flash[:notice] = "ログインしました"
      redirect_to root_path
    end
  
    def fake_email(uid, provider)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
  