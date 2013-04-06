#coding: UTF-8
class Admin::ProjectController < ApplicationController
  before_filter :check_admin
  def index
  end

  def restart
    system "rake db:migrate VERSION=0"
    system "rake db:migrate"
    redirect_to(:root)
  end

  def new_study_year
    chiefs = Chief.all
    chiefs.each do |chief|
      course = chief.course
      faculty = course.faculty
      if course.number == 5
        course = Course.where(:number => 1, :faculty_id => faculty.id).first
        if course
          chief.update_attributes(:course_id => course.id)
        end
      else
        number = course.number  + 1
        faculty_id = faculty.id
        course = Course.where(:number => number, :faculty_id => faculty_id).first
        if course
          chief.update_attributes(:course_id => course.id)
        end
      end
    end
    students = Student.all
    students.each do |student|
      group = student.group
      course = group.course
      if course
        if course.number == 5
          student.destroy
        else
          group_number = (group.number.to_i + 10).to_s
          group = Group.where(:number => group_number).first
          if group
            student.update_attributes(:group_id => group.id)
          end
        end
      else
        group_number = group.number.to_i
        if (group_number % 100) > 50
          student.destroy
        else
        group_number += 10
        group = Group.where(:number => group_number).first
        student.update_attributes(:group_id => group.id) if group
        end
      end
    end

    redirect_to(:controller => '/admin', :action => 'home')
  end

  def log
    #@log = YAML.load_file File.join(File.dirname(__FILE__), '/../../../register_teacher.yml')
    file_name = File.join(File.dirname(__FILE__), '/../../../register_teacher.yml')
    File.zero?(file_name)? @log = nil : @log = YAML.load_file(file_name)
  end
end
