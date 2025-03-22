class User < ApplicationRecord
  has_many :blog_posts, dependent: :destroy

  # ActiveStorage attachment for CV upload
  has_one_attached :cv

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true

  # Custom validation for CV file
  validate :cv_format_and_size

  private

  def cv_format_and_size
    return unless cv.attached?

    if cv.byte_size > 5.megabytes
      errors.add(:cv, "The file is too big. Max size is 5MB.")
    end

    acceptable_types = [ "application/pdf", "text/plain" ]
    unless acceptable_types.include?(cv.content_type)
      errors.add(:cv, "Your CV must be a PDF or TXT file.")
    end
  end
end
