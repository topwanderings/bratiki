class Student < Person
  # attr_accessible :title, :body
  has_many :grades
end
