#coding: utf-8
class Admin::GroupController < ApplicationController
  before_filter :check_admin
  def new
    if request.post?
      group = Group.new(:number => params[:number],
                        :chair_id => params[:chair_id])
      if group.save
        redirect_to :controller => 'admin/group', :action => 'index'
      else
        group.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:group_id])
  end

  def destroy
    group = Group.find(params[:group_id])
    group.destroy
    redirect_to :controller => "/admin/group", :action => "index"
  end

  def edit
    @group = Group.find(params[:group_id])
    @chair_id = @group.chair_id
    if request.post?
      if @group.update_attributes(:number => params[:number] ,
                                  :chair_id => params[:chair_id])
        redirect_to :controller => 'admin/group', :action => 'index'
      else
        @group.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end
end
