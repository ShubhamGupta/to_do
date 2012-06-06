class ToDoItem < ActiveRecord::Base
  attr_accessible :subject, :content, :remind_at, :remind_on, :priority
  belongs_to :to_do_list
  PRIORITY = ['High', 'Medium', 'Low']
  validates :priority, inclusion: PRIORITY
  validates :subject, :length => {:maximum => 255}
end
