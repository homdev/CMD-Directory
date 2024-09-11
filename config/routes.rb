Rails.application.routes.draw do
  # Routes Devise pour la gestion des utilisateurs
  devise_for :users

  # Routes pour les actions utilisateurs (hors namespace admin)
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :projects do
    resources :evaluations, only: [:new, :create, :edit, :update, :destroy] # Évaluations liées à un projet
    post 'add_member', on: :member
    
    # Routes pour la gestion des membres du projet
    resources :project_members, only: [:new, :create, :edit, :update, :destroy], controller: 'project_members'
  end
  

  resources :evaluations, only: [:index, :show, :edit, :update, :destroy]
  # Namespace pour les routes admin
  namespace :admin do
    resources :users do
      collection do
        get 'dashboard'  # Ajoute une route pour l'action dashboard dans le namespace admin
      end
    end
    root to: "dashboard#index"  # Redirige vers le dashboard admin par défaut
  end

  # Routes spécifiques à votre application
  get "home/index"
  get "economic_projects/index"
  get "directory/index"

  # Route pour la page "Mon compte"
  get 'my_account', to: 'users#my_account', as: 'my_account'

  # Route pour la vérification du statut de l'application
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes pour les fichiers PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Définir la route racine de l'application
  root "home#index"
end
