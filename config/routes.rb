Mercator::Application.routes.draw do
  match ENV['RAILS_RELATIVE_URL_ROOT'] => 'front#index' if ENV['RAILS_RELATIVE_URL_ROOT']

  root :to => 'front#index'
  get 'contracting' => 'contracting/front#index', :as => 'contracting_front'
end