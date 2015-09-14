class Task < ActiveRecord::Base
  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :task_tags, :dependent => :destroy
  has_many :images, :dependent => :destroy

  validates :name, presence: true

  enumerated :section, [ :ror, :java, :python, :net ]
end
