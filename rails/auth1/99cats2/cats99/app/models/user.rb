class User < ApplicationRecord
  validates :username, presence: {message: "Username cannot be blank"}, uniqueness: true
  validates :session_token, presence: {message: "You need a session token cannot be blank"}, uniqueness: true
  validates :password_digest, presence: {message: "Password cannot be blank"}
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :cats
  has_many :cat_rental_requests

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(username: user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

  def owns_cat?(cat)
    cat.user_id == self.id
  end

end