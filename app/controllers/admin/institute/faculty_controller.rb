#coding: UTF-8
class Admin::Institute::FacultyController < ApplicationController
  before_filter :check_admin
  def new
    if request.post?
      faculty = ActiveRecord::Base::Faculty.new(:name => params[:name],
                                                :institute_id => params[:institute_id])
      if faculty.save
        redirect_to :controller => '/admin/institute/faculty', :action => 'index', :institute_id => params[:institute_id]
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
    redirect_to :controller => "/admin/institute/faculty", :action => "index", :institute_id => params[:institute_id]
  end

  def show
    @faculty = Faculty.find(params[:faculty_id])
  end

  def index
    @faculties = ActiveRecord::Base::Institute.find(params[:institute_id]).faculties
  end

  def edit
    @faculty = ActiveRecord::Base::Faculty.find(params[:faculty_id])
    if request.post?
      if @faculty.update_attributes(:name => params[:name],
                                    :institute_id => params[:institute_id])
        redirect_to :controller => 'admin/institute/faculty', :action => 'index', :institute_id => params[:institute_id]
      else
        @faculty.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end
end
