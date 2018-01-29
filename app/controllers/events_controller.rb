class EventsController < ApplicationController

  before_action :check_logged_in, :only => [:new, :create]
  before_action :set_event, :only => [:show, :edit, :update]

  def index
    if user_signed_in? && current_user.is_admin
      @events = Event.all
    else 
      statuses = Status.where(only_admin: false)
      @events = Event.where(status_id: statuses)
    end

    if params[:name]
      @events = @events.where("name LIKE :search", search: "%#{params[:name]}%")
    end
  end

  def new
    @event = Event.new
  end

  def create
    event_params = params.require(:event).permit(:name, :description, :price_low, :price_high, :event_date, :status_id, :max_seats_number, :user_id)
    @event = Event.new(event_params);
    @event.user = current_user
    if @event.save
      flash[:successfullyAdded] = "Event successfully created!"
      redirect_to "/events/#{@event.id}"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    event_params = params.require(:event).permit(:name, :description, :price_low, :price_high, :event_date, :status_id, :max_seats_number)

    if @event.update(event_params)
      flash[:notice] = "Event updated"
      redirect_to events_path
    else
      flash[:notice] = "Error occured while updating event"
      redirect_to edit_event_path(@event)
    end
  end


  private
  def check_logged_in
    authenticate_or_request_with_http_basic("Ads") do |username, password|
      username == 'admin' && password == 'admin'
    end
  end

  def set_event 
    @event = Event.find(params[:id])
  end
end
