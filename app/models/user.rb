class User < ActiveRecord::Base
  #added in the associations between the user and other users
  has_many :matches, :foreign_key => :user_id, :class_name => "Match", dependent: :destroy
  # has-many (:reverse_matches, :class_name => "Match", :foreign_key => :second_selector_id, :dependent => :destroy)

  has_many :connections, :through => :matches


  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :job_title, presence: true, length: { maximum: 50 }
  validates :company_name, presence: true, length: { maximum: 50 }

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
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #Remember a user in the database for use in persistent session
  # allow us to remember user session after they login
  def remember
    # Do't have a remember_token in our databse, like password that
    # was generated with has_secure_password
    # So we need to put attr_accessors the remmebr_token
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


   # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

   # look into the has_secure_password authenticate source code
  # Return true if the given token matches the digest
  def authenticated?(remember_token)
    # This (if logic)will prevent when two user logged_in in two window and close them
    # both, then the remember_digest is nil and throw an error, so this prevent that
    return false if remember_digest.nil?
     BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
#a method that eliminates matches the user already has from the possibilities
  def self.take_matches_out(user_id)
    @already_connected_id = [user_id.id]
    find_by(id: user_id).matches.each do |match|
      @already_connected_id << match.connection_id
    end

    Match.where(connection_id: user_id.id, active: true).each do |match|
      @already_connected_id << match.user_id
    end
    @already_connected_id
  end
#a method that selects a random person that is not you, and that you haven't connected with yet.
  def self.random_connection(matched_already)
    where.not(id: matched_already).shuffle.first
  end

end
