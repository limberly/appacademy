class User < ApplicationRecord
  before_validation :ensure_session_token
  
  validates :username, uniqueness: true
  validates :username, :session_token, presence: true
  validates :password_digest, presence: {message: "Password can\'t be blank"}, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  def self.find_by_credentials(username, password)
    User.find_by(username: username)
    return user if user && BCrypt::Password.new(self.password_digest).is_password?(password)
    nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
