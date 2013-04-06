class Teacher::FacultyController < ApplicationController
  before_filter :check_teacher
  def show
    @faculty = ActiveRecord::Base::Faculty.find(params[:faculty_id])
  end

  def index
    @faculties = ActiveRecord::Base::Faculty.all
  end
end
