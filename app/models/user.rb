class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  # Return the hash digest of the given string into the arguemnt
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #Return the random token (SecureRandom.urlsafe_base64)
  def User.new_toke
    SecureRandom.urlsafe_base64
  end

  #Remember a user in the database for use in persistent session
  # allow us to remember user session after they login
  def remember
    # Do't have a remember_token in our databse, like password that
    # was generated with has_secure_password
    # So we need to put attr_accessors the remmebr_token
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(remember_token))
  end


  # look into the has_secure_password authenticate source code
  # Return true if the given token matches the digest
  def authenticated?(remember_token)
    # This (if logic)will prevent when two user logged_in in two window and close them
    # both, then the remember_digest is nil and throw an error, so this prevent that
    if remember_digest.nil?
      return false
    end

     BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
