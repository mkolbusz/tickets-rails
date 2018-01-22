class Event < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    validates :price_low, presence: true, numericality: true
    validates :price_high, presence: true, numericality: true
    validates :event_date, presence: true

    validate :event_date_not_from_past, :price_low_lower_than_price_high

    has_many :tickets
    has_one :status
    belongs_to :user

    def event_date_not_from_past
        if event_date < Date.today
            errors.add('Data wydarzenia', 'nie może być wcześniejsza niż dzisiaj')
        end
    end

    def price_low_lower_than_price_high
        if(price_low > price_high)
            errors.add('Cena minimalna', 'nie może byc większa od ceny maksymalnej')
        end
    end
end
