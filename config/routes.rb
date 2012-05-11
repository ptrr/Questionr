Formr::Application.routes.draw do

  scope "api" do
    resources :forms do
      resources :questions do
        resources :options
      end
    end
  end
  resources :forms
  root to: "forms#index"
end
