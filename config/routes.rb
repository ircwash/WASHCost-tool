WashCostApp::Application.routes.draw do

  devise_for :users, :controllers => { :sessions => 'sessions', :registrations => 'registrations' }

  namespace :basic do
    resource :reports do
      member do
        post :save
        post :load
      end
    end
  end

  resources :dashboard
  resources :subscribers

  get '/cal/water_basic/redirect_to_action', to: 'water_basic#redirect_to_action'
  get '/cal/sanitation_basic/redirect_to_action', to: 'sanitation_basic#redirect_to_action'

  get '/cal/water_basic/header_navigation', to: 'water_basic#header_navigation'
  get '/cal/sanitation_basic/header_navigation', to: 'sanitation_basic#header_navigation'

  match '/dashboard' => 'dashboard#index'

  match '/home/sign_in' => 'home#sign_in'

  match '/cal' => 'home#index'
  match '/home/calculator' => 'home#calculator'

  match '/infographic' => 'infographic#index'
  match '/infographic/mobile' => 'mobile#infographic'
#  match '/mobile' => 'mobile#index'

  match '/cal/water_basic' => 'water_basic#country'
  match '/cal/water_basic/(:action)' => 'water_basic#(:action)', :via => [:get, :post]

  match '/cal/sanitation_basic' => 'sanitation_basic#country'
  match '/cal/sanitation_basic/(:action)' => 'sanitation_basic#(:action)', :via => [:get, :post]

  match '/cal/water_advanced' => 'water_advanced#questionnaire'
  match '/cal/water_advanced/(:action)' => 'water_advanced#(:action)', :via=> [:get,:post]

  match '/cal/sanitation_advanced' => 'advanced#sanitation'
  match '/cal/sanitation_advanced/(:action)' => 'advanced#(:action)', :via=> [:get,:post]

#  get '/path' => 'controller#get_action'
#  post '/path' => 'controller#post_action'

  match '/clean_session', :controller => 'application', :action => 'clean_session'

  root :to => "marketing#index"
end
