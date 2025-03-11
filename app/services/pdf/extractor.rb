require "pdf-reader"

class Pdf::Extractor
  def self.call(file_path)
    new(file_path).call
  end

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    extract_text
  end

  private

  def extract_text
    reader = PDF::Reader.new(@file_path)

    reader.pages.map(&:text)
  rescue => e
    Rails.logger.error("PDF extraction error: #{e.message}")
    nil
  end
end
