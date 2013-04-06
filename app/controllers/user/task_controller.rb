class User::TaskController < ApplicationController
  def index
  end

  def new
    if request.post?
      year = params[:date_time]["(1i)"].to_i
      month = params[:date_time]["(2i)"].to_i
      day = params[:date_time]["(3i)"].to_i
      hour = params[:date_time]["(4i)"].to_i
      minute = params[:date_time]["(5i)"].to_i
      date_time = Time.new(year, month, day, hour, minute, 0, 0)
      task = Task.new(:title => params[:title], :note => params[:note], :date_time => date_time, :user_id => session[:user_id])
      if task.save
        redirect_to(:controller => '/user', :action => 'calendar')
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
      year = params[:date][:year]
      month = params[:date][:month]
      day = params[:date][:day]
      hour = params[:date][:hour]
      minute = params[:date][:minute]
      date_time = Time.new(year, month, day, hour, minute, 0, 0)
      if @task.update_attributes(:title => params[:title], :note => params[:note], :date_time => date_time)
        redirect_to(:controller => '/user', :action => 'calendar')
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
    redirect_to(:controller => '/user', :action => 'calendar')
  end

  def show
  end
end
