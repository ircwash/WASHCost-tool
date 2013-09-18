require 'spec_helper'

include Warden::Test::Helpers


describe "Water Basic Report Saving" do
  context 'when a signed user saves the water basic report' do
    it 'save a new report', :js do
      Warden.test_mode!
      report_data
      visit '/cal/water_basic/report'
      #loggin the test user
      user = User.find_or_create_by(first_name: 'allan', last_name: 'britto', email: 'test@test.com', password: '12345678')
      login_as(user, :scope => :user)
      ap page.find('body').text
      # clicking save button
      click_link t('buttons.save_report')
      page.should have_css('.washcost-popup .reveal-modal.report.save.open')
      name_report = "test - #{Time.now}"
      fill_in('basic_questionnaire[title]', :with => name_report)
      click_button 'Save'
      ap current_path
      ap user
      ap user.basic_questionnaires
      Warden.test_reset!
    end

    # a more semantic approach to naming the session
    def report_data
      # the notation used in the backend is string instead the symbols, for this reason, the session form is created in
      # this way
      basic_water_session({
                            'country' => 'BI',
                            'water' =>  1,
                            'population' =>  1200,
                            'capital' =>  59,
                            'recurrent' =>  8,
                            'time' =>  1,
                            'quantity' =>  2,
                            'quality' =>  2,
                            'reliability' =>  2,
                         })
      #basic_water_percent_completed(9)
      ap basic_water_session
      ap basic_water_percent_completed
      basic_water_session
    end
  end
end
