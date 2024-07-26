class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: Settings.name.max_length }
  validates :email, presence: true,
                    length: {maximum: Settings.email.max_length},
                    format: {with: Regexp.new(Settings.email.valid_email_regex)}

  has_secure_password

  attr_accessor :activation_token

  before_save :downcase_email
  before_create :create_activation_digest
  class << self
    def User.digest string
      cost = if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
          BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
  end
  end
  def authenticated? attribute, token
    digest = send "#{attribute}_digest"

    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end
  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  private

  def downcase_email
    email.downcase!
  end
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
