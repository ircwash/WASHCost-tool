require 'spec_helper'


describe ApplicationController do

  describe "Session Form Utility" do

    before(:each) do
      subject.add_to_session_form(:water_basic_form, :water_basic_complete, "foo","bar")
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

  describe "Session Complete Increasing" do


    it "should not exist before" do
      session[:foo].should be_nil
    end


    it "should increase the completeness" do

      subject.increase_complete_percent(:foo)
      session[:foo].should eq 1
    end

  end


end