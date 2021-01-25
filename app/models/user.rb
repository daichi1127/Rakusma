class User < ApplicationRecord
    has_one :cart
    
    
    validates :name, {presence: true}
    
    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}

    # has_secure_password
    validates :password, presence: true, length:{minimum:6}, length: { maximum: 12 }, allow_nil: true
end
