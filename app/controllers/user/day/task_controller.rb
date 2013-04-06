class User::Day::TaskController < ApplicationController
  def index
    @date1 =  Time.new(params[:year], params[:month], params[:day], 0, 0, 0, 0)
    @date2 = @date1 + 1.day
    @tasks = Task.where(:date_time => @date1..@date2)
  end

  def new
    if request.post?
      year = params[:year]
      month = params[:month]
      day = params[:day]
      hour = params[:date_time]["(4i)"].to_i
      minute = params[:date_time]["(5i)"].to_i
      date_time = Time.new(year, month, day, hour, minute, 0, 0)
      task = Task.new(:title => params[:title], :note => params[:note], :date_time => date_time, :user_id => session[:user_id])
      if task.save
        redirect_to({:controller => '/user/day/task', :action => 'index', :day => params[:day], :month => params[:month], :year => params[:year]})
      else
        task.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def edit
    @task = ActiveRecord::Base::Task.find(params[:task_id])
    if request.post?
      year = params[:year]
      month = params[:month]
      day = params[:day]
      hour = params[:date][:hour]
      minute = params[:date][:minute]
      date_time = Time.new(year, month, day, hour, minute, 0, 0)
      if @task.update_attributes(:title => params[:title], :note => params[:note], :date_time => date_time)
        redirect_to({:controller => '/user/day/task', :action => 'index', :day => params[:day], :month => params[:month], :year => params[:year]})
      else
        @task.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def destroy
    task = Task.find(params[:task_id])
    task.destroy
    redirect_to({:controller => '/user/day/task', :action => 'index', :day => params[:day], :month => params[:month], :year => params[:year]})
  end

  def show
  end
end
