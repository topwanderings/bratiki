class Teacher < Person
  # attr_accessible :title, :body
  has_many :pairs
end
