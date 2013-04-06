class Case < ActiveRecord::Base
  attr_accessible :date_time, :note, :pair_id, :task_id, :title
end
