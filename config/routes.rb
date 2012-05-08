Formr::Application.routes.draw do

  scope "api" do
    resources :questions do 
      resources :options
    end

  end
  root to: "main#index"
end
