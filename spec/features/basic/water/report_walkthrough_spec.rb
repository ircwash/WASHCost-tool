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
      page.find('.labelScale .first span').text.should == below_value
      # above value when water is borehole
      above_value = '61'
      page.find('.labelScale .last span').text.should == above_value

      slider_handle = page.find('.ui-slider-handle')
      test_cursor = page.find('.slider-container .test-cursor')
      slider_handle.drag_to(test_cursor)

      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/recurrent'
      basic_water[:capital].should == 50
    end

    it 'selects the recurrent expenditure', :js do
      visit '/cal/water_basic/recurrent'

      # verifying the labels above and below of capital slider
      # below value when water is borehole
      below_value = '3'
      page.find('.labelScale .first span').text.should == below_value
      # above value when water is borehole
      above_value = '6'
      page.find('.labelScale .last span').text.should == above_value

      slider_handle = page.find('.ui-slider-handle')
      test_cursor = page.find('.slider-container .test-cursor')
      slider_handle.drag_to(test_cursor)

      click_button t('buttons.next')
      current_path.should == '/cal/water_basic/time'
      basic_water[:recurrent].should == 50
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
