class User < ApplicationRecord
  has_many :orders
  has_many :user_comments
  has_many :receiver_infos
  has_many :carts, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.name.max_length}
  validates :email, presence: true,
                    length: {maximum: Settings.email.max_length},
                    format: {with: Regexp.new(Settings.email.valid_email_regex)}

  validates :password, presence: true,
                       length: {minimum: Settings.password.min_length},
                       allow_nil: true

  has_secure_password

  attr_accessor :activation_token, :remember_token

  before_save :downcase_email
  before_create :create_activation_digest
  class << self
    def User.digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost => cost
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
  def send_order_success_email
    UserMailer.order_success(self).deliver_now
  end
  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end
  def has_address?
    receiver_info.present?
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
