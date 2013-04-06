#coding: UTF-8
class Teacher::Faculty::Chair::GroupController < ApplicationController
  before_filter :check_teacher
  def show
    @group = Group.find(params[:group_id])
  end

  def index
    @groups = ActiveRecord::Base::Chair.find(params[:chair_id]).groups
  end
end
