class Meal < ApplicationRecord
  belongs_to :user

  validates :calorie_intake, :name, presence: true
  validates :calorie_intake, numericality: true
  validate :end_date_is_after_start_date

  def end_date_is_after_start_date
  return if end_date.blank? || start_date.blank?

  if end_date < start_date
    errors.add(:end_date, "cannot be before the start date") 
  end 
end
end