require_relative  '../spec_helper'

describe WaterBasicHelper, :type => :helper do

  describe "Main Navigation" do

    before(:each) do
      session[:water_basic_form]= {
          :country => "US"
      }

      params[:action]='water'
    end


    it "should know the current top level navigation is current" do
      expect(is_main_nav_current?(:context, params[:action])).to eq(true)
    end

    it "should return the active class for the current top level nav section" do
      expect(get_main_nav_cssClass(:context, params[:action])).to eq("active")
    end

    it "should return blank for any other top level nav section" do
      expect(get_main_nav_cssClass(:context, 'FOO')).to eq("")
    end

    it "should set the nav item class to active if it is current" do
      expect(get_class_for_section(:water_basic_form, :water)).to eq('active')
    end

    it "should set the nav item class to 'done' when it has been completed" do
      expect(get_class_for_section(:water_basic_form, :country)).to eq('done')
    end

    it "should not set the class when it is neither current nor complete" do
      expect(get_class_for_section(:water_basic_form, :capital)).to eq('')
    end

  end

end