class Book < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :user

  # Require a title, author and start date
  validates :title, :author, :start_date, presence: true

  # Restrict length of titles and authors
  validates :title, :author, length: { maximum: 100 }

  # Number of pages must be an integer above 0, or nil
  validates :number_of_pages, numericality: { only_integer: true, greater_than_or_equal_to: 1, allow_nil: true }

  # End date must be after or equal to start date, or nil
  validates :end_date, date: { after_or_equal_to: :start_date, allow_nil: true }

  # Rating must be an integer between 1 and 5, or nil
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
end
