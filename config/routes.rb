Rails.application.routes.draw do
  get "/articles", to: "article#index"
  get "/article/:id", to: "article#show"
end
