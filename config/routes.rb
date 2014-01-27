WashCostApp::Application.routes.draw do

  match '/infographic' => 'infographic#index'
  match '/infographic/mobile' => 'mobile#infographic'

  scope '/:locale', locale: /en|fr/ do

    devise_for :users, :controllers => { :sessions => 'sessions', :registrations => 'registrations', :passwords => 'passwords' }

    resources :dashboard

    resources :subscribers

    scope '/calculators' do

      post '/selection' => 'calculators#selection'

      namespace :basic do

        scope '/report' do
          get  '/questionnaire', :to => 'reports#questionnaire', :as => 'report_questionnaire'
          post '/save', :to => 'reports#save', :as => 'report_save'
          post '/load', :to => 'reports#load', :as => 'report_load'
        end

        scope '/water' do
          get   '/report', :to => 'water#report', :as => 'water_report'
          match '/:action' => 'water#(:action)', :via => [ :get, :post ], :as => 'water_action'
          root :to => redirect( '/%{locale}/calculators/basic/water/country' ), :as => 'water'
        end

        scope '/sanitation' do
          get   '/report', :to => 'sanitation#report', :as => 'sanitation_report'
          match '/:action' => 'sanitation#(:action)', :via => [ :get, :post ], :as => 'sanitation_action'
          root :to => redirect( '/%{locale}/calculators/basic/sanitation/country' ), :as => 'sanitation'
        end

      end

      root :to => 'calculators#index', :as => 'calculators'

    end

    match '/dashboard' => 'dashboard#index', :as => 'dashboard'

    root :to => 'landing#index', :as => 'localised_root'

  end

  root :to => redirect( "/#{I18n.default_locale}/" )

end
