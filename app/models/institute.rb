#coding: UTF-8
class Institute < ActiveRecord::Base
  attr_accessible :name
  has_many :faculties
  has_many :chairs, :through => :faculties
  has_many :groups, :through => :faculties

  validates_length_of :name, :maximum => 50, :message => "слишком длинное название института"
  validates_uniqueness_of :name, :message => "введите другое название института"
  validates_format_of :name, :with => /^[а-я ]+$/i, :message => "некорректное название института"
  validates_presence_of :name, :message => "введите название института"
end
