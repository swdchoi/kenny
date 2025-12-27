Rails.application.routes.draw do
resources :clients do
  resources :contracts, shallow: true do
    resources :payment_terms, shallow: true
    resources :milestones, shallow: true
  end
end

resources :payment_terms do
  resources :invoices, shallow: true do
  resources :notes, shallow: true
  end
end

  devise_for :users

    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    authenticated :user do
    root "dashboard#index", as: :authenticated_root
  end

    unauthenticated do
      root "home#index", as: :unauthenticated_root
    end

    root "home#index"
    # Reveal healt h status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check
    get "invoicesdash", to: "dashboard#invoice", as: "invoicedash"
    get "contractsdash", to: "dashboard#contracts", as: "contractdash"
    get "clientdash", to: "dashboard#clients", as: "clientdash"
    get "paymentdash", to: "dashboard#paymentterms", as: "paymentdash"
    get "milestonesdash", to: "dashboard#milestones", as: "milestonedash"
    get "invoiceanalysis", to: "invoices#analysis", as: "invoiceanalysis"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
