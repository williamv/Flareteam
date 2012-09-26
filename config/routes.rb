Flareteam::Application.routes.draw do
  resources :activations

  resources :activations, :organizations

  devise_for :users, controllers: { sessions: "sessions" }

  root :to => 'activations#index'
end
