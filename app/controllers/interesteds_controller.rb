class InterestedsController < ApplicationController
    def create
        @Interested = current_user.interesteds.create(event_id: params[:event_id])
        session[:previous_url] = request.referer
        redirect_back(fallback_location: root_path)
    end
    
    def destroy
        @event = Event.find(params[:event_id])
        @Interested = current_user.interesteds.find_by(event_id: @event.id)
        @Interested.destroy
        redirect_to session[:previous_url], status: :see_other
    end
end
