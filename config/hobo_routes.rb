# This is an auto-generated file: don't edit!
# You can add your own routes in the config/routes.rb file
# which will override the routes in this file.

Mercator::Application.routes.draw do

  namespace :contracting do


    # Resource routes for controller contracting/contractitems
    resources :contractitems


    # Resource routes for controller contracting/consumableitems
    resources :consumableitems


    # Resource routes for controller contracting/contracts
    resources :contracts

  end

end
