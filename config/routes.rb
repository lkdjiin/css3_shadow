Css3Shadow::Application.routes.draw do

  match "/app", to: "pages#app"
  match "/about", to: "pages#about"
  match "/todo", to: "pages#todo"
  match "/comments", to: "pages#comments"

  root to: 'pages#home'
  
end
