require 'spec_helper'

describe "WaterBasicFormPages" do

  describe "Country page" do
    it "should have the 'country' field" do
      visit "/water_basic/country"
      page.should have_field('country')
    end

    it "should submit to step 2 (water)" do
      visit "/water_basic/country"
      page.should have_selector("form[action='/water_basic/country']")
    end

    it "should submit as POST only" do
      visit "/water_basic/country"
      page.should have_selector("form[method='post']")
    end


  end




end
