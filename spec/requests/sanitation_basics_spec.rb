require 'spec_helper'

describe "WaterBasicFormPages" do

  describe "Country page" do
    it "should have the 'country' field" do
      visit "/water_basic/country"
      page.should have_field('country')
    end
  end

end
