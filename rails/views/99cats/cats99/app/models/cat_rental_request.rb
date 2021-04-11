class CatRentalRequest < ApplicationRecord
  STATUS = ["PENDING", "APPROVED", "DENIED"]
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: STATUS, message: "Must be one of #{STATUS.join(" or ")}"}

  belongs_to :cat
end