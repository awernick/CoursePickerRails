Rails.application.routes.draw do
  root "pages#index"

  resources :courses do
    resources :sections do
      member do
        post :enroll
      end
    end
  end
end
