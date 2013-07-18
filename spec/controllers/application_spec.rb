require 'spec_helper'


describe ApplicationController do

  describe "Session Form Utility" do

    before(:each) do
      subject.add_to_session_form("foo","bar")
    end

    it "should create a session" do
      session[:water_basic_form].should_not be_nil
    end

    it "should have the sent key/value" do
      session[:water_basic_form]["foo"].should eq("bar")
    end

    it "should keep the value when something else is added" do
      subject.add_to_session_form("booh","bah")
      session[:water_basic_form]["foo"].should eq("bar")
      session[:water_basic_form]["booh"].should eq("bah")
    end
  end

  describe "Session Form Completion Tracking" do

    before(:each) do
      ApplicationController.class_variable_set :@@pages, 10
      subject.increase_pages_complete("country")
    end

    it "should have a total number of pages" do
      subject.pages.should eq(10)
    end

    it "should create a session when increased" do
      session[:pages_complete].should_not be_nil
    end

    it "should be one" do
      session[:pages_complete].should eq(1)
    end

  end

  describe "Number Util" do

    it "should return false for nil" do
      subject.is_number(nil).should eq(false)
    end

    it "should return false for string" do
      subject.is_number("a").should eq(false)
    end

    it "should return true for zero" do
      subject.is_number("0").should eq(true)
    end

    it "should return true for number" do
      subject.is_number(0).should eq(true)
    end

    it "should return true for nex" do
      subject.is_number(-1).should eq(true)
    end
  end

  describe '#is_valid_country_code' do

    it "should return true when a valid ISO country" do

      expect subject.is_valid_country_code("AAA").should be_true

    end

    it "should return false when a valid ISO country" do

      expect subject.is_valid_country_code("AA").should be_false

    end

    it "should return false when a valid ISO country" do

      expect subject.is_valid_country_code(nil).should be_false

    end

  end
end