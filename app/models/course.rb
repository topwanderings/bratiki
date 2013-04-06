class Course < ActiveRecord::Base
  belongs_to :faculty
  has_many :groups
  attr_accessible :number, :faculty_id
end
