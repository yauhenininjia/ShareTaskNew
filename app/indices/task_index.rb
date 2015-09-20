ThinkingSphinx::Index.define :task, :with => :active_record do
  # fields
  indexes name, :sortable => true
  indexes description
  indexes user(:nickname), :as => :author
  indexes comments.body
end