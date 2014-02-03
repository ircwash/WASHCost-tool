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
      puts "#{currency}"

      response = HTTParty.get( "http://api.worldbank.org/countries/#{country}/indicators/PA.NUS.FCRF", {} )

      if response.parsed_response && response.parsed_response[ 'data' ] && response.parsed_response[ 'data' ][ 'data' ]
        currency = ExchangeRate.create(
          :name  => currency,
          :rates => Hash[ response.parsed_response[ 'data' ][ 'data' ].map{ |fx| [ fx[ 'date' ].to_i, fx[ 'value' ].to_f ] } ]
        )
      end
    end

  end

end