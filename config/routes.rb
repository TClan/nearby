Rails.application.routes.draw do
  scope 'api' do
    scope 'v1' do
      resources :drivers, only: [:index, :update]
    end
  end
end
