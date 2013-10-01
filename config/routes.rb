WashCostApp::Application.routes.draw do

  namespace :advanced do
    namespace :water do
      resources :question_option_groups
    end
  end


  namespace :advanced do
    namespace :water do
      resources :question_options
    end
  end

  devise_for :users, :controllers => { :registrations => "registrations" }

  namespace :advanced do
    namespace :water do
      resources :questionnaires
    end
  end

  namespace :basic do
    resource :reports do
      member do
        post :save
        post :load
      end
    end
  end

  resources :dashboard

  #resource :home do
  #  get :marketing
  #  get :selection
  #
  #  post :calculator
  #
  #end

  resources :subscribers

  get '/cal/water_basic/header_navigation', to: 'water_basic#header_navigation'
  get '/cal/sanitation_basic/header_navigation', to: 'sanitation_basic#header_navigation'

  match '/dashboard' => 'dashboard#index'
  match '/home/calculator' => 'home#calculator'
  match '/home/sign_in' => 'home#sign_in'
  match '/cal' => 'home#index'

  match '/infographic' => 'infographic#index'
  match '/infographic/mobile' => 'mobile#infographic'
  match '/mobile' => 'mobile#index'

  match '/cal/water_basic' => 'water_basic#country'
  match '/cal/water_basic/(:action)' => 'water_basic#(:action)', :via => [:get, :post]

  match '/cal/sanitation_basic' => 'sanitation_basic#country'
  match '/cal/sanitation_basic/(:action)' => 'sanitation_basic#(:action)', :via => [:get, :post]

  match '/water_advanced' => 'water_advanced#index'
  match '/water_advanced/(:action)' => 'water_advanced#(:action)', :via=> [:get,:post]

  match '/sanitation_advanced' => 'sanitation_advanced#index'
  match '/sanitation_advanced/(:action)' => 'sanitation_advanced#(:action)', :via=> [:get,:post]

  get "/path" => "controller#get_action"
  post "/path" => "controller#post_action"

  match '/clean_session', :controller => 'application', :action => 'clean_session'

  root :to => "marketing#marketing_info"
end
