class Admin::FacultyController < ApplicationController
  before_filter :check_admin
  def new
    if request.post?
      faculty = ActiveRecord::Base::Faculty.new(:name => params[:name], :institute_id => params[:institute_id])
      if faculty.save
        redirect_to :controller => 'admin/faculty', :action => 'index'
      else
        faculty.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def destroy
    faculty = ActiveRecord::Base::Faculty.find(params[:faculty_id])
    faculty.destroy
    redirect_to :controller => "/admin/faculty", :action => "index"
  end

  def show
    @faculty = ActiveRecord::Base::Faculty.find(params[:faculty_id])
  end

  def index
    @faculties = ActiveRecord::Base::Faculty.all
  end

  def edit
    @faculty = ActiveRecord::Base::Faculty.find(params[:faculty_id])
    if request.post?
      if @faculty.update_attributes(:name => params[:name], :institute_id => params[:institute_id])
        redirect_to :controller => 'admin/faculty', :action => 'index'
      else
        @faculty.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end
end
