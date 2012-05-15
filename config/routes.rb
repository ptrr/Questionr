Formr::Application.routes.draw do

  scope "api" do
    resources :forms do
      resources :questions do
        resources :options
      end
    end
  end
  resources :forms do
    resources :responses
  end
  root to: "forms#index"
end
