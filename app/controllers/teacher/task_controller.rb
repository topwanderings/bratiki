class Teacher::TaskController < ApplicationController
  before_filter :check_teacher
  def index
    @tasks = Mission.find_all_by_user_id(session[:user_id])
    @tasks.each do |task|
      task.destroy unless task.name
    end
    @tasks = Mission.find_all_by_user_id(session[:user_id])
    @tasks.sort! { |x,y| x.id <=> y.id }
    if params[:owner_patterns] == 'Users'
      @patterns = Pattern.find_all_by_user_id(session[:user_id])
    else
      @patterns = Pattern.find_all_by_user_id(0)
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

  def show
    respond_to do |format|
      format.html do
        task_id = params[:task_id]
        @task = Task.find(task_id)
        @parent_names = @task.parent_names
        @parent_names.sort! { |x,y| x[:id] <=> y[:id] }
        @sub_tasks = Task.find_all_by_task_id(task_id)
        @sub_tasks.each do |task|
          task.destroy unless task.name
        end
        @sub_tasks.sort! { |x,y| x.id <=> y.id }
        @parameters = Parameter.find_all_by_task_id(task_id)
        @parameters.sort! { |x,y| x.id <=> y.id }
        render :action => 'show'
      end
    end
  end

  def management
    task_id = params[:task_id]
    @task = Task.find(task_id)
    @parameters = Parameter.find_all_by_task_id(task_id)
    @parameters.sort! { |x,y| x.id <=> y.id }
    @tasks = Task.find_all_by_user_id(session[:user_id])
    @patterns = Pattern.find_all_by_user_id(session[:user_id])
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

  def add
    if params[:parent_task_id].to_i != 0
      @task = SubMission.create(:user_id => session[:user_id], :task_id => params[:parent_task_id], :status => false)
    else
      @task = Mission.create(:user_id => session[:user_id], :status => false)
    end
    Parameter.create(:task_id => @task.id, :name => t('parameter.name'))
    respond_to do |format|
      format.js{ render :action => 'add' }
    end
  end

  def copy
    if(params[:parent_task_id])
      task = SubMission.create(:user_id => session[:user_id], :task_id => params[:parent_task_id], :status => false)
      task.full_copy(params[:task_id])
    else
      task = Mission.create(:user_id => session[:user_id], :status => false)
      task.full_copy(params[:task_id])
    end
    Parameter.create(:task_id => task.id, :name => t('parameter.name'), :value => task.value)
  end

  def edit
    respond_to do |format|
      task = Task.find(params[:task_id])
      format.js do
        if params[:name]
          task.update_attributes(:name => params[:name])
          parameter_name = Parameter.where(:task_id => task.id, :name => t('parameter.name')).first
          parameter_name.update_attributes(:value => params[:name])
        end
        task.revers_status if params[:revers_status]
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        task = Task.find(params[:task_id])
        task.full_destroy if task
      end
    end
  end

end
