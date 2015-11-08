Rails.application.routes.draw do
  resources :letters
  devise_for :users

  authenticate :user, lambda { |user| user } do
    mount Blazer::Engine, at: "/"
  end
end
