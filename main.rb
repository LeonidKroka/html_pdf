require 'date'
require (File.dirname(__FILE__)+'/view_blank/create_pdf')
include PDF

class LawPrint
  def initialize file=File.dirname(__FILE__)+"/default.txt"
    read_data_from file
    @data[:date] = Date.today
    @stylesheet = rout "/assets/main.css"
    create_pdf link, @data
    view_pdf
  end

  def read_data_from file
    data = File.readlines file
    @data = { :town => data[0].delete!("\n"),
              :seller => data[1].delete!("\n"),
              :buyer => data[2].delete!("\n"),
              :price => data[3].delete!("\n"),
              :specifications => data[4].delete!("\n")}
  end

  def view_pdf
    spawn("xdg-open #{rout "/public/law.pdf"}")
  end

  private
    def rout short_url
      File.dirname(__FILE__)+short_url
    end

    def link
      { :bold => (rout "/assets/font/TimesNewRomanBold.ttf"),
        :normal  => (rout "/assets/font/TimesNewRomanRegular.ttf") }
    end
end

LawPrint.new()
