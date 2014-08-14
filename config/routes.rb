Rails.application.routes.draw do
  resources :counters do
    collection do
      post 'serach'
    end
  end
  
end
