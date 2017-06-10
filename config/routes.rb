Rails.application.routes.draw do
  root "pages#index"
  
  # Courses / Sections
  resources :courses do
    resources :sections do
      member do
        post :enroll
      end
    end
  end

  # Sessions
  get  '/login'  => 'sessions#new'
  post '/login'  => 'sessions#create'
  get  '/logout' => 'sessions#destroy'

  # Students
  resources :students, except: [:index, :show] do
    collection do
      get '/:id' => 'students#dashboard'
    end
  end
end
