WebArticles::Application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  get "posts/chart" => "posts#chart", :as => "chart"
  get "posts/visits_by_day" => "posts#visits_by_day", :as => "visits_by_day"
  get "posts/word" => "posts#word", format: 'docx'
  resources :posts
  resources :users
  get "admin/articles/test_api" => "admin/articles#test_api", :as => "test_api"    
  get "admin/articles/pdf" => "admin/articles#pdf", :as => "pdf"
  get "admin/articles/export/:id" => "admin/articles#export", :as => "export"
  post "admin/articles/import" => "admin/articles#import", :as => "import"
  get "admin/articles/export_csv/:id" => "admin/articles#export_csv", :as => "export_csv"
  post "admin/articles/import_csv" => "admin/articles#import_csv", :as => "import_csv"
  post "admin/articles/delete_selected" => "admin/articles#delete_selected", :as => "delete_selected"
  
  #scope '/admin' do
  #     resources :articles , :sessions , :comments
  #end  
  namespace :admin do
    resources :articles , :sessions , :comments    
  end
  root "posts#index"
  get "admin/sign_up" => "users#new", :as => "sign_up"
  get "admin/sign_in" => "admin/sessions#new", :as => "sign_in"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
