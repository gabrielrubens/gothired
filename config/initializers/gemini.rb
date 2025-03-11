require "gemini-ai"



api_key = Rails.application.credentials.dig(:gemini, :api_key)
# Rails.application.credentials.gemini.api_key

if api_key.present?
  GeminiClient = Gemini.new(
    credentials: {
      service: "generative-language-api",
      api_key: api_key
    },
    options: { model: "gemini-1.5-flash", server_sent_events: true }
  )
else
  Rails.logger.warn("Gemini API key not found in credentials")
  # Optional: Create a dummy client or set to nil
  GeminiClient = nil
end

# Optionally, you can define a method to easily access the client
# module GeminiHelper
#   def gemini_client
#     GeminiClient
#   end
# end
