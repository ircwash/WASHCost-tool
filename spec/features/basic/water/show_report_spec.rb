require 'spec_helper'

describe "Water Basic Report Showing" do
  context 'when a guess user access to the water basic report' do
    it 'show all water basic report' do
      import_report_data
      visit '/cal/water_basic/report'
      # -- analizing if all icons, images and backgrounds are properly configured

      # - Primary section
      # Total cost
      page.find('.primary-section .total_cost .value').text.should == 'US$ 166,800'
      page.find('.primary-section .total_cost .value').should have_content('US$ 166,800')
      # Level of service
      page.find('.primary-section .level_of_service').should have_selector('.level-start-2')
      # Benchmark icon
      page.find('.primary-section .result').should have_selector('.bench-icon-1')
      # - Context section
      # country
      page.find('.content-section.context').should have_selector('.box-report .country.icon')
      # technology
      page.find('.content-section.context').should have_selector('.box-report .water-item-1')
      # population
      page.find('.content-section.context').should have_selector('.box-report .population.icon')

      # - Cost Section
      # capital expenditure
      page.find('.content-section.cost .capital-exp .cost-box-report .value').should have_content('US $59')
      # recurrent expenditure
      page.find('.content-section.cost .recurrent-exp .cost-box-report .value').should have_content('US $8')
      # total
      page.find('.content-section.cost .total-container .total').should have_content('US $166,800.00')

      # - Service Level Section
      # header
      page.find('.content-section.service_level .distance-container .value .header').should have_content('Less than')
      # amount
      page.find('.content-section.service_level .distance-container .value .amount').should have_content('30')
      # quantity
      page.find('.content-section.service_level').should have_selector('.box-report .quantity-item-2')
      # quality
      page.find('.content-section.service_level').should have_selector('.box-report .quality-item-2')
      # reliability
      page.find('.content-section.service_level').should have_selector('.box-report .reliability-item-2')
    end

    # import the necessary data to build the complete report
    def import_report_data
      # the notation used in the backend is string instead the symbols, for this reason, the session form is created in
      # this way
      basic_water_session({
                              'country' =>  'BI',
                              'water' =>  1,
                              'population' =>  1200,
                              'capital' =>  59,
                              'recurrent' =>  8,
                              'time' =>  1,
                              'quantity' =>  2,
                              'quality' =>  2,
                              'reliability' =>  2,
                          })
    end
  end
end
