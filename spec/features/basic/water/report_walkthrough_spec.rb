require 'spec_helper'

describe "Basic Tool Walkthrough" do
  context 'when a guest user uses the calculator', :focus do

    it 'starts the calculator' do
      start_calculator :water, :basic
      current_path.should == water_basic_path
    end

    it 'selects the country' do
      visit water_basic_path
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
      ap session
      basic_water[:water].should == 1
    end

    # a more semantic approach to naming the session
    # could be named "report" too
    def basic_water
      basic_water_session
    end

  end

end
