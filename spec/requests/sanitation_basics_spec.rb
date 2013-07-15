require 'spec_helper'

describe "WaterBasicFormPages" do

  describe "Country page" do
    it "should have the content 'country'" do
      visit "/sanitation_basic/country"
      page.should have_field('In which country')
    end
  end


end
