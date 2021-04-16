class CatRentalRequest < ApplicationRecord
  STATUS = ["PENDING", "APPROVED", "DENIED"]
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: STATUS, message: "Must be one of #{STATUS.join(" or ")}"}
  validate :does_not_overlap_approved_request, on: :create, on: :update
  belongs_to :cat

  def overlapping_requests
    CatRentalRequest.where([" id != ? and cat_id = ? and start_date <= ? and end_date >= ?", self.id, self.cat_id, self.end_date, self.start_date])
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors.add(:id, "Cannot rent during the given dates") unless self.status == "DENIED"
    end
  end

  def approve!
    self.transaction do 
      self.status = "APPROVED"
      self.save!
      overlapping = self.overlapping_pending_requests
      overlapping.each do |overlap|
        overlap.update(status: "DENIED")
        overlap.save!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end
  

end