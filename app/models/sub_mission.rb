class SubMission < Task
  belongs_to :task
  has_many :sub_missions
  attr_accessible :task_id
end
