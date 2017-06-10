Rails.application.routes.draw do
  root "pages#index"

  resources :courses do
    resources :sections
  end
end
