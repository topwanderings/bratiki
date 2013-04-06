#coding: UTF-8
class Admin::Institute::Faculty::ChairController < ApplicationController
  before_filter :check_admin
  def new
    if request.post?
      chair = ActiveRecord::Base::Chair.new(:name => params[:name], 
					    :number => params[:number],
                        		    :faculty_id => params[:faculty_id])
      if chair.save
        redirect_to :controller => '/admin/institute/faculty/chair', :action => 'index', :institute_id => params[:institute_id], :faculty_id => params[:faculty_id], :chair_id => params[:chair_id]
      else
        chair.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def destroy
    chair = Chair.find(params[:chair_id])
    chair.destroy
    redirect_to :controller => "/admin/institute/faculty/chair", :action => "index", :institute_id => params[:institute_id], :faculty_id => params[:faculty_id], :chair_id => params[:chair_id]
  end

  def show
    @chair = Chair.find(params[:chair_id])
  end

  def index
    @chairs = ActiveRecord::Base::Faculty.find(params[:faculty_id]).chairs
  end

  def edit
    @chair = Chair.find(params[:chair_id])
    if request.post?
      if @chair.update_attributes(:name => params[:name], 
				  :number => params[:number],
                                  :faculty_id => params[:faculty_id])
        redirect_to :controller => '/admin/institute/faculty/chair', :action => 'index', :institute_id => params[:institute_id], :faculty_id => params[:faculty_id], :chair_id => params[:chair_id]
      else
        @chair.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end
end
