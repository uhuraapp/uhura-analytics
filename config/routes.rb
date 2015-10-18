Rails.application.routes.draw do
  devise_for :users

  authenticate :user, lambda { |user| user } do
    mount Blazer::Engine, at: "blazer"
  end
end
