RedmineApp::Application.routes.draw do	
  match '/auth/:provider/callback', :to => 'account#socio_connect_authenticate', :via => [:get, :post], :as => 'socio_connect_authenticate'
end