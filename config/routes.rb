Rails.application.routes.draw do
	root "assignments#index"
	devise_for :admins
  resources :drivers
  resources :riders
  resources :assignments
end
