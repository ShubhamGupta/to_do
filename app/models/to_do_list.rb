class ToDoList < ActiveRecord::Base
  attr_accessible :name, :priority
  has_many :to_do_items
  belongs_to :user
  validates :priority, inclusion: PRIORITY
  validates :name, presence: true
  
  def belongs_to_current_user?(curr_user)
  	self.user_id == curr_user.id 
  end
end
