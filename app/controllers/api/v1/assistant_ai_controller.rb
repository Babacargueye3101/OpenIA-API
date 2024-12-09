module Api
  module V1
    class AssistantAiController < ApplicationController
      protect_from_forgery except: [:ask]

      def ask
        role_assistant = params[:role_assistant] || "Vous êtes un assistant virtuel pour MyBOA."
        prompt = params[:prompt]

        if prompt.blank?
          render json: { error: "Le prompt ne peut pas être vide." }, status: :unprocessable_entity
          return
        end

        begin
          response = OpenAiService.call(role_assistant, prompt)
          render json: { response: response }, status: :ok
        rescue => e
          render json: { error: "Erreur lors de l'appel au service : #{e.message}" }, status: :internal_server_error
        end
      end
    end
  end
end
