class User < ApplicationRecord
  has_secure_password

  has_one_attached :pfp

  has_many :sessions, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  validate :pfp_type

  enum :role, { normal: 0, censored: 1, bf: 2, alex: 3 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def dashboard_access?
    Current.user&.role == "alex" || Current.user&.role == "bf"
  end

  def user_access?(id)
    Current.user&.id == id || Current.user&.role == "alex"
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  private
    def pfp_type
      return unless pfp.attached?

      if pfp.byte_size > 5.megabytes
        errors.add("pfp", :pfp_too_big)
      end

      types = %w[image/png image/jpeg image/webp image/gif]
      unless types.include?(pfp.content_type)
        errors.add(:pfp, :wrong_type)
      end
    end
end
