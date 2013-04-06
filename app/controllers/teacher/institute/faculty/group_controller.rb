#coding: UTF-8
class Teacher::Institute::Faculty::GroupController < ApplicationController
  before_filter :check_teacher
  def show
    @group = Group.find(params[:group_id])
  end

  def index
    @groups = ActiveRecord::Base::Faculty.find(params[:faculty_id]).groups
  end
end
