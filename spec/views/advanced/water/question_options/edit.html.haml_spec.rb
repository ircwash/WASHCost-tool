require 'spec_helper'

describe "advanced/waters/edit" do
  before(:each) do
    @advanced_water = assign(:advanced_water, stub_model(Advanced::Water::QuestionOption,
      :label => "MyString",
      :class_name => "MyString"
    ))
  end

  it "renders the edit advanced_water form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advanced_water_path(@advanced_water), "post" do
      assert_select "input#advanced_water_label[name=?]", "advanced_water[label]"
      assert_select "input#advanced_water_class_name[name=?]", "advanced_water[class_name]"
    end
  end
end
