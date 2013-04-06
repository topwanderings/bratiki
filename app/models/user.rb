#coding: utf-8
class User < ActiveRecord::Base
  belongs_to :person
  attr_accessor :password_confirmation

  attr_accessible :activated,
                  :email,
                  :password,
                  :password_confirmation,
                  :type,
                  :person_id



  validates_presence_of :email, :message => "введите email"
  validates_format_of :email, :with =>  /^([a-z0-9_\-]+\.)*[a-z0-9_\-]+\@([a-z0-9][a-z0-9\-]*[a-z0-9]\.)+[a-z]{2,4}$/i

  validates_presence_of :password, :message => "введите пароль"
  validates_length_of :password, :maximum => 30, :message => "слишком длинный пароль"
  validates_length_of :password, :minimum => 5, :message => "слишком короткий пароль"
  validates_confirmation_of :password, :message => "пароли не совпадают"
  validates_format_of :password, :with =>  /^([a-z0-9\?\'\+\-\_\<\>\"\;\`\:\!\@\#\$\%\^\&\*\(\)\{\}\[\]\,\.\/\\\|])+$/i,
                      :message => "некорректный email"



  def full_name
    self.last_name + " " + self.first_name + " " + self.middle_name
  end

  def half_name
    self.last_name + ' ' + first_name[0].upcase + '.' + middle_name[0].upcase + '.'
  end

  private
  def self.authenticate(email, password)
    user = self.where(:email => email, :password => password).first
  end



end