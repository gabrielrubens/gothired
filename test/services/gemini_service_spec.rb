require "rails_helper"

RSpec.describe GeminiService, type: :service do
  let(:gemini_client) { instance_double(Gemini) }
  let(:service) { GeminiService.new }
  let(:prompt_text) { "say hello" }
  let(:response) do
    {
      "candidates" => [
        {
          "content" => {
            "parts" => [
              { "text" => "Hello, world!" }
            ]
          }
        }
      ]
    }
  end

  before do
    allow(Gemini).to receive(:new).and_return(gemini_client)
  end

  describe "#generate_content" do
    context "when the API call is successful" do
      it "returns the generated content" do
        allow(gemini_client).to receive(:generate_content).and_return(response)

        result = service.generate_content(prompt_text)

        expect(result).to eq(response)
        expect { service.generate_content(prompt_text) }.to output("Hello, world!\n").to_stdout
      end
    end

    context "when the API call fails" do
      it "logs an error and returns nil" do
        allow(gemini_client).to receive(:generate_content).and_raise(StandardError.new("API error"))

        expect(Rails.logger).to receive(:error).with("Gemini API error: API error")
        result = service.generate_content(prompt_text)

        expect(result).to be_nil
      end
    end
  end
end
