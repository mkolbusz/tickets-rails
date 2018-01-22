namespace :set_ticket_prices do
    desc "Task to set prices for tickets at the day of the event"
    task set_prices: [:environment] do
        @tickets = Ticket.all
        @tickets.each do |t|
            t.set_price
            t.save
        end
    end
end
