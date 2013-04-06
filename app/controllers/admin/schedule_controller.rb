#coding: UTF-8
class Admin::ScheduleController < ApplicationController
  before_filter :check_admin
  def index

  end
  def load
    if request.post? && params[:schedule]
      loaded_io = params["schedule"]
      path = Rails.root.join('public', 'loads', loaded_io.original_filename)
      file = File.open(path, "w")

      data =  loaded_io.read

      data = data.force_encoding('UTF-8')

      file.write(data)
      file.close

      xls = Spreadsheet.open path

      xls.worksheets.each do |sheet|
        if sheet.name.to_i == 0
          next
        end
        group = Group.where(:number => sheet.name).first
        unless group
          group = Group.create(:number => sheet.name)
        end

        new_sheet = []
        sheet.each do |row|
          new_row = []
          row.each do |cell|
            new_row << cell
          end
          new_sheet << new_row
        end
        sheet = new_sheet.transpose
        2.times{sheet.shift}

        sheet.each do |row|
          6.times do
            day = row[1..4]
            date = row[0]

            5.times{row.shift}
            if date
              day.each_with_index do |pair, index|
                if pair
                  pair = pair.split(/\n/)
                  subject_name = pair[0]
                  if pair[1]
                    pair_type, place = pair[1].split(',')
                    pair_type, pair_number = pair_type.split('-')
                    if pair[2]
                      temp = pair[2].split(' ')
                      first_name, middle_name = temp[-1].split('.')
                      last_name = temp[-2]
                      teacher = find_by_half_name(last_name, first_name, middle_name)
                      unless teacher
                        teacher = Teacher.create(:last_name => last_name,
                                                :first_name => first_name,
                                                :middle_name => middle_name)

                      end
                      teacher_id = teacher.id
                      subject = Subject.where(:name => subject_name).first
                      unless subject
                        subject = Subject.create(:name => subject_name)
                      end
                      subject_id = subject.id

                      date_time = format_date_time(date, place, index)

                      pair = Pair.where(:subject_id => subject_id, :teacher_id => teacher_id, :pair_type => pair_type, :place => place, :date_time => date_time).first
                      unless pair
                        pair = Pair.create(:subject_id => subject_id,
                                           :teacher_id => teacher_id,
                                           :pair_type => pair_type,
                                           :pair_number => pair_number,
                                           :place => place,
                                           :date_time => date_time)
                      end
                      pair.groups << group

                    end
                  end
                end
              end
            end
          end
        end
      end
      redirect_to(:controller => '/admin/schedule', :action => 'index')
    end
  end

  def destroy
    Pair.delete_all
    Grade.delete_all
    redirect_to(:controller => '/admin/schedule', :action => 'index')
  end


  def format_date_time(date, place, index)
    day, month = date.split(' ')
    month = case month
              when "января"
                "1"
              when "февраля"
                "2"
              when "марта"
                "3"
              when "апреля"
                "4"
              when "мая"
                "5"
              when "июня"
                "6"
              when "июля"
                "7"
              when "августа"
                "8"
              when "сентября"
                "9"
              when "октября"
                "10"
              when "ноября"
                "11"
              when "декабря"
                "12"
            end

    if place.scan("ФИЛИАЛ").empty?
      hour, minute = case index
                       when 0
                         ["09", "00"]
                       when 1
                         ["10", "50"]
                       when 2
                         ["12", "40"]
                       when 3
                         ["15", "15"]
                     end
    else
      hour, minute = case index
                       when 0
                         ["11", "00"]
                       when 1
                         ["11", "50"]
                       when 2
                         ["14", "15"]
                       when 3
                         ["16", "05"]
                     end
    end
    date_time = day + '/' + month + ' ' + hour + ':' + minute
    date_time = DateTime.strptime(date_time, "%d/%m %H:%M")
  end

  def find_by_half_name(last_name, first_name, middle_name)
    teacher = Person.where("last_name = ? and first_name like ? and middle_name like ? ", last_name, first_name + '%', middle_name + '%').first
  end
end
