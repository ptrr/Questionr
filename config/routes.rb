Formr::Application.routes.draw do

  scope "api" do
    resources :questions
  end
  root to: "main#index"
end
