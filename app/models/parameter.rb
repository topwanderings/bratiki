class Parameter < ActiveRecord::Base
  belongs_to :task
  attr_accessible :value, :name, :task_id, :entity
end
