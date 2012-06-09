require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email_id, :user_name, :password, :password_confirmation
  has_many :to_do_lists
  validates :email_id, :user_name, uniqueness: true, :length => { :maximum =>255}
  validates :first_name, :email_id, :password, :user_name, presence: true
  validates :password , :confirmation => true, :length => { :minimum =>5}
  validates_format_of :email_id, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  before_save :encrypt_password
  def self.authenticate_user(user_name ="", password="")
  	user = User.where(:user_name=> user_name , :password => Digest::SHA1.hexdigest(password))
  	return false if user.empty?
  	return true
  end
  
  def encrypt_password
  	self.password =	Digest::SHA1.hexdigest(self.password)
  end
end
