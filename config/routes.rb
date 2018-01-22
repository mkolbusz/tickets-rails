Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}

  resources :events, :only => [:index, :new, :create, :show]

  resources :tickets
  get '/tickets/:id/buy', to: 'tickets#buy', as: :ticket_buy
  patch '/tickets/:id/bought', to: 'tickets#bought', as: :ticket_bought
  get '/tickets/:id/return', to: 'tickets#return_payment', as: :ticket_return
  get '/tickets/:id/return_confirmation', to: 'tickets#return_payment_confirmation', as: :ticket_return_confirmation

  get '/user/events', to: 'users#events', as: :user_events
  post '/user/add_money', to: 'users#add_money', as: :user_add_money

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "events#index"
end
