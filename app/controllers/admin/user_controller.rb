#coding: utf-8
class Admin::UserController < ApplicationController
  before_filter :check_admin

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to :controller => "/admin/user", :action => "index"
  end

  def index
    @users = User.all
    if params[:type]
      @users = case params[:type]
                 when "admin"
                   UAdmin.all
                 when "chief"
                   UChief.all
                 when "teacher"
                   UTeacher.all
                 when "student"
                   UStudent.all
                 else
                   User.all
               end
    end

  end

  def activate
    @user = User.find(params[:id])
    @user.update_attributes(:activated => true)
    redirect_to :controller => 'admin/user', :action => 'index'
  end

  def edit
    @person = ActiveRecord::Base::User.find(params[:id]).person
    if request.post?
      if @person.update_attributes(:last_name => params[:last_name],
                                   :first_name => params[:first_name],
                                   :middle_name => params[:middle_name],
                                   :middle_name => params[:middle_name],
                                   :sex_id => params[:sex_id],
                                   :chair_id => params[:chair_id],
                                   :course_id => params[:course_id],
                                   :military_rank_id => params[:military_rank_id],
                                   :scientific_rank_id => params[:scientific_rank_id],
                                   :scientific_degree_id => params[:scientific_degree_id],
                                   :post_id => params[:post_id],
                                   :group_id => params[:group_id],
                                   :telephone => params[:telephone],
                                   :room => params[:room])
        redirect_to(:controller => 'admin/user', :action => 'index')
      else
        @person.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    else
      case @person.type
        when 'Admin'
          render 'admin'
        when 'Teacher'
          render 'teacher'
        when 'Student'
          render 'student'
        when 'Chief'
          render 'chief'
        else
          render 'user'
      end
    end
  end
end
