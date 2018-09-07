class Transport < ApplicationRecord
  belongs_to :place
  validates :type_of_transport, :start_date, :end_date, :start_location, presence: true
  validates :end_date, presence: true, date: { after_or_equal_to: :start_date }
  validate :start_date_within_place_dates, :end_date_within_place_dates

  before_save :set_date_to_midnight
  
  private

  def start_date_within_place_dates
    StartDateWithinPlaceDateService.new(self).call
  end

  def end_date_within_place_dates
    EndDateWithinPlaceDateService.new(self).call
  end

  def set_date_to_midnight
    SetDateService.new(self).call
  end
end
