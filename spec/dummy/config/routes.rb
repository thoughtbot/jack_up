Rails.application.routes.draw do
  resources :assets, only: [:create, :show]
  root to: 'high_voltage/pages#show', id: 'home'
  mount JackUp::Engine => "/jack_up"
end
