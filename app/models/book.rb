class Book < ActiveRecord::Base
  include ActiveModel::Validations

  # Require a title, author and start date
  validates :title, :author, :start, presence: true

  # Restrict length of titles and authors
  validates :title, :author, length: { maximum: 50 }

  # End date must be after or equal to start date, or blank
  validates :end, date: { after_or_equal_to: :start, allow_nil: true }

  # Rating must be an integer between 1 and 5, or blank
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
end
