# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :activated
  attr_accessor :password, :password_confirmation
  
  has_many :tunes
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :name,  :presence => true, :length => { :maximum => 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX },
                    :uniqueness => { :case_sensitive => false }
  
  validates :password,
            :length => (6..128),
            :confirmation => true,
            :if => :setting_password?

  def password=(password_str)
    @password = password_str
    
    if password != '' then
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password_str, password_salt)
    end
  end

  def authenticate(password)
    if password.present? && password_digest.present? && password_digest == BCrypt::Engine.hash_secret(password, password_salt)
      self
    else
      nil
    end
  end

  def setting_password?
    (self.password || self.password_confirmation) &&
        (self.password != '' || self.password_confirmation != '')
  end
  
  private
    def create_remember_token
      self.remember_token = SecureRandom.base64.tr("+/", "-_")
    end
end
