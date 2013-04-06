class Grade < ActiveRecord::Base
  belongs_to :student
  belongs_to :pair
  attr_accessible :mark, :student_id, :pair_id
end
