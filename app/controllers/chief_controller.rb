class ChiefController < ApplicationController
  before_filter :check_chief
  def home
    day, month, year = Time.now.day, Time.now.month, Time.now.year
    @date = DateTime.new(year, month, day)
    @groups = User.find(session[:user_id]).person.course.groups
  end

  def calendar
    @groups = User.find(session[:user_id]).person.course.groups
    @cases = Array.new
    if params[:group_id]
      @group = Group.find(params[:group_id])
    else
      @group = User.find(session[:user_id]).person.course.groups.first
    end
      @pairs = @group.pairs
    for pair in @pairs do
      _case = Case.new(:title => pair.subject.name, :date_time => pair.date_time, :pair_id => pair.id, :note => "\r" + pair.subject.name + "\r\n" + pair.pair_type + "\r\n" + pair.teacher.half_name + "\r\n" + pair.place + "\r\n" + pair.date_time.strftime("%H:%M"))
      @cases << _case
     end
    @date = params[:month] ? Date.strptime(params[:year].to_s + '-' + params[:month].to_s,"%Y-%m") : Date.today
    @cases = @cases.sort {|a, b| a.date_time <=> b.date_time}
  end
end
