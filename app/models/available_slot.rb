class AvailableSlot < ApplicationRecord
  belongs_to :item

  validate :available_date_within_one_month

  private

  def available_date_within_one_month
    return if available_date.blank?

    if available_date < Date.today
      errors.add(:available_date, "は今日以降の日付を選択してください")
    elsif available_date > Date.today + 30
      errors.add(:available_date, "は今日から1カ月以内の日付を選択してください")
    end
  end
end
