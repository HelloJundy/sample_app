# coding: utf-8

# coding: utf-8
class User < ApplicationRecord
  # callback ,在Active Record 对象的生命周期的特定时刻调用
  before_save { email.downcase! }
  
  validates(:name, presence: true, length: { maximum: 50 })
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
