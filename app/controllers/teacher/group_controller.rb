#coding: utf-8
class Teacher::GroupController < ApplicationController
  before_filter :check_teacher
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:group_id])
  end

end
