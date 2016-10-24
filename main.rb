require "erb"
require 'date'

class LawPrint
  attr_accessor :stylesheet, :data, :date

  def initialize file=File.dirname(__FILE__)+"/default.txt"
    read_data_from file
    @date = Date.today
    @stylesheet = rout "/assets/main.css"
    create_html
  end

  def read_data_from file
    data = File.readlines file
    @data = { :town => data[0],
              :seller => data[1],
              :buyer => data[2],
              :price => data[3],
              :specifications => data[4]}
  end

  def create_html
    view = File.open(rout("/public/law.html"), "w+")
    view.puts ERB.new(File.read(rout "/view_blank/print.html.erb")).result binding
  end

  def html
    spawn("google-chrome #{rout "/public/law.html"}")
  end

  private
    def rout short_url
      File.dirname(__FILE__)+short_url
    end
end

LawPrint.new().html
