Rails.application.routes.draw do
  root "welcome#index"

  resources(
    :foods,
    only: %i[index],
    controller: "search",
    path: "foods"
  )
end
