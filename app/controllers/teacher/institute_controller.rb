class Teacher::InstituteController < ApplicationController
  before_filter :check_teacher
  def show
    @institute = ActiveRecord::Base::Institute.find(params[:institute_id])
  end

  def index
    @institutes = ActiveRecord::Base::Institute.all
  end
end

