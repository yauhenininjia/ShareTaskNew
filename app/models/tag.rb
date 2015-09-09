class Tag < ActiveRecord::Base
	has_many :task_tags
end
