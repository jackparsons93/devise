Rails.application.routes.draw do
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    devise_for :<%= scope.pluralize.to_sym -%>, controllers: {
      registrations: 'users/registrations'
    }
    # Defines the root path route ("/")
    # root "articles#index"
  end
  