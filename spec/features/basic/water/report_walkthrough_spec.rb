require 'spec_helper'

describe "Basic Tool Walkthrough" do
  context 'when a guest user uses the calculator' do

    it 'starts the calculator' do
      start_calculator :water, :basic
      current_path.should == cal_water_basic_path
    end

    it 'selects the country' do
      visit cal_water_basic_path
      select 'COLOMBIA', from: 'country'
      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/water'
      basic_water[:country].should == "CO"
    end

    it 'selects the main water supply technology' do
      visit '/cal/water_basic/water'
      choose 'mixedPipe'
      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/population'
      basic_water[:water].should == 4
    end

    it 'selects the population', :js  do
      visit '/cal/water_basic/population'

      slider_handle = page.find('.ui-slider-handle')
      # test_cursor is located into the half of slider
      test_cursor = page.find('.slider-container .test-cursor')
      slider_handle.drag_to(test_cursor)

      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/capital'
      basic_water[:population].should == 10000
    end

    it 'selects the capital expenditure', :js do
      visit '/cal/water_basic/capital'

      # verifying the labels above and below of capital slider
      # below value when water is borehole
      below_value = '20'
      page.find('.labelScale .first span').text.should == "US$ #{below_value}"
      # above value when water is borehole
      above_value = '61'
      page.find('.labelScale .last span').text.should == "US$ #{above_value}"

      slider_handle = page.find('.ui-slider-handle')
      # test_cursor is located into the half of slider
      test_cursor = page.find('.slider-container .test-cursor')
      slider_handle.drag_to(test_cursor)

      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/recurrent'
      basic_water[:capital].should == 150
    end

    it 'selects the recurrent expenditure', :js do
      visit '/cal/water_basic/recurrent'

      # verifying the labels above and below of capital slider
      # below value when water is borehole
      below_value = '3'
      page.find('.labelScale .first span').text.should == "US$ #{below_value}"
      # above value when water is borehole
      above_value = '6'
      page.find('.labelScale .last span').text.should == "US$ #{above_value}"

      slider_handle = page.find('.ui-slider-handle')
      # test_cursor is located into the half of slider
      test_cursor = page.find('.slider-container .test-cursor')
      slider_handle.drag_to(test_cursor)

      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/time'
      basic_water[:recurrent].should == 15
    end

    it 'selects the access time to collect water per day ', :js do
      visit '/cal/water_basic/time'

      slider_handle = page.find('.ui-slider-handle')
      # test_cursor is located into the half of slider
      test_cursor = page.find('.slider-container .test-cursor')
      slider_handle.drag_to(test_cursor)

      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/quantity'
      basic_water[:time].should == 2
    end

    it 'selects the water quantity used in litres per person per day' do
      visit '/cal/water_basic/quantity'
      choose 'waterFromTwenty'
      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/quality'
      basic_water[:quantity].should == 2
    end

    it 'selects the test type of quality water' do
      visit '/cal/water_basic/quality'
      choose 'occasional'
      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/reliability'
      basic_water[:quality].should == 1
    end

    it 'selects how reliable is the water service' do
      visit '/cal/water_basic/reliability'
      choose 'worksMostly'
      click_button 'Complete'
      current_path.should == '/cal/water_basic/report'
      basic_water[:reliability].should == 1
    end

    # a more semantic approach to naming the session
    # could be named "report" too
    def basic_water
      basic_water_session
    end

    # click one of the typical boxes in the UI when selecting icons
    # @param label_name [String] the actual "class" for the label icon image
    # e.g. boreHold_03, waterTool << css class names
    def pick_box(label_name)
      find("label.#{label_name}").click
    end

  end

end
