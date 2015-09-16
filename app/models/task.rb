class Task < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  
  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy

  validates :name, presence: true

  enumerated :section, [ :ror, :java, :python, :net ]
  letsrate_rateable 'description'
end
