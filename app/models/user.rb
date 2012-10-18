class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  validates :name, 
            presence: true,
            length: { maximum: 255 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
  validates :password,
            presence: true,
            confirmation: true
  validates :password_confirmation,
            presence: true
end