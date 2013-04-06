#coding: UTF-8
class Teacher::ChairController < ApplicationController
  before_filter :check_teacher
  def show
    @chair = Chair.find(params[:chair_id])
  end

  def index
    @chairs = ActiveRecord::Base::Chair.all
  end
end
