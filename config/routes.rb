Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resource :session, only: %i[create] do
        post :signup, on: :collection
      end

      resource :users, only: %i[update show] do
        collection do
          get :show_profile
        end
      end

      resources :meals, except: %i[edit new]
    end
  end
end
