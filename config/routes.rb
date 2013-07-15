WashCostApp::Application.routes.draw do

  get "water_basic/index"

  match '/', :controller => 'application', :action => 'index'

  match '/water_basic', :controller => 'water_basic', :action => 'country'
  match 'water_basic/(:action)' => 'water_basic#(:action)', :via => [:get, :post]

  match '/sanitation_basic', :controller => 'sanitation_basic', :action => 'country'
  match 'sanitation_basic/(:action)' => 'sanitation_basic#(:action)', :via => [:get, :post]

  match '/water_advanced', :controller => 'water_advanced', :action => 'index'
  match '/water_advanced/(:action)' => 'water_advanced#(:action)', :via=> [:get,:post]
end
