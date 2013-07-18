require_relative  '../spec_helper'

describe WaterBasicHelper, :type => :helper do

  describe '#is_valid_country_code' do

    it "should return true when a valid ISO country" do

      expect helper.is_valid_country_code("AAA").should be_true

    end

    it "should return false when a valid ISO country" do

      expect helper.is_valid_country_code("AA").should be_false

    end

    it "should return false when a valid ISO country" do

      expect helper.is_valid_country_code(nil).should be_false

    end

  end

end