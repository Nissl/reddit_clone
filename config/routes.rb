PostitTemplate::Application.routes.draw do
  root to: 'posts#index' #just root is ok here too

  get '/register', to: 'users#new'#, as: 'register'
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"

  resources :posts, except: [:destroy] do
    member do 
      post :vote
    end
    resources :comments, only: [:create] do
      member do 
        post :vote
      end
    end
  end

  resources :categories, only: [:index, :new, :create, :show]
  resources :users, only: [:show, :create, :edit, :update]
end

# stock set of routes, replaced by resources :posts
  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # get '/posts/:id/edit', to: 'posts#edit'
  # patch '/posts/:id', to: 'posts#update'

# can set controller with: ", controller: 'controller_name'"