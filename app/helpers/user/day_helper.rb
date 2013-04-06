#coding: UTF-8
module User::DayHelper
  def format_date(date)
    str = date.strftime("%d.%B.%Y")
    array = str.split('.')
    day = array[0]
    month = array[1]
    year = array[2]
    month = case month
              when "January" then
                "Января"
              when "February" then
                "Февраля"
              when "March" then
                "Марта"
              when "April" then
                "Апреля"
              when "May" then
                "Мая"
              when "June" then
                "Июня"
              when "July" then
                "Июля"
              when "August" then
                "Августа"
              when "September" then
                "Сенятбря"
              when "October" then
                "Октября"
              when "November" then
                "Ноября"
              when "December" then
                "Декабря"

            end
    date = day + " " + month + " " + year
  end  
end
