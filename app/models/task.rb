class Task < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :comments
  has_many :task_tags

  validates :name, presence: true
end
