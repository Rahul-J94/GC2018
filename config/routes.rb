Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'staticpage#index'
  get 'city' => 'staticpage#city'
  get 'privacy' => 'staticpage#privacy'
  get 'lookandbrand' => 'staticpage#lookandbrand'
  get 'whoweare' => 'staticpage#whoweare'
  get 'contact' => 'staticpage#contact'
  get 'sports' => 'staticpage#sports'
  get 'package' => 'staticpage#package'

  get 'createownpackage' => 'staticpage#createownpackage'
  get 'test_payment' => 'staticpage#test_payment'
  get 'swimmingpackages/details' => 'staticpage#swimmingpackages'
  get 'athleticspackages' => 'staticpage#athleticspackages'
  get 'rugbypackages' => 'staticpage#rugbypackages'
  get 'rugbypackages/gold' => 'staticpage#rugbypackages_gold'
  get 'rugbypackages/silver' => 'staticpage#rugbypackages_silver'
  get 'rugbypackages/bronze' => 'staticpage#rugbypackages_bronze'
  get 'openingpackages/details' => 'staticpage#openingpackages'
  get 'athleticspackages/platinum' => 'staticpage#athleticspackages_platinum'
  get 'athleticspackages/gold' => 'staticpage#athleticspackages_gold'
  get 'athleticspackages/silver' => 'staticpage#athleticspackages_silver'
  get 'athleticspackages/silver_brisbane' => 'staticpage#athleticspackages_silver_brisbane'
  get 'athleticspackages/bronze' => 'staticpage#athleticspackages_bronze'
  post 'sign_up' => 'session#sign_up'
  match 'activate_user/:activation_code' => 'session#activate_user', :via => [:get, :post]
  post 'reset' => 'session#reset'
  post 'authentication' => 'session#authentication'
  match 'reset_password/:activation_code' => 'session#reset_password' , :via => [:get, :post]
  match 'change_pass' => 'session#change_pass', :via => [:get,:post]
  get 'logout' => 'session#logout'
  get 'update_profile' => 'session#update_profile'
  post 'change_info' => 'session#change_info'
  match 'findemail' => 'session#findemail', :via => [:get, :post]
  match 'reset_user' => 'session#reset_user', :via => [:get, :post]
  match 'hotel_info/:id' => 'hotel#info', :via => [:get, :post]
  match 'accommodation' => 'hotel#accommodation', :via => [:get, :post]
  match 'cart' => 'shopping_cart#index', :via => [:get, :post]
  match 'add_cart' => 'shopping_cart#add_cart', :via => [:get, :post]
  match 'event_add_cart' => 'shopping_cart#event_add_cart', :via => [:get, :post]
  match 'remove_from_cart_hotel/:id' => 'shopping_cart#remove_from_cart_hotel', :via => [:get, :post]
  match 'remove_from_cart_event/:id' => 'shopping_cart#remove_from_cart_event', :via => [:get, :post]
  get '/checkout/' => 'shopping_cart#checkout'
  get '/my_transaction/' => 'shopping_cart#my_transaction'
  post '/make_payment/' => 'shopping_cart#make_payment'
  # get 'authf' => 'session#authf'
  post 'subscribe' => 'staticpage#subscribe'
  match 'check_user' => 'staticpage#check_user', :via => [:get, :post]

  get '/event/index/' => 'event#index'
  get '/event/show/:event_uid' => 'event#show'

  get "kingxadminp" => 'admin#index'
  get "admin/index_ajax" => 'admin#index_ajax'
  get "/admin/transaction/show/:pay_id" => 'admin#transaction_detail'
  get '/thank_you' => 'staticpage#thank_you'
  get '/tour' => 'staticpage#tour'

  post '/book_function' => 'staticpage#book_function'
  # comment after demo
  get 'hotel/plazzo' => 'staticpage#plazzo'
  get 'hotel/synergy' => 'staticpage#synergy'
  get 'hotel/artique_resort' => 'staticpage#artique_resort'
  get 'hotel/ocean_pacific' => 'staticpage#ocean_pacific'
  get 'hotel/south_pacific_plaza' => 'staticpage#south_pacific_plaza'
  get 'hotel/chancellor_executive' => 'staticpage#chancellor_executive'
  get 'hotel/swiss_belhotel' => 'staticpage#swiss_belhotel'
  get 'hotel/quest_spring_hill' => 'staticpage#quest_spring_hill'
  get 'hotel/baronnet_apartment' => 'staticpage#baronnet_apartment'
  get 'hotel/bay_apartments' => 'staticpage#bay_apartments'
end
