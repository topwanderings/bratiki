class User::PairController < ApplicationController
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
      teacher = User.find(session[:user_id]).last_name_with_initials

      pair = Pair.new(:object => params[:object], :kind => params[:kind], :teacher => teacher, :date_time => date_time, :place => params[:place], :group => params[:group])
      if pair.save
        path = (flash[:back])? (flash[:back]): ({:controller => '/user', :action => 'calendar'})
        redirect_to(path)
      else
        pair.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def edit
    @pair = Pair.find(params[:pair_id])
    if request.post?
      if @pair.update_attributes(:object => params[:object], :kind => params[:kind], :place => params[:place], :group => params[:group])
        path = (flash[:back])? (flash[:back]): ({:controller => '/user', :action => 'calendar'})
        redirect_to(path)
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
    path = (flash[:back])? (flash[:back]): ({:controller => '/user', :action => 'calendar'})
    redirect_to(path)
  end

  def show
  end
end
