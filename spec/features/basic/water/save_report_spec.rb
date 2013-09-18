require 'spec_helper'

include Warden::Test::Helpers

describe "Water Basic Report Saving" do
  context 'when a signed user saves a water basic report' do
    it 'save a new report', :js do
      #Warden.test_mode!
      import_report_data
      visit '/cal/water_basic/report'
      #-- loggin the test user
      user = User.find_or_create_by(first_name: 'allan', last_name: 'britto', email: 'test@test.com', password: '12345678')
      login_as(user, :scope => :user)
      #-- clicking save button
      click_link t('buttons.save_report')
      page.should have_css('.washcost-popup .reveal-modal.report.save.open')
      report_name = "test - #{Time.now}"
      fill_in('basic_questionnaire[title]', :with => report_name)
      #-- save the report
      click_button 'Save'
      # Waiting to the system render the dashboard page (process made through the windows.location function)
      sleep 1
      #expect{ click_button 'Save' }.to change{current_path}.to(dashboard_index_path)
      expect(current_path).to eq(dashboard_index_path)
      #-- Cheking if the new report is showed in a properly way into the dashboard page
      #- cheking the notice message
      page.find('.alert-box').should have_content(t('report.created_successsfully'))
      #- cheking the report name
      page.find('.dashboard .reports table .divisor').should have_content(report_name.upcase)
      #- checking the country name and flag
      page.find('.dashboard .reports table .content-report .country-flag').should have_selector('.flag-co')
      page.find('.dashboard .reports table .content-report .country-name').should have_content('COLOMBIA')
      #- checking the tool name and percent completed
      page.find('.dashboard .reports table .tool_name').should have_content('WATER |')
      page.find('.dashboard .reports table .percent').should have_content('BASIC TOOL (100%)')
      #Warden.test_reset!
    end


  end

  context 'when a user not signed saves a water basic report' do
    it 'sign in from basic tool before save the report', :js do
      import_report_data
      visit '/cal/water_basic/report'
      #-- loggin the test user
      User.find_or_create_by(first_name: 'allan', last_name: 'britto', email: 'test@test.com', password: '12345678')
      #-- clicking save button
      click_link t('buttons.save_report')
      #-- Checking if the session popup exists
      page.should have_css('.washcost-popup .reveal-modal.session-container.sign_in.open')
      #-- sign in
      within('.washcost-popup .reveal-modal.session-container.sign_in.open') do
        fill_in 'user[email]', :with => 'test@test.com'
        fill_in 'user[password]', :with => '12345678'
      end
      click_button 'Log in'
      #-- clicking save button
      click_link t('buttons.save_report')
      #-- checking if the save popup is open
      page.should have_css('.washcost-popup .reveal-modal.report.save.open')
    end
  end

  # import the data necessary to build the report
  def import_report_data
    # the notation used in the backend is string instead the symbols, for this reason, the session form is created in
    # this way
    basic_water_session({
                            'country' => 'CO',
                            'water' =>  1,
                            'population' =>  1200,
                            'capital' =>  59,
                            'recurrent' =>  8,
                            'time' =>  1,
                            'quantity' =>  2,
                            'quality' =>  2,
                            'reliability' =>  2,
                        })
    basic_water_percent_completed(9)
  end
end
