require 'csv'

namespace :db do

  desc "Seeds the database exchange rates information from an CSV file"

  task :seed_ratesex => :environment do

    puts "Clearing down exchnages\n"

    PANUSFCRF.destroy_all

    puts "Compiling...\n"

    AppRoot = File.expand_path(File.dirname(__FILE__))

    csv_text = File.read(File.join(AppRoot, "exchangerates.csv")).force_encoding("ISO-8859-1").encode("utf-8", replace: nil)

    csv = CSV.parse(csv_text, :headers => true)

    csv.each_with_index do |row, i|

      code = row[0]
      year = 1959

      (1..107).each do |n|
        year = year+1
        rate = row[n]

        PANUSFCRF.create(
          :name  => code,
          :year  => year,
          :rate  => rate
        )

        puts "#{code} -> #{year} -> #{rate}"
      end

    end

  end

end