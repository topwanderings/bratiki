#coding: utf-8
class User::RegisterController < ApplicationController
  def step0
    if request.post?
      if params[:role_id] == "1"
        redirect_to :controller => '/teacher/register', :action => 'step1'
      elsif params[:role_id] == "2"
        redirect_to :controller => '/student/register', :action => 'step1'
      elsif params[:role_id] == "3"
        redirect_to :controller => '/chief/register', :action => 'step1'
      end
    end
  end
end