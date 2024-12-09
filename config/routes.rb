Rails.application.routes.draw do

  # Api route for IA Assistant
  namespace :api do
    namespace :v1 do
      post 'assistant_ai/ask', to: 'assistant_ai#ask'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
