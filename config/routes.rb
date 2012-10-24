TryRougeIo::Application.routes.draw do
  root :to => "shell#index"
  post "shell/execute"
end
