Rails.application.routes.draw do
  resources :letters do
    member do
      post :deliver
    end
  end

  devise_for :users

  authenticate :user, lambda { |user| user } do
    mount Blazer::Engine, at: "/"
  end
end
