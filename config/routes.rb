Rails.application.routes.draw do
  root "courses#index"
  
  # Sections
  post '/sections/:uuid/enroll' => 'sections#enroll', as: :enroll_section
  post '/sections/:uuid/drop' => 'sections#drop', as: :drop_section

  # Courses / Sections
  resources :courses do
    resources :sections
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
