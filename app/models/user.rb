class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email_id, :user_name, :password, :password_confirmation
  has_many :to_do_lists
  validates :email_id, :user_name, uniqueness: true, :length => { :maximum =>255}
  validates :first_name, :email_id, :password, :user_name, presence: true
  validates :password , :confirmation => true, :length => { :minimum =>5}
  #before_save :encrypt_password(:password)
  
  def self.authenticate_user(user_name ="", password="")
  	user = User.where(:user_name=> user_name , :password => password)
  	if user.length == 0
  		return false
  	else
  		return true
  	end
  end
end
