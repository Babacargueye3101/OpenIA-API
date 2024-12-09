module Api
  module V1
    class AssistantAiController < ApplicationController
      protect_from_forgery except: [:ask]

      def ask
        role_assistant = params[:role_assistant] || I18n.t('responses.default_assistant')
        prompt = params[:prompt]

        if prompt.blank?
          render json: { error: I18n.t('errors.prompt_blank') }, status: :unprocessable_entity
          return
        end

        begin
          response = OpenAiService.call(role_assistant, prompt)
          render json: { response: response }, status: :ok
        rescue => e
          render json: { error: I18n.t('errors.service_error', message: e.message) }, status: :internal_server_error
        end
      end
    end
  end
end
