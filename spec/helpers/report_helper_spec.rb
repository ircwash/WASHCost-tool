require_relative  '../spec_helper'

describe WaterReportHelper, :type => :helper do

  describe "Get the report values from ession" do

    before(:each) do
      session[:water_basic_form]= {
          :country => "ABC"
      }
    end

    it "should get the form from the session" do
      expect(get_session_form).to_not be_nil
    end

    it "should contain form values that are set" do
      expect(get_session_form[:country]).to eq("ABC")
    end

  end

  describe "Report Generation" do

    before(:each) do
      session[:water_basic_form]= {
          :country => "US",
          :water => 1,
          :population => 1,
          :capital => 100,
          :recurrent => 200,
          :time => 1,
          :quantity => 1,
          :quality => 1,
          :reliability => 1,
      }

      @form= get_session_form
    end

    it "should return invalid countries" do
      expect(get_country("blergh")).to be_nil
    end

    it "should set the country value" do
      expect(get_country(@form[:country]).alpha2).to eq ("US")
    end

    it "should get the water value" do
      expect(get_water(@form[:water])).to eq(t 'form.water_basic.water.answers.a1')
    end

    it "should send back not set for out of bounds value" do
      expect(get_water(22)).to eq(t 'form.value_not_set')
    end

  end


  describe "General Sustainability Calculations" do

    it "should" do
      get_capEx_benchmark_rating
    end


    #bench= @@water_values[waterSourceIndex].capExBench
    #rating= (ex >= bench.min && exp <= bench.max) ? 2 : ( (ex < bench.min) ? .5 : 1  )
    #
    #return rating

  end

end