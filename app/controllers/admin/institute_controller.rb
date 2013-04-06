class Admin::InstituteController < ApplicationController
  before_filter :check_admin
  def new
    if request.post?
      institute = ActiveRecord::Base::Institute.new(:name => params[:name])
      if institute.save
        redirect_to :controller => 'admin/institute', :action => 'index'
      else
        institute.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end

  def destroy
    institute = ActiveRecord::Base::Institute.find(params[:institute_id])
    institute.destroy
    redirect_to :controller => "/admin/institute", :action => "index"
  end

  def show
    @institute = ActiveRecord::Base::Institute.find(params[:institute_id])
  end

  def index
    @institutes = ActiveRecord::Base::Institute.all
  end

  def edit
    @institute = ActiveRecord::Base::Institute.find(params[:institute_id])
    if request.post?
      if @institute.update_attributes(:name => params[:name])
        redirect_to :controller => 'admin/institute', :action => 'index'
      else
        @institute.errors.each do |attr, error|
          flash[attr] = error
        end
      end
    end
  end
end

