Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    get '/health_check' => 'health_check#index'

    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
end
