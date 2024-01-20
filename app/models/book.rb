class Book < ApplicationRecord
  has_one_attached :image

  validates :title, :author_name, :isbn, :genre, :number_of_books, :published_year, presence: true
  validates :isbn, uniqueness: true
  validates :number_of_books, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :published_year_cannot_be_in_the_future
  validate :image_presence_and_content_type

  private

  def published_year_cannot_be_in_the_future
    return if published_year.blank? || published_year.to_date <= Date.current

    errors.add(:published_year, "can't be in the future")
  end

  def image_presence_and_content_type
    if image.attached?
      unless image.content_type.in?(%w(image/jpeg image/png))
        errors.add(:image, 'must be a JPEG or PNG')
      end
    else
      errors.add(:image, 'must be attached')
    end
  end
end
