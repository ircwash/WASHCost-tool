require 'spec_helper'

describe "advanced/waters/show" do
  before(:each) do
    @advanced_water = assign(:advanced_water, stub_model(Advanced::Water::Questionnaire,
      :something => "Something"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Something/)
  end
end
