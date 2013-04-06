#coding: UTF-8
class Teacher::Institute::FacultyController < ApplicationController
  before_filter :check_teacher
  def show
    @faculty = Faculty.find(params[:faculty_id])
  end

  def index
    @faculties = ActiveRecord::Base::Institute.find(params[:institute_id]).faculties
  end
end
