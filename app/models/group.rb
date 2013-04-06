#coding: UTF-8
class Group < ActiveRecord::Base
  belongs_to :chair
  has_and_belongs_to_many :pairs
  has_many :students
  belongs_to :course
  attr_accessible :number, :chair_id


  validates_length_of :number, :maximum => 50, :message => "слишком длинный номер группы"
  validates_uniqueness_of :number, :message => "введите другой номер группы"
  validates_format_of :number, :with => /^[0-9]+$/i, :message => "некорректный номер группы"
  validates_presence_of :number, :message => "введите номер группы"
end
