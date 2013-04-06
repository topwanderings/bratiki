#coding: UTF-8
class Chair < ActiveRecord::Base
  belongs_to :faculty
  has_many :groups
  has_many :people
  attr_accessible :name, :number, :faculty_id

  validates_length_of :name, :maximum => 50, :message => "слишком длинное название кафедры"
  validates_uniqueness_of :name, :message => "введите другое название кафедры"
  validates_format_of :name, :with => /^[а-я ]+$/i, :message => "некорректное название кафедры"
  validates_presence_of :name, :message => "введите название кафедры"

  validates_length_of :number, :maximum => 50, :message => "слишком длинный номер кафедры"
  validates_uniqueness_of :number, :message => "введите другой номер кафедры"
  validates_format_of :number, :with => /^[0-9]+$/i, :message => "некорректный номер кафедры"
  validates_presence_of :number, :message => "введите номер кафедры"
end