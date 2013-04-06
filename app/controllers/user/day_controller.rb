class User::DayController < ApplicationController
  def index
    @last_name_with_initials = User.find(session[:user_id]).last_name_with_initials
    flash[:back] = request.url
    if params[:day] && params[:month] && params[:year]
      @date = sprintf("%d.%d.%d", params[:day], params[:month], params[:year])
      @date1 = @date.to_date
      @date2 = @date1 + 1
      @pairs = Pair.where(:teacher => @last_name_with_initials, :date_time => @date1..@date2)
      @tasks = Task.where(:user_id => session[:user_id], :date_time => @date1..@date2)
    end
  end
end
