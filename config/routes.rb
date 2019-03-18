Dps::Engine.routes.draw do
  scope '/dps/v1' do

    resource :info, only: [:show], controller: 'info'

    resources :payments, only: [] do
      collection do
        get 'new/:endpoint', action: 'new'
      end
    end

  end
end
