require "gemini-ai"

class GeminiService
  def initialize
    @gemini = Gemini.new(
      credentials: {
        service: "generative-language-api",

        api_key: Rails.application.credentials.gemini.api_key
      },
      options: { model: "gemini-1.5-flash", server_sent_events: true }
    )
  end

  def generate_content(prompt)
    begin

      response = @gemini.generate_content(
                  { contents: { role: "user", parts: { text: prompt } } }
                )

      # puts response["candidates"][0]["content"]["parts"][0]["text"]

      response["candidates"][0]["content"]["parts"][0]["text"].to_f
    rescue StandardError => e
      Rails.logger.error("Gemini API error: #{e}")
      nil
    end
  end
end
