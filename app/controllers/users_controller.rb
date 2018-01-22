class UsersController < ApplicationController
    before_action :authenticate_user!

    def events
        start_date = params[:start_date].try(:to_date) || nil
        end_date = params[:end_date].try(:to_date) || nil
        if start_date || end_date
            @events = Event.joins(:tickets).between_times(start_date, end_date, field: :event_date).merge(Ticket.where(user: current_user)).group(:event_id)
        else
            @events = Event.joins(:tickets).merge(Ticket.where(user: current_user)).group(:event_id)
        end
    end
 
    def add_money
        if params[:money].try(:to_d)
            current_user.money += params[:money].to_d
            if current_user.save
                flash[:notice] = "Money added successfully"
                redirect_to events_path
            else
                flash[:error] = "Error while adding money"
                redirect_to edit_user_registration_path
            end
        end
    end
end
