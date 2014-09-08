class User < ActiveRecord::Base
  before_create { generate_token(:auth_token) }
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  #validates_presence_of :email
  #validates_uniqueness_of :email
  
  def self.authenticate(email,password)
    user = self.find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
       user
    else
      nil
    end
  end
  def self.create_with_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["name"] 
    user.email = auth["info"]["email"] if auth["provider"].eql?("facebook")
    user.email = auth["info"]["name"] if auth["provider"].eql?("twitter")
    user.password_confirmation = "something"
    user.password = "something"
  end

end
  def self.from_omniauth(auth)
   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["name"]
    user.oauth_token = auth["credentials"]["token"]
    user.oauth_expires_at = Time.at(auth["credentials"]["expires_at"])
    user.save!
  end
end
  def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  UserMailer.password_reset(self).deliver
end

def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
