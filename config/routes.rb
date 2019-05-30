Rails.application.routes.draw do
  match '/', to: 'application#index', via: [:get, :post], as: 'root'
end
