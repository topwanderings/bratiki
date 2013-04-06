#coding: UTF-8
class Teacher::Institute::ChairController < ApplicationController
  before_filter :check_teacher
  def show
    @chair = Chair.find(params[:chair_id])
  end

  def index
    @chairs = ActiveRecord::Base::Institute.find(params[:institute_id]).chairs
  end
end
