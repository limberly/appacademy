require 'date'

class Cat < ApplicationRecord
  CAT_COLORS = ["black", "yellow"]
  CAT_SEX = ["m", "f"]
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: {in: CAT_COLORS, message: "Only black or yellow allowed"}
  validates :sex, length: {maximum: 1}, inclusion: {in: CAT_SEX, message: "Only m or f allowed"}

  def age
    birth = Date.parse(self.birth_date)
    today = Date.today
    today.year - birth.year
  end
end