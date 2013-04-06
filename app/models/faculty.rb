#coding: UTF-8
class Faculty < ActiveRecord::Base
  belongs_to :institute
  has_many :people
  has_many :chairs
  has_many :courses
  has_many :groups, :through => :courses
  attr_accessible :name, :institute_id

  validates_length_of :name, :maximum => 50, :message => "слишком длинное название факультета"
  validates_uniqueness_of :name, :message => "введите другое название факультета"
  validates_format_of :name, :with => /^[а-я ]+$/i, :message => "некорректное название факультета"
  validates_presence_of :name, :message => "введите название факультета"

end