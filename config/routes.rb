Flareteam::Application.routes.draw do
  resources :organizations

  devise_for :users, controllers: { sessions: "sessions" }

  root :to => 'welcome#index'
end
