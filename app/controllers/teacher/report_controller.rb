#encoding: UTF-8
class Teacher::ReportController < ApplicationController
  before_filter :check_teacher
  def index
    if request.post?
      document = Document.find(params[:document_id])
      pdf = Prawn::Document.new do
        font("app/assets/fonts/verdana.ttf")

        text_box "Начальнику 4-ого курса\nФИБ ИКСИ\nподполковнику\nБондаренко В.А.",
                 :at => [420,700]
        move_down 200
        text "Рапорт", :align => :center

        move_down 20
        text "Прошу Вас делать то-то по причине того-то и потумо что я такой то сделал то-то в такое время.", :align => :justify,:indent_paragraphs => 20
        move_down 20
        text "Слушатель гр. 7345\nрядовой Вершинин В.В."
        move_down 20
        text "Дата"
        text "Роспись"
      end.render

      send_data(pdf, :filename => "report.pdf", :type => "application/pdf")
    end
  end
end
