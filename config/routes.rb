Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :api, as: 'api' do
    resources :short_urls, only: :create, default: :json
  end

  get ':code', to: 'short_urls#show', as: :short_urls
end
