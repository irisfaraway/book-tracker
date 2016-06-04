# Book object
class Book < ActiveRecord::Base
  belongs_to :user

  # Queries for the dashboard
  scope :rated, lambda {
    where('rating IS NOT NULL')
  }

  scope :rated_this_year, lambda {
    where('rating IS NOT NULL AND start_date >= ?', Time.zone.today.beginning_of_year)
  }

  scope :started_this_year, lambda {
    where('start_date >= ?', Time.zone.today.beginning_of_year)
  }

  scope :finished_and_has_pages, lambda {
    where('end_date IS NOT NULL AND number_of_pages IS NOT NULL')
  }

  scope :finished_this_year_and_has_pages, lambda {
    where('end_date >=? AND number_of_pages IS NOT NULL', Time.zone.today.beginning_of_year)
  }

  # Require a title, author and start date
  validates :title, :author, :start_date, presence: true

  # Restrict length of titles and authors
  validates :title, :author, length: { maximum: 100 }

  # Number of pages must be an integer above 0, or nil
  validates :number_of_pages, numericality: { only_integer: true,
                                              greater_than_or_equal_to: 1,
                                              allow_nil: true }

  # End date must be after or equal to start date, or nil
  validates :end_date, date: { after_or_equal_to: :start_date,
                               allow_nil: true }

  # Rating must be an integer between 1 and 5, or nil
  validates :rating, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 5,
                                     allow_nil: true }
end
