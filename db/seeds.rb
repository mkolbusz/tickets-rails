# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




Status.create(name: "Trwa sprzedaż biletów")
Status.create(name: "Archiwalne", only_admin: true)
Status.create(name: "Odwołane")
Status.create(name: "Nieaktywne", only_admin: true)

User.create(:email => "admin@admin.pl", :date_of_birth => Date.new(1993,2,2), :is_admin => true, :password => "xzaq1234", :password_confirmation => "xzaq1234", :name => "Admin Admin", :address => "ul. Miodowa 27/10\n34-207 Kraków", :phone => "001002003", :money => 250)

User.create(:email => "jan@kowalski.pl", :date_of_birth => Date.new(1992,2,2), :password => "xzaq1234", :password_confirmation => "xzaq1234", :name => "Jan Kowalski", :address => "ul. Czarnowiejska 12\n34-207 Kraków", :phone => "010020030", :money => 150)

User.create(:email => "bartosz@nowak.pl", :date_of_birth => Date.new(2005,10,5), :password => "xzaq1234", :password_confirmation => "xzaq1234", :name => "Bartosz Nowak", :address => "ul. Piastowska 12\n34-207 Kraków", :phone => "230520450", :money => 120)

letters = ['A', 'F', 'G', 'H', 'K', 'P']

Event.create(:name => "Puchar Świata w Zakopanem", :description => "Puchar Świata w skokach narciarskich w Zakopanem", :address => "Wileka Krokiew 1\n30-201 Zakopane", :price_low => 150, :price_high => 320, :event_date => Date.new(2018,1,27), :max_seats_number => 15, :adults_only => false, :status_id => 1, :user_id => 1)


5.times do |n|
    3.times do |x|
        Ticket.create(:seat_id_seq => "#{letters[n]}#{x}", :event_id => 1, :price => 150 + n*(320 - 150)/5.0);
    end
end


e = Event.create(:name => "40-lecie Zespołu Pod Budą", :description => "40-LECIE ZESPOŁU POD BUDĄZnakomite połączenie 2 niepowtarzalnych projektów w 1 koncercie! Jubileusz 40 - lecia Zespołu Pod Budą, oraz wyjątkowa muzyka Zespołu Andrzeja i Maji Sikorowskich.", :address => "Rynek Główny 7\n30-072 Kraków", :price_low => 80, :price_high => 130, :event_date => Date.new(2018,1,27), :max_seats_number => 6, :adults_only => false, :status_id => 1,:user_id => 1)

letters = ['A0', 'F0', 'G0', 'H0', 'K0', 'P0']
3.times do |n|
    1.times do |x|
        Ticket.create(:seat_id_seq => "#{letters[n]}#{x}", :event_id => e.id, :price => 80 + n*(130 - 80)/3.0);
    end
end

e = Event.create(:name => "Walentynki ze Sławomirem", :description => "'Cześć, tu Sławomir' - Spędź niezapomniane Walentynki ze Sławomirem! Już 17 lutego na warszawskim Torwarze zagra dla Was największa Gwiazda Rock Polo.", :address => "'Kawiarnia Róż'\nul. Piastowska 24\n30-250 Bielsko-Biała", :price_low => 50, :price_high => 120, :event_date => Date.new(2018,1,22), :max_seats_number => 24, :adults_only => true, :status_id => 1, :user_id => 1)

6.times do |n|
    4.times do |x|
        Ticket.create(:seat_id_seq => "#{letters[n]}#{x}", :event_id => e.id, :price => 50 + n*(120 - 50)/6.0);
    end
end

e = Event.create(:name => "Organek", :description => "Koncert Organka", :address => "Tauron Arena Krakow", :price_low => 100, :price_high => 250, :event_date => Date.today, :max_seats_number => 10, :adults_only => false, :status_id => 1, :user_id => 1)

5.times do |n|
    2.times do |x|
        Ticket.create(:seat_id_seq => "#{letters[n]}#{x}", :event_id => e.id, :price => 100);
    end
end