class Teacher::PatternController < ApplicationController
  before_filter :check_teacher
  def add
  end

  def copy
    task_id = params[:task_id]
    task = Task.find(task_id)
    if task.name
      pattern = Pattern.create(:user_id => session[:user_id])
      pattern.full_copy(task_id)
    end
  end

  def show
    if params[:owner_patterns] == 'Users'
      @patterns = Pattern.find_all_by_user_id(session[:user_id])
    else
      @patterns = Pattern.find_all_by_user_id(0)
    end

    @patterns.each do |pattern|
      pattern.destroy unless pattern.name
    end

    @patterns.sort! { |x,y| x.id <=> y.id }
    @names_pattern = []
    @patterns.each do |pattern|
      if params[:phrase]
        @names_pattern  << { :id => pattern.id, :name => pattern.name } if pattern.name.scan(params[:phrase]).size >= 1
      else
        @names_pattern  << { :id => pattern.id, :name => pattern.name }
      end
    end
  end

  def destroy
    pattern = Pattern.find(params[:pattern_id])
    pattern.full_destroy
  end
end
