class Answer < ActiveRecord::Base
  belongs_to :task
  validates :body, presence: true, length: { maximum: 250 }
end
