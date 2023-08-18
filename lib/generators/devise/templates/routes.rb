Rails.application.routes.draw do
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    devise_for :<%= name.pluralize.to_sym -%>, controllers: {
      registrations: '<%=name.pluralize%>/registrations'
    }
    # Defines the root path route ("/")
    # root "articles#index"
  end
  