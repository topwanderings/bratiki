class AdminController < ApplicationController
  before_filter :check_of_existence_administrator
  def home
    @users = User.where(:activated => nil).all
  end
end
