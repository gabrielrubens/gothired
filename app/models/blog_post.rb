class BlogPost < ApplicationRecord
  belongs_to :user

  validates :title, :slug, :content, :category, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug, on: :create
  before_save :ensure_tags_array

  # Scope for published blog posts
  scope :published, -> { where("published_at IS NOT NULL AND published_at <= ?", Time.current) }

  # Check if post is published
  def published?
    published_at.present? && published_at <= Time.current
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

  def ensure_tags_array
    self.tags = tags.is_a?(Array) ? tags : tags.to_s.split(",").map(&:strip)
    # self.tags = tags.is_a?(Array) ? tags : tags.to_s.split(",").map(&:strip).reject(&:blank?)
  end
end
