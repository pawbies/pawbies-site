class User < ApplicationRecord
  has_one_attached :pfp

  has_secure_password

  has_many :sessions, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  validate :valid_pfp

  enum :role, { normal: 0, bf: 2, alex: 3 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def dashboard_access?
    Current.user&.role == "alex" || Current.user&.role == "bf"
  end

  def user_access?(id)
    Current.user&.id == id || Current.user&.role == "alex"
  end

  generates_token_for(:email_verification) do
    email_address
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  private
    def valid_pfp
    end
end
