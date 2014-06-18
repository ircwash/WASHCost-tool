require 'csv'

namespace :db do

  desc "Seeds the database deflator information from an CSV file"

  task :seed_deflator => :environment do

    puts "Clearing down deflators\n"

    Deflator.destroy_all

    puts "Compiling...\n"

    AppRoot = File.expand_path(File.dirname(__FILE__))

    csv_text = File.read(File.join(AppRoot, "deflatorvalues.csv")).force_encoding("ISO-8859-1").encode("utf-8", replace: nil)

    csv = CSV.parse(csv_text, :headers => true)

    csv.each_with_index do |row, i|

      code = row[4]
      year = 1959

      (8..62).each do |n|
        year = year+1
        percent = row[n]

        Deflator.create(
          :name  => code,
          :year  => year,
          :percent  => percent
        )

        puts "#{code} -> #{year} -> #{percent}"
      end

    end

  end

end