Avo::Engine.routes.draw do
  root "home#index"

  get "resources", to: redirect("/admin")
  post "/rails/active_storage/direct_uploads", to: "/active_storage/direct_uploads#create"

  scope "avo_api", as: "avo_api" do
    get "/search", to: "search#index"
    get "/:resource_name/search", to: "search#show"
    post "/resources/:resource_name/:id/attachments/", to: "attachments#create"
  end

  get "failed_to_load", to: "home#failed_to_load"

  scope "resources", as: "resources" do
    # Attachments
    get "/:resource_name/:id/active_storage_attachments/:attachment_name/:signed_attachment_id", to: "attachments#show"
    delete "/:resource_name/:id/active_storage_attachments/:attachment_name/:signed_attachment_id", to: "attachments#destroy"

    # Actions
    get "/:resource_name(/:id)/actions/:action_id", to: "actions#show"
    post "/:resource_name(/:id)/actions/:action_id", to: "actions#handle"

    # Generate resource routes as below:
    # resources :posts
    instance_eval(&Avo::App.draw_routes)

    # Associations
    get "/:resource_name/:id/:related_name/new", to: "associations#new"
    get "/:resource_name/:id/search/:related_name/", to: "associations#search"
    get "/:resource_name/:id/:related_name/", to: "associations#index"
    get "/:resource_name/:id/:related_name/:related_id", to: "associations#show"
    post "/:resource_name/:id/:related_name", to: "associations#create"
    delete "/:resource_name/:id/:related_name/:related_id", to: "associations#de stroy"
  end
end
