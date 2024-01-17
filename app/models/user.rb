class User < ApplicationRecord
  has_secure_password

  validates :user_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: 'Please enter a valid number' }
  validates :password, presence: true, length: { minimum: 8 }
  validate :password_complexity

  enum user_role: { User: 0, Admin: 1 }

  private

  def password_complexity
    return if password.blank? || password.match?(%r{\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()_+{}\[\]:;<>,.?~\\\/-]).{8,}\z})

    errors.add(:password, 'must contain at least one uppercase letter, ' \
      'one lowercase letter, one special character, one number, ' \
      'and be at least 8 characters long')
  end
end
