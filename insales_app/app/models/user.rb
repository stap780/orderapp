class User < ActiveRecord::Base
  has_secure_password
  
  validates :first_name, presence: true
  validates :login, presence: true
  validates :email, presence: true, uniqueness: true, format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            }
   validates :password, presence: true         
            
  def to_s
    "#{first_name} #{last_name}"
  end
  
end
