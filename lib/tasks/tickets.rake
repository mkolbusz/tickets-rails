namespace :tickets do
    desc "Task to set prices for tickets at the day of the event"
    task set_prices: [:environment] do
        @tickets = Ticket.all
        @tickets.each do |t|
            t.set_price
            t.save
        end
    end

    desc "Set status of events"
    task set_status: [:environment] do
        @events = Event.before(Date.today)
        @events.each do |e|
            e.status = 1
            e.save
        end
    end
end
