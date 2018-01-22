class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :buy, :bought, :return_payment, :return_payment_confirmation]
  before_action :check_max_number_of_tickets, only: [:buy, :bought]

  # GET /tickets
  # GET /tickets.json
  def index
    if current_user.is_admin
      @tickets = Ticket.paginate(:page => params[:page], :per_page => 10)
    else
      @tickets = current_user.tickets
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end
 
  # POST /tickets
  # POST /tickets.json
  def create
    ticket_params.inspect
    @ticket = Ticket.new(ticket_params)
    @ticket.user = nil
    @ticket.status = "for_sale"
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def buy
  end

  def bought
    ticket_params = params.require(:ticket).permit(:user_id, :address, :email_address, :name, :phone)
    @ticket.update(ticket_params)
    @ticket.sale_date = Date.today
    @ticket.status = "sold"
    @ticket.user = current_user
    current_user.money = current_user.money - @ticket.price
    @ticket.event.max_seats_number = @ticket.event.max_seats_number - 1
    if @ticket.save && @ticket.event.save && current_user.save
      flash[:notice] = "Ticket purchased successfully."
      redirect_to events_path
    else
      flash[:error] = "Error occured."
      redirect_to "/events/#{@event.id}"
    end
  end

  def return_payment 
    if @ticket.waiting_for_confirmation!
      flash[:notice] = "Ticket waiting for admin confirmation."
    else
      flash[:error] = "Error while returnig ticket."
    end

    redirect_to tickets_path
  end

  def return_payment_confirmation
    @ticket.user.money =+ @ticket.return_value
    if @ticket.user.save
      @ticket.user = nil;
      @ticket.event.max_seats_number = @ticket.event.max_seats_number + 1
      if @ticket.for_sale! &&  @ticket.event.save
        flash[:notice] = "Ticket's returning confirmed"
      else
        flash[:error] = "Error while confirmation."
      end
    else
      flash[:error] = "Error while confirmation."
    end
    redirect_to tickets_path
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :seat_id_seq, :address, :price, :email_address, :event_id)
    end

    def check_max_number_of_tickets
      tickets_number = @ticket.event.tickets.where(user: current_user).count
      if(tickets_number >= 5)
        flash[:alert] = "You have reached the maximum number of tickets for this event."
        redirect_to "/events/#{@ticket.event.id}"
      end
    end

    def calculate_return_value(ticket) 

    end
end
