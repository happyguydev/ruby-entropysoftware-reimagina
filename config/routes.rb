Rails.application.routes.draw do

  resources :advices
  resources :service_types
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :proc_type_fathers
  get "upload_gallery", to: "s3#index", as: :upload_gallery
  resources :froala_images, only: :create

  resources :group_questions do
    member do
      get :add_existing
      get :add_new

      get :remove_question
      get :add_question
    end
  end
  resources :assignature_abilities
  resources :axis_programs
  resources :fact_statuses
  resources :fact_status_types
  resources :buy_orders
  resources :feed_forms
  resources :feed_items
  resources :feed_scores
  resources :feedbacks
  resources :color_ranges
  resources :remedials do
    post 'get_content', on: :collection, to: 'remedials#get_content'
  end
  resources :difficulty_levels
  resources :invoices
  resources :order_statuses
  resources :status_types
  resources :proc_types
  resources :proccesses
  resources :payments
  resources :contents
  resources :levels
  resources :instruments do
    get "mass_remedials", on: :member, to: "instruments#mass_remedials"
    collection do
      post :sort_questions
      post :sort_alternatives
    end

    member do
      post :generate_guide
    end
    get :guide, on: :member
    get "instruments_by_order/:order_id", on: :collection, to: "instruments#instrument_by_order", as: "instruments_by_order"
    #resources :answers
    #get :results, on: :member, to: "results#index"
    #get "results/grade", on: :member, to: "results#grade"
    #get "results/report", on: :member, to: "results#report"
  end

  get 'results/mass_input', to: 'results#mass_input'
  post 'results/mass_input_post_data', to: 'results#mass_input_post_data', as: 'mass_input_post_data'
  post 'results/mass_input_pdf', to: 'results#mass_input_pdf', as: 'mass_input_pdf'
  get 'results/download_report/:rid', to: 'results#download_report', as: 'download_report'

  resources :alternatives
  resources :evaluations
  resources :evaluation_types
  get 'edit_statement', to: 'group_questions#edit_statement'

  get 'questions/mass_input', to: 'questions#mass_input'
  post 'questions/mass_input_post_data', to: 'questions#mass_input_post_data', as: 'questions_mass_input_post_data'

  post 'questions/mass_input_create', to: 'questions#mass_input_create', as: 'questions_mass_input_create'
  get 'questions/mass_input_create', to: 'questions#mass_input_create'
  resources :questions do
    collection do
      get :mass_evelution_edit
    end
    get  'add_questions_to_evaluation', on: :collection, to: 'questions#add_questions_to_evaluation'
    post 'get_assignature_dependants', on: :collection, to: 'questions#get_assignature_dependants'
    post 'get_level_dependants', on: :collection, to: 'questions#get_level_dependants'
    post 'get_unit_dependants', on: :collection, to: 'questions#get_unit_dependants'
  end

  get 'learning_goals/macrotabla', to: 'learning_goals#macrotabla'
  post 'learning_goals/macrotabla_submit', to: 'learning_goals#macrotabla_submit', as: 'macrotabla_submit'

  resources :units do
    post 'get_assignature_dependants', on: :collection, to: 'units#get_assignature_dependants'
    post 'get_learning_goals', on: :collection, to: 'units#get_learning_goals'
  end
  resources :bloom_abilities

  resources :learning_goals do
    post 'get_units', on: :collection, to: 'learning_goals#get_units'
  end



  #  resources :ability_contents
  #  resources :pme_abilities
  # resources :axes_contents
  # resources :axes
  get 'admin/index'
  get 'admin/schools'
  get 'admin/roles'

  #resources :grades

  resources :schools
  devise_for :users
  root 'welcome#index'


  resources :proccess_instruments do
    get 'admin' , on: :collection, to: 'proccess_instruments#admin'
    get "destroy_answers", on: :member, to: "proccess_instruments#destroy_answers"
    resources :answers
    get :results, on: :member, to: "results#index"
    get "results/grade", on: :member, to: "results#grade"
    get "results/report", on: :member, to: "results#report"
    get "results/report_pdf", on: :member, to: "results#report_pdf"
    post "results/generate_report_pdf", on: :member, to: "results#generate_report_pdf"
    get "results/download_pdf", on: :member, to: "results#download_pdf"
    get "results/show_report", on: :member, to: "results#show_report"
  end


  resources :orders do
    get 'cobranza' , on: :collection, to: 'orders#cobranza'
    get 'facturas' , on: :collection, to: 'orders#facturas'
    get 'historico' , on: :collection, to: 'orders#historico'
    resources :buy_orders
    resources :invoices
    resources :order_statuses
    resources :proccesses do
      post 'generate_cuotas', on: :collection, to: 'proccesses#generate_cuotas'
      get "add_instrument/:instrument_id", on: :member, to: "proccesses#add_instrument"
      get "remove_instrument/:instrument_id", on: :member, to: "proccesses#remove_instrument"
      resources :proccess_instruments
    end
    resources :payments do
      get 'toggle_approve', :on => :member
    end
    resources :invoices do
      get 'toggle_approve', :on => :member
    end
  end

  get 'orders/mass_input', to: 'orders#mass_input'
  post 'orders/mass_input', to: 'orders#mass_input'

  resources :schools do
    resources :grades
  end

  # School clients
  get '/school_client', to: 'school_clients#index', as: 'school_client'

  match '/profile/edit', to: 'school_clients#edit_profile', as: 'edit_profile', via: [:get, :post]

  get '/my_school', to: 'school_clients#assigned_school', as: 'my_school'

  get '/enter_to_school', to: 'school_clients#enter_to_school', as: 'enter_to_school'

  get '/school_clients/billing', to: 'school_clients#billing', as: 'school_client_billing'

  get '/school_clients/invoice', to: 'school_clients#invoice', as: 'school_client_invoice'

  get '/school_clients/feedback', to: 'school_clients#feedback', as: 'school_client_feedback'

  match '/school_clients/contact', to: 'school_clients#contact_us', as: 'school_client_contact_us', via: [:get, :post]

  match '/school_clients/update_feedback', to: 'school_clients#update_feedback', as: 'update_client_feedback', via: [:get, :post]

  match '/school_clients/evaluation', to: 'school_clients#evaluation', as: 'school_client_evaluation', via: [:get, :post]

  get '/billing/view_order', to: 'school_clients#view_order', as: 'view_billing_order'

  match '/school_clients/results_n_reports', to: 'school_clients#results_n_reports', as: 'school_client_results_n_reports', via: [:get, :post]

  get '/comparatives/index', to: 'comparatives#index', as: 'comparatives'
  get '/comparatives/filter_date', to: 'comparatives#filter_date'
  get '/comparatives/filter_school', to: 'comparatives#filter_school'
  get '/comparatives/filter_user', to: 'comparatives#filter_user'
  get '/comparatives/filter_proccess', to: 'comparatives#filter_proccess'

  post '/comparatives/compare_report', to: 'comparatives#compare_report', as: 'compare_report'

  get 'students/mass_input', to: 'students#mass_input'
  post 'students/mass_input', to: 'students#mass_input', as: 'mass_input'

  get 'answers/mass_input', to: 'answers#mass_input'
  post 'answers/mass_input', to: 'answers#mass_input'

  get 'advices/mass_remedials', to: 'advices#mass_remedials'
  post 'advices/mass_remedials', to: 'advices#mass_remedials', as: 'mass_remedials'

  resources :grades do
    resources :students
  end

  scope "/admin" do
    resources :assigned_schools do
      collection do
        match 'assign', via: [:get, :post]
        get 'assigned'
      end
    end
    resources :users do
      collection do
        match 'client_user', via: [:get, :post]
        match 'update_client_user', via: [:get, :post]
      end
      resources :roles
    end
  end

  resources :axes do
    resources :axes_contents
  end

  resources :pme_abilities do
    resources :ability_contents
  end

  resources :images

  get 'communes_by_region/:id', to: 'application#communes_by_region'

  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ }, via: :all
end
