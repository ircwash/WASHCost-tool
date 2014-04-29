require 'api_constraints'

WashCostApp::Application.routes.draw do
  use_doorkeeper

  match '/infographic' => 'infographic#index'
  match '/infographic/mobile' => 'mobile#infographic'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      devise_for :users
      resources :advanced
      resources :users, only: [:index, :me, :create] do
        get 'me', on: :collection
      end
    end
  end

  scope "(:locale)", :locale => /en|fr/ do

    devise_scope :user do
      get 'users' => 'authentication/registrations#new'
    end

    devise_scope :user do
      get 'users/password' => 'authentication/passwords#new'
    end

    devise_for :users, :controllers => { :sessions => 'authentication/sessions', :registrations => 'authentication/registrations', :passwords => 'authentication/passwords' }

    resources :dashboard

    scope '/calculators' do

      namespace :basic do

        scope '/water' do
          get '/begin' => 'water#begin', :as => 'water_begin'
          get '/report' => 'water#report', :as => 'water_report'
          get '/report/save' => 'water#save_report', :as => 'water_save_report'
          post '/report/save' => 'water#store_report', :as => 'water_store_report'
          get '/report/share' => 'water#share_report', :as => 'water_share_report'
          get  '/:section' => 'water#questionnaire', :as => 'water_action'
          post '/update/:section' => 'water#update', :as => 'water_update'
          post '/dynamic_update' => 'water#dynamic_update', :as => 'water_dynamic_update'
          root :to => redirect( '/%{locale}/calculators/basic/water/country' ), :as => 'water'
        end

        scope '/sanitation' do
          get '/begin' => 'sanitation#begin', :as => 'sanitation_begin'
          get '/report' => 'sanitation#report', :as => 'sanitation_report'
          get '/report/save' => 'sanitation#save_report', :as => 'sanitation_save_report'
          post '/report/save' => 'sanitation#store_report', :as => 'sanitation_store_report'
          get '/report/share' => 'sanitation#share_report', :as => 'sanitation_share_report'
          get  '/:section' => 'sanitation#questionnaire', :as => 'sanitation_action'
          post '/update/:section' => 'sanitation#update', :as => 'sanitation_update'
          post '/dynamic_update' => 'sanitation#dynamic_update', :as => 'sanitation_dynamic_update'
          root :to => redirect( '/%{locale}/calculators/basic/sanitation/country' ), :as => 'sanitation'
        end

      end

      namespace :advanced do

        scope '/water' do
          get '/begin' => 'water#begin', :as => 'water_begin'
          get '/report' => 'water#report', :as => 'water_report'
          get '/report/save' => 'water#save_report', :as => 'water_save_report'
          post '/report/save' => 'water#store_report', :as => 'water_store_report'
          get '/report/share' => 'water#share_report', :as => 'water_share_report'
          get  '/:section' => 'water#questionnaire', :as => 'water_action'
          post '/update/:section' => 'water#update', :as => 'water_update'
          post '/dynamic_update' => 'water#dynamic_update', :as => 'water_dynamic_update'
          root :to => redirect( '/%{locale}/calculators/advanced/water/service_area' ), :as => 'water'
        end

        scope '/sanitation' do
          get '/begin' => 'sanitation#begin', :as => 'sanitation_begin'
          get '/report' => 'sanitation#report', :as => 'sanitation_report'
          get '/report/save' => 'sanitation#save_report', :as => 'sanitation_save_report'
          post '/report/save' => 'sanitation#store_report', :as => 'sanitation_store_report'
          get '/report/share' => 'sanitation#share_report', :as => 'sanitation_share_report'
          get  '/:section' => 'sanitation#questionnaire', :as => 'sanitation_action'
          post '/update/:section' => 'sanitation#update', :as => 'sanitation_update'
          post '/dynamic_update' => 'sanitation#dynamic_update', :as => 'sanitation_dynamic_update'
          root :to => redirect( '/%{locale}/calculators/advanced/sanitation/service_area' ), :as => 'sanitation'
        end

      end

      post '/selection' => 'calculators#selection'

      root :to => 'calculators#index', :as => 'calculators'

    end

    get '/dashboard' => 'dashboard#index', :as => 'dashboard'
    get '/report/destroy/:id' => 'reports#destroy', :as => 'reports_destroy'
    get '/report/:id' => 'reports#load', :as => 'reports_load'
    put '/report' => 'reports#update', :as => 'report'

    root :to => 'landing#index', :as => 'localised_root'

  end

  root :to => redirect( "/#{I18n.default_locale}/" )

end
