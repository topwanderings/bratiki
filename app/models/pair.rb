class Pair < ActiveRecord::Base
  has_and_belongs_to_many :groups
  belongs_to :subject
  belongs_to :teacher
  attr_accessible :date_time, :pair_type, :pair_number, :teacher_id, :place, :teacher, :subject_id

  def list_groups
    @list_groups = ""
    self.groups.each do |group|
      if @list_groups.empty?
        @list_groups = group.number
      else
        @list_groups += ', ' + group.number
      end
    end
    @list_groups
  end
end
