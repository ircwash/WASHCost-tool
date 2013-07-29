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

      subject.add_to_session_form(:water_basic_form, :water_basic_complete, "booh","bah")

      session[:water_basic_form]["foo"].should eq("bar")
      session[:water_basic_form]["booh"].should eq("bah")
    end
  end

  describe "Session Complete Increasing" do


    it "should not exist before" do
      session[:foo].should be_nil
    end


    it "should increase the completeness" do

      subject.increase_complete_percent(:foo_bar)
      session[:foo_bar].should eq 1

      subject.increase_complete_percent(:foo_bar)
      session[:foo_bar].should eq 2

    end

  end

  describe "Session Form Completion Tracking" do

    before(:each) do
      ApplicationController.class_variable_set :@@pages, 10
      subject.add_to_session_form(:water_basic, :water_basic_complete, "foo", "bar")
    end

    it "should have a total number of pages" do
      subject.pages.should eq(10)
    end

    it "should create a session when increased" do
      session[:water_basic_complete].should_not be_nil
    end

    it "should be one when added the first time" do
      session[:water_basic_complete].should eq(1)
    end

    it "should still be one when added a second time" do
      subject.add_to_session_form(:water_basic, :water_basic_complete, "foo", "boo")
      session[:water_basic_complete].should eq(1)
    end

    it "should be two when adding a second item" do
      subject.add_to_session_form(:water_basic, :water_basic_complete, "bee", "bop")
      session[:water_basic_complete].should eq(2)
    end

    it "should be 10% total" do
      subject.get_percent_complete(:water_basic_complete).should eq(10)
    end

  end

end