#coding: utf-8
class StudentController < ApplicationController
  before_filter :check_student

  def home
    day, month, year = Time.now.day, Time.now.month, Time.now.year
    @date = DateTime.new(year, month, day)
    @pairs = group.pairs.find_all{|pair| (@date..(@date + 1.day)).cover?(pair.date_time)}
  end

  def calendar
    if params[:day]
      @date = sprintf("%d.%d.%d", params[:day], params[:month], params[:year])
      @date1 = @date.to_date
      @date2 = @date1 + 1

      @pairs = group.pairs.find_all{|pair| (@date1..@date2).cover?(pair.date_time)}
      @tasks = Task.where(:user_id => session[:user_id], :date_time => @date1..@date2)
      render "day"
    else
      @cases = Array.new
      @pairs = group.pairs
      for pair in @pairs do
        _case = Case.new(:title => pair.subject.name, :date_time => pair.date_time, :pair_id => pair.id, :note => "\r" + pair.subject.name + "\r\n" + pair.pair_type + "\r\n" + pair.teacher.half_name + "\r\n" + pair.place + "\r\n" + pair.date_time.strftime("%H:%M"))
        @cases << _case
      end
      @date = params[:month] ? Date.strptime(params[:year].to_s + '-' + params[:month].to_s,"%Y-%m") : Date.today
      @cases = @cases.sort {|a, b| a.date_time <=> b.date_time}
    end
  end

  def my_subjects
    @subjects = group.pairs.collect {|pair| pair.subject}
    @subjects = @subjects.uniq
  end

  def journal
    if params[:n_subject_id]
      redirect_to :action => 'journal', :subject_id => params[:n_subject_id]
    else
      @subjects = group.pairs.collect {|pair| pair.subject}
      @subjects = @subjects.uniq

      @group = Group.find(params[:group_id])
      @subject = Subject.find(params[:subject_id])
      @students = @group.students
      @pairs = @group.pairs.find_all{|pair| pair.subject_id == params[:subject_id].to_i}
    end
  end
end
