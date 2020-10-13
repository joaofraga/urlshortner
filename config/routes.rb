Rails.application.routes.draw do
  get 'home', to: 'main#home'
  post 'create', to: 'main#create', as: :create

  get ':short_code', to: 'main#show', as: :show
  root 'main#home'
end
