class ShortenedUrl < ApplicationRecord
  validates :long_url, uniqueness: true, presence: true
  validate :user_id, :no_spamming, :nonpremium_max

  def self.random_code
    random = SecureRandom.urlsafe_base64
    until !self.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64
    end
    random
  end

  def self.create!(user, long_url)
    ShortenedUrl.new(long_url: long_url, short_url: self.random_code, user_id: user.id)
  end

  belongs_to(:submitter, {
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id
  })

  has_many(:visitors, {
    class_name: :Visit,
    foreign_key: :short_url,
    primary_key: :short_url
  })

  def num_clicks
    Visit.where(short_url: self.short_url).count
  end

  def num_uniques
    Visit.where(short_url: self.short_url).select(:user_id).distinct.count
  end

  def num_recent_uniques
    Visit.where(short_url: self.short_url, created_at: (10.minutes.ago)..(Time.now)).select(:user_id).distinct.count
  end

  has_many(:tag_topics, {
    class_name: :TagTopic,
    foreign_key: :short_url,
    primary_key: :short_url
  })

  def no_spamming
    num = ShortenedUrl.where(user_id: self.user_id, created_at: 1.minute.ago..Time.current).count
    if num >= 5
      errors[:spamming] << "Cannot submit more than 5 urls in a minute"
    end
  end

  def nonpremium_max
    num = ShortenedUrl.where(user_id: self.user_id).count
    p = User.find(self.user_id).premium
    if num >= 5 && !p
      errors[:premium] << "Non Premium users cannot submit more than 5 urls"
    end
  end

  def self.prune(n)
    lazy = Visit.select(:short_url).distinct.where("created_at < ?", n.minute.ago).map(&:short_url)
    lazy.each do |url|
      unless User.find(ShortenedUrl.find_by(short_url: url).user_id).premium
        TagTopic.destroy_by(short_url: url)
        Visit.destroy_by(short_url: url)
        ShortenedUrl.destroy_by(short_url: url)
      end
    end
  end
end