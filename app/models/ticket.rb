class Ticket < ApplicationRecord
    enum status: [:for_sale, :sold, :waiting_for_confirmation]

    validates :price, presence: true
    validates :seat_id_seq, presence: true

    validate :price_in_range

    belongs_to :event
    belongs_to :user, required: false

    before_save :round_price

    def price_in_range
        if price < event.price_low || price > event.price_high
            errors.add('Cena biletu', 'nie może być spoza zakresu')
        end
    end

    # @TODO Fix calculating return value
    def return_value
        diff = (self.event.event_date - self.created_at.to_date).to_i
        if diff > 0
            part = diff/50.0
            percent = ((self.event.event_date - Date.today).to_i * part)
            value = self.price * (1 - percent/100);
        else
            value = self.price * 0.4
        end
        value
    end

    def is_for_sell
        (self.event.event_date - Date.today).to_i <= 30
    end

    def set_price
        if(self.event.event_date == Date.today)
            self.price = (1.2 * self.price).round(2)
        end
    end
    
private
    def round_price
        self.price = '%.2f' % self.price
    end

    def no_more_seats
        if self.event.tickets.count == self.event.max_seats_number
            errors.add('Brak miejsca', 'wszystkie dostępne miejsca mają już bilety')
        end
    end

    
end