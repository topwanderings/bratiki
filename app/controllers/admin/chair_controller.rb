#coding: UTF-8
class Admin::ChairController < ApplicationController
  before_filter :check_admin
  def new
    if request.post?
      chair = Chair.new(:name => params[:name], :number => params[:number],
                        :faculty_id => params[:faculty_id])
      if chair.save
        redirect_to :controller => 'admin/chair', :action => 'index'
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
    redirect_to :controller => "/admin/chair", :action => "index"
  end

  def show
    @chair = Chair.find(params[:chair_id])
  end

  def index
    @chairs = ActiveRecord::Base::Chair.all
  end

  def edit
    @chair = ActiveRecord::Base::Chair.find(params[:chair_id])
    @faculty_id = @chair.faculty_id
    if request.post?
      if @chair.update_attributes(:name => params[:name], :number => params[:number] ,
                                  :faculty_id => params[:faculty_id])
        redirect_to :controller => 'admin/chair', :action => 'index'
      else
        @chair.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end
end
