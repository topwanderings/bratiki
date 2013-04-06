#coding: utf-8
class User::LoginController < ApplicationController
  before_filter :check_of_existence_administrator
  def login
    session[:user_id] = nil
    if request.post?
      if request.xhr?
        if params[:email] == ""
          render 'login', :locals => {:error => "true", :type => 'User', :message => 'empty_email'}
        elsif !User.find_by_email(params[:email])
          render 'login', :locals => {:error => "true", :type => 'User', :message => 'wrong_email'}
        elsif params[:password] == ""
          render 'login', :locals => {:error => "true", :type => 'User', :message => 'empty_password'}
        else
          user = User.authenticate(params[:email].downcase, params[:password])
          if user
            if user.type != "UAdmin"
              if user.activated?
                session[:user_id] = user.id
                if user.type == "UTeacher"
                  render 'login', :locals => {:error => "false", :type => "Teacher", :message => ''}
                elsif user.type == "UStudent"
                  render 'login', :locals => {:error => "false", :type => "Student", :message => ''}
                elsif user.type == "UChief"
                  render 'login', :locals => {:error => "false", :type => "Chief", :message => ''}
                end
              else
                render 'login', :locals => {:error => "true", :type => "User", :message => 'user_not_actived'}
              end
            else
              session[:user_id] = user.id
              render 'login', :locals => {:error => "false", :type => "Admin", :message => ''}
            end
          else
            render 'login', :locals => {:error => "true", :type => "User", :message => 'wrong_password'}
          end
        end
      else
        if params[:email] == ""
          flash.now[:email] = "введите email"
        elsif !User.find_by_email(params[:email])
          flash.now[:email] = "неверный email"
        elsif params[:password] == ""
          flash.now[:password] = "введите пароль"
        else
          user = User.authenticate(params[:email].downcase, params[:password])
          if user
            if user.type != "UAdmin"
              if user.activated?
                session[:user_id] = user.id
                if user.type == "UTeacher"
                  redirect_to :controller => "/teacher", :action => "home"
                elsif user.type == "UStudent"
                  redirect_to :controller => '/student', :action => 'home'
                end
              else
                flash.now[:email] = "пользователь с таким email не активирован"
              end
            else
              session[:user_id] = user.id
              redirect_to :controller => "/admin", :action => "home"
            end
          else
            flash.now[:password] = "неверный пароль"
          end
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :controller => "/user/login", :action => "login"
  end

  def authorize
    unless User.find_by_email(params[:email].downcase)
      render :text => "email_not_found"
    else
      if params[:password].empty?
        render :text => "not_password"
      else
        user = User.authenticate(params[:email].downcase, params[:password])
        unless user
          render :text => "wrong_password"
        else
          user = User.find_by_email(params[:email])
          if user.activated? || user.type == "Admin"
            render :text => "true"
          else
            render :text => "not_actived"
          end
        end
      end
    end
  end

end
