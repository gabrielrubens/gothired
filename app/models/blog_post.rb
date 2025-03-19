class BlogPost < ApplicationRecord
  belongs_to :user

  validates :title, :slug, :content, :category, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug, on: :create
  before_save :calculate_reading_time

  private

  def generate_slug
    self.slug ||= title.parameterize
  end

  def calculate_reading_time
    words_per_minute = 200
    total_words = content.split.size
    self.reading_time = (total_words / words_per_minute.to_f).ceil
  end
end
