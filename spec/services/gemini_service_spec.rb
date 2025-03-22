require "rails_helper"

RSpec.describe GeminiService, type: :service do
  let(:api_key) { "test_api_key" }
  let(:gemini_instance) { double("Gemini instance") }
  let(:service) { GeminiService.new(api_key) }
  let(:prompt_text) { "say hello" }
  let(:response) do
    {
      "candidates" => [
        {
          "content" => {
            "parts" => [
              { "text" => "0.85" } # Note: your implementation converts this to float
            ]
          }
        }
      ]
    }
  end

  before do
    # Mock the Gemini class and initialization
    allow(Gemini).to receive(:new).and_return(gemini_instance)
  end

  describe "#generate_content" do
    context "when the API call is successful" do
      it "returns the generated content as a float" do
        # Mock the correct content format that your service is sending
        expected_request = { contents: { role: "user", parts: { text: prompt_text } } }

        # Mock the generate_content method on your gemini instance
        allow(gemini_instance).to receive(:generate_content)
          .with(expected_request)
          .and_return(response)

        result = service.generate_content(prompt_text)

        # Verify it returns the text value converted to float
        expect(result).to eq(0.85)
      end
    end

    context "when the API call fails" do
      it "logs an error and returns nil" do
        expected_request = { contents: { role: "user", parts: { text: prompt_text } } }

        # Simulate an exception
        allow(gemini_instance).to receive(:generate_content)
          .with(expected_request)
          .and_raise(StandardError.new("API error"))

        expect(Rails.logger).to receive(:error).with("Gemini API error: API error")
        result = service.generate_content(prompt_text)

        expect(result).to be_nil
      end
    end
  end
end
