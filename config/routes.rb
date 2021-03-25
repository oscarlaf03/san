Rails.application.routes.draw do
  use_doorkeeper do
    controllers tokens: 'custom_tokens'
    skip_controllers :authorizations, :applications, :authorized_applications

  end

  resources :conta_bancarias
  resources :seguradoras
  resources :planos

  resources :beneficios

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


  resources :organizacoes do
    resources :users, controller: 'organizacao_users', path: 'users'
    resources :organizacao_plano, controller: 'organizacao_planos', path: 'planos'
    resources :beneficiarios
  end


  namespace :api, defaults: {format: :json} do
    post 'password_reset' , to: 'passwords#reset'
    post 'confirm_user', to: 'confirmations#confirm'
    namespace :v1 do
      resources :organizacoes do
        resources :beneficiarios
        resources :organizacao_planos, path: 'planos'
        resources :condicoes
        resources :beneficios
        resources :users, controller: 'organizacao_users', only: [:index,:create]

      end
      resources :seguradoras do
        resources :planos
      end
      resources :users
      resources :organizacao_planos, only: [:create,:update]
    end
  end
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
