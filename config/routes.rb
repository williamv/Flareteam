Flareteam::Application.routes.draw do

  resources :activations do
    resources :comments
  end

  resources :organizations

  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations" }
  resource :profile

  root :to => 'activations#index'
end
