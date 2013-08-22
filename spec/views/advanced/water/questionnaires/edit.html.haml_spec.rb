require 'spec_helper'

describe "advanced/waters/edit" do
  before(:each) do
    @advanced_water = assign(:advanced_water, stub_model(Advanced::Water::Questionnaire,
      :something => "MyString"
    ))
  end

  it "renders the edit advanced_water form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advanced_water_path(@advanced_water), "post" do
      assert_select "input#advanced_water_something[name=?]", "advanced_water[something]"
    end
  end
end
