class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true

  enum :role, { normal: 0, censored: 1, bf: 2, alex: 3 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def dashboard_access?
    Current.user&.role == "alex" || Current.user&.role == "bf"
  end
end
