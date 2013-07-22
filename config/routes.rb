WashCostApp::Application.routes.draw do


  match '/', :controller => 'application', :action => 'index'
  match '/select_advanced' => 'application#select_advanced'

  match '/water_basic' => 'water_basic#country'
  match 'water_basic/(:action)' => 'water_basic#(:action)', :via => [:get, :post]

  match '/sanitation_basic' => 'sanitation_basic#country'
  match 'sanitation_basic/(:action)' => 'sanitation_basic#(:action)', :via => [:get, :post]

  match '/water_advanced' => 'water_advanced#index'
  match '/water_advanced/(:action)' => 'water_advanced#(:action)', :via=> [:get,:post]


  get "/path" => "controller#get_action"
  post "/path" => "controller#post_action"
end
