require 'spec_helper'


describe WaterBasicController do

  before(:each) do
    @valid_form= {
        :country => "USA",
        :water => 1,
        :population => 1,

    }
  end

  describe "Country Page" do
    def do_country(country_code)
      post :country, :country => country_code
    end

    it "should return the country view" do
      get :country
      response.should render_template('country')
    end

    it "should return the country view when an invalid country posted" do
      do_country("AA")
      response.should render_template('country')
    end

    it "should go to water view when a valid country posted" do
      do_country("AAA")
      response.should redirect_to  :action => 'water'
    end

    it "should create session when a valid country posted" do
        do_country("AAA")
        session[:water_basic_form].should_not be_nil
    end

    it "should put the country in session when a valid country posted" do
      do_country("AAA")
      session[:water_basic_form]["country"].should_not be_nil
      session[:water_basic_form]["country"].should eq("AAA")
    end
  end


  describe "Water Page" do
    def do_water(water_value)
      post :water, :water => water_value
    end

    it "should return the country view" do
      get :water
      expect(response).to render_template('water')
    end

    it "should return the water view when an invalid index is set" do
      do_water(nil)
      response.should render_template('water')
    end

    it "should go to population view when a valid index posted" do
      (0..3).to_a.each do |v|
        do_water(v)
        expect(response).to redirect_to  :action =>'population'
      end
    end

    it "should put the water variable in session when a valid water posted" do
      do_water(2)
      session[:water_basic_form]["water"].should_not be_nil
      session[:water_basic_form]["water"].to_i.should eq(2)
    end
  end

  describe "Population Page" do

    def do_post(val)
      post :population, :population => val
    end

    it "should return the population view" do
      get :population
      expect(response).to render_template('population')
    end

    it "should return the population view when an invalid index is set" do
      do_post(nil)
      response.should render_template('population')
    end

    it "should go to capital view when a valid index posted" do
      (0..4).to_a.each do |v|
        do_post(v)
        expect(response).to redirect_to  :action =>'capital'
      end
    end

    it "should put population in session when a valid population posted" do
      do_post(2)
      session[:water_basic_form]["population"].should_not be_nil
      session[:water_basic_form]["population"].should eq(2)
    end
  end

  describe "Capital Page" do

    def do_post(val)
      post :capital, :capital => val
    end

    it "should return the capital view" do
      get :capital
      expect(response).to render_template('capital')
    end

    it "should return the capital view when an invalid amount is set" do
      do_post(nil)
      response.should render_template('capital')

      do_post(-1)
      response.should render_template('capital')

      do_post("abc")
      response.should render_template('capital')
    end

    it "should go to recurrent view when a valid amount is posted" do
      do_post("200")
      expect(response).to redirect_to  :action =>'recurrent'
    end
  end

  describe "Time Page" do

    def do_post(val)
      post :time, :time => val
    end

    it "should return the population view" do
      get :time
      expect(response).to render_template('time')
    end

    it "should return the time view when an invalid index is set" do
      do_post(nil)
      response.should render_template('time')

      do_post(-1)
      response.should render_template('time')

      do_post(4)
      response.should render_template('time')
    end

    it "should go to quantity view when a valid index posted" do
      (0..3).to_a.each do |v|
        do_post(v)
        expect(response).to redirect_to  :action =>'quantity'
      end
    end
  end

  describe "Quantity" do

    def do_post(val)
      post :quantity, :quantity => val
    end

    it "should return the quantity view" do
      get :quantity
      expect(response).to render_template('quantity')
    end

    it "should return the quantity view when an invalid index is set" do
      do_post(nil)
      response.should render_template('quantity')

      do_post(-1)
      response.should render_template('quantity')

      do_post(4)
      response.should render_template('quantity')
    end

    it "should go to quality view when a valid index posted" do
      (0..3).to_a.each do |v|
        do_post(v)
        expect(response).to redirect_to  :action =>'quality'
      end
    end
  end

  describe "Report" do

    it "should have a result table in session" do
      get :report
      expect(flash[:results]).to_not be_nil
    end

    it "should have valid results" do
      valid_report= {
          :foo => "bar"
      }
      subject.stub(:get_water_basic_report).and_return(valid_report)
      get :report
      expect(flash[:results][:foo]).to eq("bar")
    end

  end

end
