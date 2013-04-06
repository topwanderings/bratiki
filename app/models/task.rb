class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  attr_accessible :name, :status, :time_complete, :type, :user_id

  def full_copy(task_id)
    self.copy(task_id)
    sub_tasks = Task.find_all_by_task_id(task_id)
    if sub_tasks
      sub_tasks.each do |sub_task|
        task = SubMission.create(:user_id => 1, :task_id => self.id, :status => false)
        task.full_copy(sub_task.id)
      end
    end
  end

  def copy(task_id)
    task = Task.find(task_id)
    parameters = Parameter.find_all_by_task_id(task_id)
    if parameters
      parameters.each do |parameter|
        dub_parameter = parameter.dup
        dub_parameter.update_attributes(:task_id => self.id)
      end
    end
    self.update_attributes(:name => task.name)
  end

  def full_destroy
    task_id = self.id
    sub_tasks = SubMission.find_all_by_task_id(task_id)
    if sub_tasks
      sub_tasks.each do |sub_task|
        sub_task.full_destroy

        sub_task.destroy
      end
    end
    parameters = Parameter.find_all_by_task_id(task_id)
    if parameters
      parameters.each do |parameter|
        parameter.destroy
      end
    end
    self.destroy
  end

  def parents(mass_parent_id)
    parent_id = self.task_id
    if parent_id
      parent = Task.find(parent_id)
      mass_parent_id << parent_id
      parent.parents(mass_parent_id)
    end
    mass_parent_id
  end

  def parent_names
    mass_parent_id = []
    mass_parent_name = []
    mass_parent_id = self.parents(mass_parent_id)
    unless mass_parent_id.empty?
      mass_parent_id.each do |parent_id|
        name = Task.find(parent_id).name
        mass_parent_name << { :id => parent_id, :name => name }
      end
    end
    mass_parent_name
  end

  def revers_status
    status = !self.status
    self.update_attributes(:status => status)
  end
end
