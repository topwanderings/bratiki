#coding: UTF-8
class Person < ActiveRecord::Base
  belongs_to :sex
  belongs_to :military_rank
  belongs_to :scientific_rank
  belongs_to :scientific_degree
  belongs_to :post
  belongs_to :chair
  belongs_to :group
  has_many :pairs
  has_many :users, :dependent => :destroy

  attr_accessible :first_name,
                  :last_name,
                  :middle_name,
                  :room,
                  :telephone,
                  :sex_id,
                  :military_rank_id,
                  :scientific_rank_id,
                  :scientific_degree_id,
                  :post_id,
                  :chair_id,
                  :group_id,
		              :course_id,
                  :type

  validates_presence_of :last_name, :message => "введите фамилию"
  validates_format_of :last_name, :with =>  /^([а-я])+$/i, :message => "фамилия введена некорректно"

  validates_presence_of :first_name, :message => "введите имя"
  validates_format_of :first_name, :with =>  /^([а-я])+$/i, :message => "имя введено некорректно"

  validates_presence_of :middle_name, :message => "введите отчество"
  validates_format_of :middle_name, :with =>  /^([а-я])+$/i, :message => "отчество введено некорректно"

  def full_name
    self.last_name + " " + self.first_name + " " + self.middle_name
  end

  def last_name_with_initials
    self.last_name + " " + self.first_name.upcase[0] + " " + self.middle_name.upcase[0]
  end

  def half_name
    self.last_name + ' ' + first_name[0].upcase + '.' + middle_name[0].upcase + '.'
  end
end
