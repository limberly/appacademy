class House < ApplicationRecord
  validates :address, uniqueness: true

  has_many(
    :residents,
  class_name: :Person,
  foreign_key: :house_id,
  primary_key: :id
  )

end