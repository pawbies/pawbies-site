Rails.application.routes.draw do
  post "email_verification/:user_id" => "email_verifications#create", as: :email_verification
  get "email_verification/:token" => "email_verifications#update", as: :update_email_verification
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
