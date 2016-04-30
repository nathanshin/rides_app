Rails.application.routes.draw do
	root "assignments#index"
	get 'signup' => "user_signups#signup"
	get 'thankyou' => "user_signups#thankyou"
	devise_for :admins
  resources :drivers
  resources :riders
  resources :assignments
end
