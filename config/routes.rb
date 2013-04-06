#coding: UTF-8
Bratiki::Application.routes.draw do

  get "chief/home"

  root :to => 'user/login#login'
  match 'admin' => 'admin#home'
  match 'teacher/home' => 'teacher#home'
  match 'teacher/calendar/:day/:month/:year' => 'teacher#calendar'
  match 'teacher/calendar/:month/:year' => 'teacher#calendar'
  match 'teacher/calendar' => 'teacher#calendar'
  match 'teacher/my_subjects' => 'teacher#my_subjects'
  match 'teacher/journal/group/:group_id/subject/:subject_id' => 'teacher#journal'
  match 'teacher/update_subject_select/:id' => 'teacher#update_subject_select'

  match 'student/home' => 'student#home'
  match 'student/calendar' => 'student#calendar'
  match 'student/my_subjects' => 'student#my_subjects'
  match 'student/journal/group/:group_id/subject/:subject_id' => 'student#journal'

  match 'chief/home' => 'chief#home'
  match 'chief/calendar' => 'chief#calendar'

  namespace :admin do
    match 'register/step1' => 'register#step1'
    match 'register/step2' => 'register#step2'
  end

  namespace :student do
    match 'register/step1' => 'register#step1'
    match 'register/step2' => 'register#step2'
    match 'register/step3' => 'register#step3'
    match 'register/step4' => 'register#step4'
    match 'register/validate_uniqueness_email' => 'register#validate_uniqueness_email'
    match 'register/update_group_select/:faculty_id/:course_number' => 'register#update_group_select'
  end

  namespace :chief do
    match 'register/step1' => 'register#step1'
    match 'register/step2' => 'register#step2'
    match 'register/step3' => 'register#step3'
    match 'register/step4' => 'register#step4'
    match 'register/validate_uniqueness_email' => 'register#validate_uniqueness_email'
  end

  namespace :teacher do
    match 'report/index' => 'report#index'
    match 'report/generate_pdf' => 'report#generate_pdf'

    match ':day/:month/:year/pair/index' => 'pair#index'
    match ':day/:month/:year/pair/:pair_id/edit' => 'pair#edit'
    match ':day/:month/:year/pair/:pair_id/destroy' => 'pair#destroy'
    match ':day/:month/:year/pair/new' => 'pair#new'

    match 'register/step1' => 'register#step1'
    match 'register/step2' => 'register#step2'
    match 'register/step3' => 'register#step3'
    match 'register/step4' => 'register#step4'
    match 'register/update_chair_select/:id' => 'register#update_chair_select'
    match 'register/validate_uniqueness_email' => 'register#validate_uniqueness_email'







    match 'chair/index' => 'chair#index'
    match 'chair/:chair_id' => 'chair#show'


    match 'group/index' => 'group#index'
    match 'group/:group_id' => 'group#show'

    match 'faculty/index' => 'faculty#index'
    match 'faculty/:faculty_id' => 'faculty#show'

    match 'institute/index' => 'institute#index'
    match 'institute/:institute_id' => 'institute#show'





    namespace :faculty do
      match ':faculty_id/chair/index' => 'chair#index'
      match ':faculty_id/chair/:chair_id' => 'chair#show'

      match ':faculty_id/group/index'=> 'group#index'
      match ':faculty_id/group/:group_id' => 'group#show'

      match ':faculty_id/chair/:chair_id/group/index' => 'chair/group#index'
      match ':faculty_id/chair/:chair_id/group/:group_id' => 'chair/group#show'
    end

    namespace :chair do
      match ':chair_id/group/index' => 'group#index'
      match ':chair_id/group/:group_id' => 'group#show'
    end

    namespace :institute do
      match ':institute_id/faculty/index' => 'faculty#index'
      match ':institute_id/faculty/:faculty_id' => 'faculty#show'


      match ':institute_id/chair/index' => 'chair#index'
      match ':institute_id/chair/:chair_id' => 'chair#show'


      match ':institute_id/group/index' => 'group#index'
      match ':institute_id/group/:group_id' => 'group#show'


      match ':institute_id/faculty/:faculty_id/chair/index' => 'faculty/chair#index'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id' => 'faculty/chair#show'


      match ':institute_id/faculty/:faculty_id/group/index' => 'faculty/group#index'
      match ':institute_id/faculty/:faculty_id/group/:group_id' => 'faculty/group#show'


      match ':institute_id/chair/:chair_id/group/index' => 'chair/group#index'
      match ':institute_id/chair/:chair_id/group/:group_id' => 'chair/group#show'


      match ':institute_id/faculty/:faculty_id/chair/:chair_id/group/index' => 'faculty/chair/group#index'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id/group/:group_id' => 'faculty/chair/group#show'
    end




  match 'task' => 'task#index'

  match 'task/index' => 'task#index'

  match 'task/show/:task_id' => 'task#show'

  match 'task/add(.:format)' => 'task#add'

  match 'task/copy(.:format)' => 'task#copy'

  match 'task/edit(.:format)' => 'task#edit'

  match 'task/management/:task_id(/:phrase)' => 'task#management'

  match 'task/destroy(.:format)' => 'task#destroy'


  match 'pattern/add(.:format)' => 'pattern#add'

  match 'pattern/copy(.:format)' => 'pattern#copy'

  match 'pattern/show(.:format)' => 'pattern#show'

  match 'pattern/destroy(.:format)' => 'pattern#destroy'


  match 'parameter/show(.:format)' => 'parameter#show'

  match 'parameter/add(.:format)' => 'parameter#add'

  match 'parameter/constructor(.:format)' => 'parameter#constructor'

  match 'parameter/listbox(.:format)' => 'parameter#listbox'

  match 'parameter/edit(.:format)' => 'parameter#edit'

  match 'parameter/destroy(.:format)' => 'parameter#destroy'










  end

  scope :module => 'user' do
    match 'register' => 'register#step0'
    match 'register/step2' => 'register#step2'
    match 'register/step3' => 'register#step3'
    match 'register/step4' => 'register#step4'
    match 'register/update_chair_select/:id' => 'register#update_chair_select'
    match 'register/validate_uniqueness_email' => 'register#validate_uniqueness_email'

    match 'login/login' => 'login#login'
    match 'login/logout' => 'login#logout'
    match 'login/check_of_existence_email' => 'login#check_of_existence_email'
    match 'login/authorize' => 'login#authorize'
    match 'login/activated' => 'login#activated'
    match 'login/banned' => 'login#banned'
  end

  namespace :user do




    match 'day/:day/:month/:year' => 'day#index'

    namespace :day do
      match ':day/:month/:year/pair/index' => 'pair#index'
      match ':day/:month/:year/pair/new' => 'pair#new'
      match ':day/:month/:year/pair/:pair_id/edit' => 'pair#edit'
      match ':day/:month/:year/pair/:pair_id' => 'pair#show'
      match ':day/:month/:year/pair/:pair_id/destroy' => 'pair#destroy'

      match ':day/:month/:year/task/index' => 'task#index'
      match ':day/:month/:year/task/new' => 'task#new'
      match ':day/:month/:year/task/:task_id/edit' => 'task#edit'
      match ':day/:month/:year/task/:task_id/destroy' => 'task#destroy'
    end

  end

  namespace :admin do
    match 'user/index' => 'user#index'
    match 'user/new' => 'user#new'
    match 'user/:id' => 'user#show'
    match 'user/:id/destroy' => 'user#destroy'
    match 'user/:id/edit' => 'user#edit'
    match 'user/:id/activate' => 'user#activate'

    match 'chair/index' => 'chair#index'
    match 'chair/new' => 'chair#new'
    match 'chair/:chair_id' => 'chair#show'
    match 'chair/:chair_id/destroy' => 'chair#destroy'
    match 'chair/:chair_id/edit' => 'chair#edit'

    match 'group/index' => 'group#index'
    match 'group/new' => 'group#new'
    match 'group/:group_id' => 'group#show'
    match 'group/:group_id/destroy' => 'group#destroy'
    match 'group/:group_id/edit' => 'group#edit'

    match 'faculty/index' => 'faculty#index'
    match 'faculty/new' => 'faculty#new'
    match 'faculty/:faculty_id' => 'faculty#show'
    match 'faculty/:faculty_id/destroy' => 'faculty#destroy'
    match 'faculty/:faculty_id/edit' => 'faculty#edit'

    match 'institute/index' => 'institute#index'
    match 'institute/new' => 'institute#new'
    match 'institute/:institute_id' => 'institute#show'
    match 'institute/:institute_id/destroy' => 'institute#destroy'
    match 'institute/:institute_id/edit' => 'institute#edit'

    match 'project/restart' => 'project#restart'
    match 'project/log' => 'project#log'
    match 'project/new_study_year' => 'project#new_study_year'
    match 'project' => 'project#index'

    match 'dictionary/index' => 'dictionary#index'

    match 'schedule/index' => 'schedule#index'
    match 'schedule/load' => 'schedule#load'
    match 'schedule/destroy' => 'schedule#destroy'

    namespace :dictionary do
      match 'military_rank/index' => 'military_rank#index'
      match 'military_rank/new' => 'military_rank#new'
      match 'military_rank/destroy' => 'military_rank#destroy'
      match 'military_rank/edit/:id' => 'military_rank#edit'

      match 'scientific_rank/index' => 'scientific_rank#index'
      match 'scientific_rank/new' => 'scientific_rank#new'
      match 'scientific_rank/destroy' => 'scientific_rank#destroy'
      match 'scientific_rank/edit/:id' => 'scientific_rank#edit'

      match 'scientific_degree/index' => 'scientific_degree#index'
      match 'scientific_degree/new' => 'scientific_degree#new'
      match 'scientific_degree/destroy' => 'scientific_degree#destroy'
      match 'scientific_degree/edit/:id' => 'scientific_degree#edit'

      match 'post/index' => 'post#index'
      match 'post/new' => 'post#new'
      match 'post/destroy' => 'post#destroy'
      match 'post/edit/:id' => 'post#edit'
    end

    namespace :faculty do
      match ':faculty_id/chair/index' => 'chair#index'
      match ':faculty_id/chair/new' => 'chair#new'
      match ':faculty_id/chair/:chair_id' => 'chair#show'
      match ':faculty_id/chair/:chair_id/destroy' => 'chair#destroy'
      match ':faculty_id/chair/:chair_id/edit' => 'chair#edit'

      match ':faculty_id/group/index'=> 'group#index'
      match ':faculty_id/group/new' => 'group#new'
      match ':faculty_id/group/:group_id' => 'group#show'
      match ':faculty_id/group/:group_id/destroy' => 'group#destroy'
      match ':faculty_id/group/:group_id/edit' => 'group#edit'

      match ':faculty_id/chair/:chair_id/group/index' => 'chair/group#index'
      match ':faculty_id/chair/:chair_id/group/new' => 'chair/group#new'
      match ':faculty_id/chair/:chair_id/group/:group_id' => 'chair/group#show'
      match ':faculty_id/chair/:chair_id/group/:group_id/destroy' => 'chair/group#destroy'
      match ':faculty_id/chair/:chair_id/group/:group_id/edit' => 'chair/group#edit'
    end

    namespace :chair do
      match ':chair_id/group/index' => 'group#index'
      match ':chair_id/group/new' => 'group#new'
      match ':chair_id/group/:group_id' => 'group#show'
      match ':chair_id/group/:group_id/destroy' => 'group#destroy'
      match ':chair_id/group/:group_id/edit' => 'group#edit'
    end

    namespace :institute do
      match ':institute_id/faculty/index' => 'faculty#index'
      match ':institute_id/faculty/new' => 'faculty#new'
      match ':institute_id/faculty/:faculty_id' => 'faculty#show'
      match ':institute_id/faculty/:faculty_id/destroy' => 'faculty#destroy'
      match ':institute_id/faculty/:faculty_id/edit' => 'faculty#edit'


      match ':institute_id/chair/index' => 'chair#index'
      match ':institute_id/chair/new' => 'chair#new'
      match ':institute_id/chair/:chair_id' => 'chair#show'
      match ':institute_id/chair/:chair_id/destroy' => 'chair#destroy'
      match ':institute_id/chair/:chair_id/edit' => 'chair#edit'


      match ':institute_id/group/index' => 'group#index'
      match ':institute_id/group/new' => 'group#new'
      match ':institute_id/group/:group_id' => 'group#show'
      match ':institute_id/group/:group_id/destroy' => 'group#destroy'
      match ':institute_id/group/:group_id/edit' => 'group#edit'


      match ':institute_id/faculty/:faculty_id/chair/index' => 'faculty/chair#index'
      match ':institute_id/faculty/:faculty_id/chair/new' => 'faculty/chair#new'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id' => 'faculty/chair#show'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id/destroy' => 'faculty/chair#destroy'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id/edit' => 'faculty/chair#edit'


      match ':institute_id/faculty/:faculty_id/group/index' => 'faculty/group#index'
      match ':institute_id/faculty/:faculty_id/group/new' => 'faculty/group#new'
      match ':institute_id/faculty/:faculty_id/group/:group_id' => 'faculty/group#show'
      match ':institute_id/faculty/:faculty_id/group/:group_id/destroy' => 'faculty/group#destroy'
      match ':institute_id/faculty/:faculty_id/group/:group_id/edit' => 'faculty/group#edit'


      match ':institute_id/chair/:chair_id/group/index' => 'chair/group#index'
      match ':institute_id/chair/:chair_id/group/new' => 'chair/group#new'
      match ':institute_id/chair/:chair_id/group/:group_id' => 'chair/group#show'
      match ':institute_id/chair/:chair_id/group/:group_id/destroy' => 'chair/group#destroy'
      match ':institute_id/chair/:chair_id/group/:group_id/edit' => 'chair/group#edit'


      match ':institute_id/faculty/:faculty_id/chair/:chair_id/group/index' => 'faculty/chair/group#index'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id/group/new' => 'faculty/chair/group#new'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id/group/:group_id' => 'faculty/chair/group#show'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id/group/:group_id/destroy' => 'faculty/chair/group#destroy'
      match ':institute_id/faculty/:faculty_id/chair/:chair_id/group/:group_id/edit' => 'faculty/chair/group#edit'
    end


  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
