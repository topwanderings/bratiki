#encoding: UTF-8

class Teacher::ParameterController < ApplicationController
  before_filter :check_teacher
  def show
  end

  def add
    respond_to do |format|
      format.js do
        @parameter = Parameter.create(:task_id => params[:task_id], :name => params[:name].mb_chars.capitalize, :value => params[:value], :entity => params[:entity])
      end
    end
  end

  def constructor
    respond_to do |format|
      format.js do
        render :action => 'constructor'
      end
      format.html do
        render :action => 'constructor'
      end
    end
  end

  def edit
    respond_to do |format|
      format.js do
        parameter = Parameter.find(params[:parameter_id])
        parameter.update_attributes(:name => params[:name].mb_chars.capitalize) if params[:name]
        parameter.update_attributes(:value => params[:value]) if params[:value]
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        parameter = Parameter.find(params[:parameter_id])
        parameter.destroy
      end
    end
  end

  def listbox
    chair_names, faculty_names ,group_names, institute_names, student_names, teacher_names = [], [], [], [], [], []

    @list_entity = {:institute => t('institute'),
                    :faculty => t('faculty'),
                    :chair => t('chair'),
                    :group => t('group'),
                    :student => t('student'),
                    :teacher => t('teacher')}

    faculties = ActiveRecord::Base::Faculty.all
    faculties.each do |faculty|
      faculty_names << faculty.name
    end

    chairs = ActiveRecord::Base::Chair.all
    chairs.each do |chair|
      chair_names << chair.name
    end

    groups = ActiveRecord::Base::Group.all
    groups.each do |group|
      group_names << group.number
    end

    institutes = ActiveRecord::Base::Institute.all
    institutes.each do |institute|
      institute_names << institute.name
    end

    students = ActiveRecord::Base::Student.all
    students.each do |student|
      student_names << student.full_name
    end

    teachers = ActiveRecord::Base::Teacher.all
    teachers.each do |teacher|
      teacher_names << teacher.full_name
    end

    list_instance_entity = {t('institute') => institute_names,
                            t('faculty') => faculty_names,
                            t('chair') => chair_names,
                            t('group') => group_names,
                            t('teacher') => teacher_names,
                            t('student') => student_names}

    @list_name = list_instance_entity[params[:name_entity]] if params[:name_entity]
  end
end
