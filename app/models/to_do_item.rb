class ToDoItem < ActiveRecord::Base
  attr_accessible :subject, :content, :remind_at, :remind_on, :priority
  belongs_to :to_do_list
  validates :priority, inclusion: PRIORITY
  validates :subject, :length => {:maximum => 255}, presence: true
  def belongs_to_current_user?(curr_user)
  	self.to_do_list.user_id == curr_user.id
  end
end
