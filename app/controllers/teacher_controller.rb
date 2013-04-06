#coding: utf-8
class TeacherController < ApplicationController
  before_filter :check_teacher
  def home
    @date = Time.now
    @pairs = Pair.where(:teacher_id => teacher_id, :date_time => @date..(@date + 1.day))
    @tasks = Task.where(:user_id => session[:user_id], :created_at => @date..(@date + 1.day))

  end

  def calendar
    if params[:day]
      @date = sprintf("%d.%d.%d", params[:day], params[:month], params[:year])
      @date1 = @date.to_date
      @date2 = @date1 + 1
      @pairs = Pair.where(:teacher_id => teacher_id, :date_time => @date1..@date2)
      @tasks = Task.where(:user_id => session[:user_id], :created_at => @date1..@date2)
      render "day"
    else
      @cases = Array.new
      if params[:teacher_id] && params[:teacher_id] != session[:user_id]
        @pairs = Pair.where(:teacher_id => params[:teacher_id])
      else
        @pairs = Pair.where(:teacher_id => teacher_id)
        @tasks = Mission.where(:user_id => session[:user_id]).all
        for task in @tasks do
          note = "\r"
          parameters = Parameter.where(task_id: task.id).all
          parameters.each do |param|
            note += (param.name).mb_chars.capitalize + ": " + param.value + "\r\n"
          end
          note += "Время: " + task.created_at.strftime("%H:%M")
          _case = Case.new(:title => task.name, :date_time  => task.created_at , :task_id => task.id, :note => note)
          @cases << _case
        end
      end
      for pair in @pairs do
        _case = Case.new(:title => pair.subject.name, :date_time => pair.date_time, :pair_id => pair.id, :note => "\r" + "Дисциплина: " + pair.subject.name + "\r\n" + "Тип: " + pair.pair_type + "\r\n" + "Группы: " + pair.list_groups + "\r\n" + "Место: " + pair.place + "\r\n" + "Время: " + pair.date_time.strftime("%H:%M"))
        @cases << _case
      end
      @date = params[:month] ? Date.strptime(params[:year].to_s + '-' + params[:month].to_s,"%Y-%m") : Date.today
      @cases = @cases.sort {|a, b| a.date_time <=> b.date_time}
    end
  end

  def my_subjects
    @subjects = UTeacher.find(session[:user_id]).person.pairs.collect {|pair| pair.subject}
    @subjects = @subjects.uniq
  end

  def journal
    if params[:n_group_id] && params[:n_subject_id]
      redirect_to :action => 'journal', :group_id => params[:n_group_id], :subject_id => params[:n_subject_id]
    else
      @subjects = UTeacher.find(session[:user_id]).person.pairs.collect {|pair| pair.subject}
      @subjects = @subjects.uniq

      @subject = Subject.find(params[:subject_id])
      @groups = []
      pairs = Pair.where(:teacher_id => teacher_id, :subject_id => params[:subject_id]).all
      pairs.each do |pair|
        pair.groups.each do |group|
          @groups << group
        end
      end
      @groups = @groups.uniq


      @group = Group.find(params[:group_id])

      @subject = Subject.find(params[:subject_id])
      @students = @group.students
      @pairs = @group.pairs.find_all{|pair| pair.subject_id == params[:subject_id].to_i}
      if request.post?
        if params[:new_student]
          unless params[:new_student].empty?
            last_name, first_name, middle_name = params[:new_student].split(' ')
            Student.create(:last_name => last_name,
                           :first_name => first_name,
                           :middle_name => middle_name,
                           :group_id => @group.id)
          end
        end
        if params[:student]
          params[:student].each do |key, full_name|
            if full_name.empty?
              Student.find(key.to_i).destroy
            else
              last_name, first_name, middle_name = full_name.split(' ')
              student = Student.find(key.to_i)
              student.update_attributes(:last_name => last_name,
                                        :first_name => first_name,
                                        :middle_name => middle_name)
            end

          end
        end

        if params[:grade]
          params[:grade].each do |key, mark|
            student_id, pair_id = key.split('_')
            grade = Grade.where(:student_id => student_id, :pair_id => pair_id).first
            if grade
              if mark.empty?
                grade.destroy
              else
                grade.update_attributes(:mark => mark)
              end
            else
              unless mark.empty?
                Grade.create(:mark => mark, :student_id => student_id, :pair_id => pair_id)
              end
            end
          end
        end
      end
    end
  end

  def update_subject_select
    if params[:id] == "0"
      render(:partial => "group", :locals => {:groups => Group.all})
    else
      groups = []
      pairs = Pair.where(:teacher_id => teacher_id, :subject_id => params[:id]).all
      pairs.each do |pair|
        pair.groups.each do |group|
          groups << group
        end
      end
      groups = groups.uniq
      render(:partial => "group", :locals => {:groups => groups})
    end
  end
end
