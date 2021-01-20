Rails.application.routes.draw do
  resources :conta_bancarias
  resources :beneficios
  resources :seguradoras
  resources :planos
  resources :organizacoes
  devise_for :users, path: 'u', controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    unlocks: "users/unlocks"
  }

  devise_for :beneficiarios, path: 'b', controllers: { 
    sessions: "beneficiarios/sessions",
    passwords: "beneficiarios/passwords",
    registrations: "beneficiarios/registrations",
    confirmations: "beneficiarios/confirmations",
    unlocks: "beneficiarios/unlocks"
  }

  resources :beneficiarios
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
