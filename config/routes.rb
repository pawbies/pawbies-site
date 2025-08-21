Rails.application.routes.draw do
  get "email_verifications/create"
  get "email_verifications/update"
  resources :email_verifications, param: :token
  resource :session
  resources :passwords, param: :token
  resources :users

  get "up" => "rails/health#show", as: :rails_health_check

  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "pages#home"
  get "about" => "pages#about"
  get "contact" => "pages#contact"
  get "privacy" => "pages#privacy"
  get "imprint" => "pages#imprint"
end
