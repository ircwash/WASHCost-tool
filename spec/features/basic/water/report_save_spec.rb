require 'spec_helper'

describe "Water Basic Report Saving" do
  context 'when a signed user saves the water basic report' do
    it 'save a new report' do
      basic_water = basic_water_questionnaire_completed
      visit '/cal/water_basic/report'
      # analizing if all image and backgrouns are properly configured
      # country
      page.should have_css('bodyr')
    end

    # a more semantic approach to naming the session
    # could be named "report" too
    def basic_water_questionnaire_completed
      basic_water_session({
                            country: 'BI',
                            water: 1,
                            population: 1200,
                            capital: 59,
                            recurrent: 8,
                            time: 1,
                            quantity: 2,
                            quality: 2,
                            reliability: 2,
                         })
      basic_water_session
    end
  end
end
