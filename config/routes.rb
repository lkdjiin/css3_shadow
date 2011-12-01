Css3Shadow::Application.routes.draw do

  get "pages/help"

  get "pages/comments"

  root :to => 'pages#home'
  
end
