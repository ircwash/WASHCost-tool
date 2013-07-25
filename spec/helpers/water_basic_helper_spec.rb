require_relative  '../spec_helper'

describe WaterBasicHelper, :type => :helper do

  describe "Main Navigation" do

    before(:each) do
      session[:water_basic_form]= {
          :country => "US"
      }

      params[:action]='water'

      set_categories_for_navigation
    end

    it "should set the nav item class to active if it is current" do

      expect(get_class_for_section(:water)).to eq('active')

    end

    it "should set the nav item class to 'done' when it has been completed" do
      expect(get_class_for_section(:country)).to eq('done')
    end

    it "should not set the class when it is neither current nor complete" do
      expect(get_class_for_section(:capital)).to eq('')
    end


  end

end