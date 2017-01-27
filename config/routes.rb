Rails.application.routes.draw do
  scope 'api' do
    scope 'v1' do
      put 'drivers/:driver_id/location', to: 'drivers#location'
      get 'drivers', to: 'drivers#index'
    end
  end
end
