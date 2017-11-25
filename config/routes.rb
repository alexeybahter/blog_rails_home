Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    # все маршруты
    root "posts#index"
    resources :posts
    resources :pictures, only: [ :create, :destroy ]
  end
end
