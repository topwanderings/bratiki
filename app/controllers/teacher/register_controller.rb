#coding: utf-8
class Teacher::RegisterController < ApplicationController
  def step1
    if request.post?
      session[:teacher] = UTeacher.new
      session[:email] = params[:email].downcase
      session[:password] = params[:password]
      session[:password_confirmation] = params[:password_confirmation]
      if request.xhr?
        (validate_step1_xhr?)? (render "step1_to_step2"): (render :text => "error")
      else   
        (validate_step1_no_xhr?)? (render "step2"): (render "step1")
      end
    else
      clear_session
    end
  end

  def step2
    unless request.post? && session[:teacher]
      redirect_to :action => "step1"
    else
      session[:last_name] = params[:last_name]
      session[:first_name] = params[:first_name]
      session[:middle_name] = params[:middle_name]
      session[:sex_id] = params[:sex_id]
      if request.xhr?
        if params[:commit] == "Далее" 
          if(validate_step2_xhr?)
            render "step2_to_step3"
          else
            render :text => "error"
          end
        elsif params[:commit] == "Назад"
          render "step2_to_step1"
        elsif params[:commit] == "Завершить"
          if (validate_step2_xhr?)
            render "step2_to_step4"#, :locals => {:is_admin => false}
            save_teacher_on_step2
          else
            render :text => "error"
          end
        end
      else
        if params[:commit] == "Далее" 
          (validate_step2_no_xhr?)? (render "step3"): (render "step2")
        elsif params[:commit] == "Назад"
          render "step1"
        elsif params[:commit] == "Завершить"
          if(validate_step2_no_xhr?)
            render "step4"#, :locals => {:is_admin => false}
            save_teacher_on_step2
          else
            render "step2"
          end
        end
      end
    end
  end



  def step3
    unless request.post? && session[:teacher]
      redirect_to :action => "step1"
    else
      session[:telephone] = params[:telephone]
      session[:room] = params[:room]
      session[:post_id] = params[:post]
      session[:military_rank_id] = params[:military_rank]
      session[:scientific_rank_id] = params[:scientific_rank]
      session[:scientific_degree_id] = params[:scientific_degree]
      session[:chair_id] = params[:chair]
      session[:faculty_id] = params[:faculty]
      if request.xhr?
        if params[:commit] == "Назад"
          render "step3_to_step2"
        elsif params[:commit] == "Завершить"
          if (validate_step3_xhr?)
            
            render "step3_to_step4"#, :locals => {:is_admin => false}

            save_teacher_on_step3
          else
            render :text => "error"
          end
        end
      else
        if params[:commit] == "Назад"
          render "step2"
        elsif params[:commit] == "Завершить"
          if (validate_step3_no_xhr?)
            render "step4"#, :locals => {:is_admin => false}
            save_teacher_on_step3
          else
            render "step3"
          end
        end
      end
    end
  end

  def step4

  end


  def update_chair_select
    session[:chair_id] = nil
    if params[:id] == "0"
      render(:partial => "chair", :locals => {:chairs => Chair.all})
    else
      chairs = Faculty.find(params[:id]).chairs
      chairs = Chair.all if chairs.empty?
      render(:partial => "chair", :locals => {:chairs => chairs})
    end    
  end

  def validate_uniqueness_email
    if User.find_by_email(params[:email])
      render :text => "false"
    else
      render :text => "true"
    end
  end


  def clear_session
    session[:email] = session[:password] = session[:password_confirmation] = session[:last_name] = session[:first_name] = session[:middle_name] = session[:sex_id] = session[:telephone] = session[:room] = session[:faculty_id] = session[:chair_id] = session[:military_rank_id] = session[:post_id] = session[:scientific_rank_id] = session[:scientific_degree_id] = nil
  end

  def validate_step1?
    session[:password] == session[:password_confirmation] &&
    session[:password] =~ /^([a-z0-9\?\'\+\-\_\<\>\"\;\`\:\!\@\#\$\%\^\&\*\(\)\{\}\[\]\,\.\/\\\|])+$/i &&
    session[:password].length >= 5 &&
    session[:password].length <= 30 &&
    password_strength(session[:password]) > 3 &&
    session[:email] =~ /^([a-z0-9_\-\.]+\@([a-z0-9_\-\.])+\.([a-z]{2,4}))$/i &&
    session[:email] != "" &&
    session[:password] != "" &&
    UTeacher.find_by_email(session[:email]) == nil
  end

  def password_strength(password)
    strength = 0;
    password = password.split(//)
    digits = '1234567890'.split(//);
    lwr = 'abcdefghijklmnopqrstuvwxyz'.split(//);
    upr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(//);
    spec_symbols = "?'+-_<>\";`:!@\#$%^&*(){}[],./\\|".split(//);
    for symbol in password
      if digits.include?(symbol)
        strength = strength + 1;
        break;
      end
    end
    for symbol in password
      if lwr.include?(symbol)
        strength = strength + 1;
        break;
      end
    end
    for symbol in password
      if upr.include?(symbol)
        strength = strength + 1;
        break;
      end
    end
    for symbol in password
      if spec_symbols.include?(symbol)
        strength = strength + 1;
        break;
      end
    end
    if password.length > 7
      strength = strength + 1;
    end
    return strength;
  end

  def validate_step1_xhr?
    validate_step1?
  end

  def validate_step1_no_xhr?
    unless validate_step1?
      if session[:email] == ""
        flash.now[:email] = "введите email"
      elsif params[:email] !~ /^([a-z0-9_\-\.]+\@([a-z0-9_\-\.])+\.([a-z]{2,4}))$/i
        flash.now[:email] = "некорректный email"
      elsif  Teacher.find_by_email(session[:email]) != nil
        flash.now[:email] = "пользователь с таким email уже зарегистрирован"
      end       
      if session[:password] == ""
        flash.now[:password] = "введите пароль"
      elsif session[:password].length < 5
        flash.now[:password] = "пароль слишком короткий"
      elsif session[:password].length > 30
        flash.now[:password] = "пароль слишком длинный"
      elsif session[:password] !~ /^([a-z0-9\?\'\+\-\_\<\>\"\;\`\:\!\@\#\$\%\^\&\*\(\)\{\}\[\]\,\.\/\\\|])+$/i
        flash.now[:password] = "пароль должен состоять только из латинских букв, цифр и спец-символов: ?'+-_<>\";`:!@\#$%^&*(){}[],./\\| "
      elsif password_strength(session[:password]) <= 3
        flash.now[:password] = "слабый пароль"
      elsif session[:password_confirmation] == ""
        flash.now[:password_confirmation] = "подтвердите пароль"
      elsif session[:password_confirmation] != session[:password]
        flash.now[:password_confirmation] = "пароли не совпадают"
      end
      return false
    end
    return true
  end

  def validate_step2?
    session[:last_name] != "" &&
    session[:middle_name] != "" &&
    session[:first_name] != "" &&
    session[:last_name] =~ /^([а-я])+$/i &&
    session[:middle_name] =~ /^([а-я])+$/i &&
    session[:first_name] =~ /^([а-я])+$/i
  end

  def validate_step2_xhr?
    validate_step2?
  end

  def validate_step2_no_xhr?
    unless validate_step2?
      if session[:last_name] == ""
        flash.now[:last_name] = "введите фамилию"
      elsif session[:last_name] !~ /^([а-я])+$/i
        flash.now[:last_name] = "фамилия введена некорректно"
      end
      if session[:first_name] == ""
        flash.now[:first_name] = "введите имя"
      elsif session[:first_name] !~ /^([а-я])+$/i
        flash.now[:first_name] = "имя введено некорректно"
      end
      if session[:middle_name] == ""
        flash.now[:middle_name] = "введите отчество"
      elsif session[:middle_name] !~ /^([а-я])+$/i
        flash.now[:middle_name] = "отчество введено некорректно"
      end
      return false
    end
    return true
  end

  def validate_step3?
    session[:telephone] == "" || session[:telephone] =~ /^[0-9]{11}$/
  end

  def validate_step3_xhr?
    validate_step3?
  end

  def validate_step3_no_xhr?
    unless validate_step3?
      flash.now[:telephone] = "некорректный номер телефона"
      return false
    end
    return true
  end

  def save_teacher_on_step2
    person = find_by_half_name(session[:last_name], session[:first_name][0], session[:middle_name][0])
    if person
      person.update_attributes(:last_name => session[:last_name],
                               :first_name => session[:first_name],
                               :middle_name => session[:middle_name],
                               :sex_id => session[:sex])

    else
      person = Person.create(:last_name => session[:last_name],
                             :first_name => session[:first_name],
                             :middle_name => session[:middle_name],
                             :sex_id => session[:sex_id],
                             :type => 'Teacher')
    end
    UTeacher.create(:email => session[:email],
                   :password => session[:password],
                   :password_confirmation => session[:password_confirmation],
                   :person_id => person.id)
    clear_session
    session[:teacher] = nil
  end

  def save_teacher_on_step3
    person = find_by_half_name(session[:last_name], session[:first_name], session[:middle_name])
    if person
      person.update_attributes(:last_name => session[:last_name],
                               :first_name => session[:first_name],
                               :middle_name => session[:middle_name],
                               :sex_id => session[:sex_id],
                               :chair_id => session[:chair],
                               :military_rank_id => session[:military_rank],
                               :scientific_rank_id => session[:scientific_rank],
                               :scientific_degree_id => session[:scientific_degree],
                               :post_id => session[:post],
                               :telephone => session[:telephone],
                               :room => session[:room])
    else
      person = Person.create(:last_name => session[:last_name],
                             :first_name => session[:first_name],
                             :middle_name => session[:middle_name],
                             :sex_id => session[:sex_id],
                             :chair_id => session[:chair],
                             :military_rank_id => session[:military_rank],
                             :scientific_rank_id => session[:scientific_rank],
                             :scientific_degree_id => session[:scientific_degree],
                             :post_id => session[:post],
                             :telephone => session[:telephone],
                             :room => session[:room],
                             :type => 'Teacher')
    end
    UTeacher.create(:email => session[:email],
                   :password => session[:password],
                   :password_confirmation => session[:password_confirmation],
                   :person_id => person.id)
    clear_session
    session[:teacher] = nil
  end

  def find_by_half_name(last_name, first_name, middle_name)
    Teacher.where("last_name = ? and first_name like ? and middle_name like ? ", last_name, first_name + '%', middle_name + '%').first
  end

end

