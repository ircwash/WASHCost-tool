namespace :db do

  desc "Seeds the database with World Bank currency exchange rates for all currencies from 1960"

  task :seed_rates => :environment do

    puts "Clearing down existing rates\n"

    ExchangeRate.destroy_all

    puts "Compiling currencies...\n"

    Country.all.map do |c|
      country = Country.new( c[1].upcase )

      [ country.alpha3, country.currency[ :code ] ] unless country.data == nil || country.currency == nil
    end.compact.uniq{ |c| c[1] }.each do |country, currency|

      response = HTTParty.get( "http://api.worldbank.org/countries/#{country}/indicators/pa.nus.fcrf?format=json&date=2011", {} )

      if response.parsed_response != nil && response.parsed_response.count > 1 && response.parsed_response[1] != nil && response.parsed_response[1].count > 0
        fx = response.parsed_response[1][0]

        if fx[ 'date' ].to_i == 2011 && fx[ 'value' ] != nil
          exchange_rate = ExchangeRate.create(
            :name  => currency,
            :year  => fx[ 'date' ].to_i,
            :rate  => fx[ 'value' ].to_f
          )

          puts "#{currency} -> #{fx[ 'value' ]}"
        end
      end
    end

  end

end