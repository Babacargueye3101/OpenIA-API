module OpenAiService

  OPENAI_API_URL = "https://api.openai.com/v1/chat/completions"

  def self.call(role_assistant, prompt)
    return "Le prompt ne peut pas être vide." if prompt.blank?

    headers = {
      Authorization: "Bearer #{ENV['OPENAI_API_KEY']}",
      Content_Type: "application/json"
    }

    payload = {
      model: "gpt-3.5-turbo",
      messages: [
        { role: "system", content: role_assistant },
        { role: "user", content: prompt }
      ]
    }.to_json

    begin
      response = RestClient.post(OPENAI_API_URL, payload, headers)
      body = JSON.parse(response.body)
      body.dig("choices", 0, "message", "content") || "Aucune réponse trouvée."
    rescue RestClient::ExceptionWithResponse => e
      error_response(e.response)
    rescue StandardError => e
      "Erreur de connexion : #{e.message}"
    end
  end

  def self.error_response(response)
    error_body = JSON.parse(response.body) rescue nil
    if error_body && error_body["error"]
      "Erreur OpenAI : #{error_body['error']['message']}"
    else
      "Erreur inconnue avec OpenAI."
    end
  end
end
