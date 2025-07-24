class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
  validate :correct_email_format?

  private
  def correct_email_format?
    if email.present?
      if !email.include?("bitscollege")
        errors.add(:email, "email is not in the correct format")
      end
    end
  end
end
