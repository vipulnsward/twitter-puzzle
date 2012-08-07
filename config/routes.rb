TwitterPuzzle::Application.routes.draw do
  get "twitter/landing"

  get "twitter/index"
  post "twitter/index"

  root :to => 'twitter#landing'

end
