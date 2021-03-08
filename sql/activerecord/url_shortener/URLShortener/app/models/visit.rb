class Visit < ApplicationRecord
  def self.record_visit!(user, shortened_url)
    v = Visit.new(user_id: user.id, short_url: shortened_url.short_url)
    v.save
  end
end