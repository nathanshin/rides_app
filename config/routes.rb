Rails.application.routes.draw do
	root "assignments#index"
  resources :drivers
  resources :riders
  resources :assignments
end
