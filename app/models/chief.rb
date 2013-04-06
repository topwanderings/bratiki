class Chief < Person
  # attr_accessible :title, :body
  belongs_to :course
  attr_accessible :course_id
end
