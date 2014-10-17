class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name,  presence: true, length: {maximum: 50}
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, length: { minimum: 6 }  

  # has_secure_password adds the following: 
    # ---> two VIRTUAL fields  [:password  +  :password_confirmation]
    # ---> the ability to save a securely hashed password_digest attribute to the database
        # NOTE: password_digest is NOT automatically added to schema: use migration
    # ---> an authenticate method that returns the user when the password is correct (and false otherwise)


  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost 
    BCrypt::Password.create(string, cost: cost)
  end

  # generate token 
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

end
