Rails.application.routes.draw do
  resources :users, only: [:show, :index]

  resources :letters do
    member do
      post :deliver
    end
  end

  devise_for :admins

  authenticate :admin, lambda { |user| user } do
     mount Blazer::Engine, at: "/admin"
   end
end
