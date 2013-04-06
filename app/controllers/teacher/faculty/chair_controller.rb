#coding: UTF-8
class Teacher::Faculty::ChairController < ApplicationController
  before_filter :check_teacher
  def show
    @chair = Chair.find(params[:chair_id])
  end

  def index
    @chairs = ActiveRecord::Base::Faculty.find(params[:faculty_id]).chairs
  end
end
