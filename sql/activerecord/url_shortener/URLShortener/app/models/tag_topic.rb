class TagTopic < ApplicationRecord
  validates :tag, presence: true

  belongs_to(:shortened_url, {
    class_name: :ShortenedUrl,
    foreign_key: :short_url,
    primary_key: :short_url
  })

  def popular_links
    count = 0
    TagTopic.where(tag: self.tag).map do |t|
      count += 1
      short = t.shortened_url
      url = short.short_url
      clicks = short.num_clicks
      [url, clicks]
      break if count == 5
    end
  end
end