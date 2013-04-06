class User::Day::PairController < ApplicationController
  def index
    @date1 =  Time.new(params[:year], params[:month], params[:day], 0, 0, 0, 0)
    @date2 = @date1 + 1.day
    @pairs = Pair.where(:date_time => @date1..@date2, :user_id => session[:user_id])
  end

  def new
    if request.post?
      year = params[:year]
      month = params[:month]
      day = params[:day]
      hour = params[:date_time]["(4i)"].to_i
      minute = params[:date_time]["(5i)"].to_i
      date_time = Time.new(year, month, day, hour, minute, 0, 0)
      teacher = User.find(session[:user_id]).last_name_with_initials

      pair = Pair.new(:object => params[:object], :kind => params[:kind], :teacher => teacher, :date_time => date_time, :place => params[:place], :group => params[:group])
      if pair.save
        redirect_to({:controller => '/user/day', :action => 'index', :day => params[:day], :month => params[:month], :year => params[:year]})
      else
        pair.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def edit
    @pair = Pair.find(params[:pair_id])
    @groups = @pair.groups
    if request.post?
      year = params[:date][:year]
      month = params[:date][:month]
      day = params[:date][:day]
      hour = params[:date][:hour]
      minute = params[:date][:minute]
      date_time = Time.new(year, month, day, hour, minute, 0, 0)
      if @pair.update_attributes(:subject_id => params[:subject], :pair_type => params[:pair_type], :place => params[:place], :date_time => date_time)
        @pair.groups.clear
        params[:groups].each do |group_id|
          @pair.groups << Group.find(group_id)
        end
        redirect_to({:controller => '/user/day', :action => 'index', :day => params[:day], :month => params[:month], :year => params[:year]})
      else
        @pair.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def destroy
    pair = Pair.find(params[:pair_id])
    pair.destroy
    redirect_to({:controller => '/user/day', :action => 'index', :day => params[:day], :month => params[:month], :year => params[:year]})
  end

  def show
  end
end
