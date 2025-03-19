class BlogPost < ApplicationRecord
  belongs_to :user

  validates :title, :slug, :content, :category, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug, on: :create
  before_save :calculate_reading_time

  # Ensure `tags` is always an array when reading from the database
  def tags
    super.is_a?(String) ? JSON.parse(super) : super
  end

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
