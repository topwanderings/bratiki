#coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  def check_of_existence_administrator
    if UAdmin.first == nil
      redirect_to :controller => '/admin/register', :action => 'step1'
    end
  end

  def admin_is_one
    if UAdmin.first
      redirect_to :controller => '/user/login', :action => 'login'
    end
  end


  def check_teacher
    redirect_to(:root) unless session[:user_id]  || UTeacher.where(:id => session[:user_id]).first
  end

  def check_admin
    redirect_to(:root) unless session[:user_id] || UAdmin.where(:id => session[:user_id]).first
  end

  def check_student
    redirect_to(:root) unless session[:user_id] || UStudent.where(:id => session[:user_id]).first
  end

  def check_chief
    redirect_to(:root) unless session[:user_id] || UChief.where(:id => session[:user_id]).first
  end

  def teacher_id
    User.find(session[:user_id]).person.id
  end

  def group
    User.find(session[:user_id]).person.group
  end
end
