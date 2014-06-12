require "rexml/document"

namespace :db do

  desc "Populates the Deflator collection from an XML file (pulled from: http://data.worldbank.org/indicator/NY.GDP.DEFL.KD.ZG)"

  task :seed_gdp => :environment do

    puts "Clearing down existing gdp\n"

    Deflator.destroy_all

    file = File.join(File.dirname(__FILE__), "2014gdpnumbers.xml")

    xml = File.read(file)
    doc = REXML::Document.new(xml)
    root = doc.root

    root.elements['data'].elements.each do |record|
      name = nil
      year = nil
      gdp = nil
      record.elements.each do |field|
        if field.attribute('name').to_s === 'Country or Area'
          name = field.attribute('key')
        end
        if field.attribute('name').to_s === 'Year'
          year = field.text.to_i
        end
        if field.attribute('name').to_s === 'Value'
          gdp = field.text != nil ? field.text.to_f : 0
        end
      end
      Deflator.create(
        :name  => name,
        :year  => year,
        :gdp  => gdp
      )
    end

    puts "completed"

  end

end