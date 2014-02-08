PostitTemplate::Application.routes.draw do
  root to: 'posts#index' #just root is ok here too


  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end

  resources :categories, only: [:index, :new, :create, :show]
end

# stock set of routes, replaced by resources :posts
  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # get '/posts/:id/edit', to: 'posts#edit'
  # patch '/posts/:id', to: 'posts#update'

# can set controller with: ", controller: 'controller_name'"