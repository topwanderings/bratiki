#coding: UTF-8
class Admin::Institute::GroupController < ApplicationController
  before_filter :check_admin
  def new
    if request.post?
      group = ActiveRecord::Base::Group.new(:number => params[:number],
                                            :chair_id => params[:chair_id])
      if group.save
        redirect_to :controller => '/admin/institute/group', :action => 'index', :institute_id => params[:institute_id]
      else
        group.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def destroy
    group = Group.find(params[:group_id])
    group.destroy
    redirect_to :controller => "/admin/institute/group", :action => "index", :institute_id => params[:institute_id]
  end

  def show
    @group = Group.find(params[:group_id])
  end

  def index
    @groups = ActiveRecord::Base::Institute.find(params[:institute_id]).groups
  end

  def edit
    @group = Group.find(params[:group_id])
    if request.post?
      if @group.update_attributes(:number => params[:number],
                                  :chair_id => params[:chair_id])
        redirect_to :controller => 'admin/institute/group', :action => 'index', :institute_id => params[:institute_id]
      else
        @group.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end
end
