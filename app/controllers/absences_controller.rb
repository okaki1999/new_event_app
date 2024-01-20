class AbsencesController < ApplicationController
    def create
        @absence = current_user.absences.create(event_id: params[:event_id])
        session[:previous_url] = request.referer
        redirect_back(fallback_location: root_path)
    end
    
    def destroy
        @event = Event.find(params[:event_id])
        @absence = current_user.absences.find_by(event_id: @event.id)
        @absence.destroy
        redirect_to session[:previous_url], status: :see_other
    end
end
