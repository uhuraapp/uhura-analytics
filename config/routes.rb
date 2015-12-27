Rails.application.routes.draw do
  resources :letters do
    member do
      post :deliver
    end
  end

  devise_for :admins

  authenticate :admin, lambda { |user| user } do
    mount Blazer::Engine, at: "/"
  end
end
