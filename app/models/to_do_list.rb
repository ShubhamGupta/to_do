class ToDoList < ActiveRecord::Base
  attr_accessible :name, :priority
  has_many :to_do_items
  belongs_to :user
  PRIORITY = ['High', 'Medium', 'Low']
  validates :priority, inclusion: PRIORITY
  validates :name, presence: true
end
