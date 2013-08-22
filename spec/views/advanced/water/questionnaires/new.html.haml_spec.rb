require 'spec_helper'

describe "advanced/waters/new" do
  before(:each) do
    assign(:advanced_water, stub_model(Advanced::Water::Questionnaire,
      :something => "MyString"
    ).as_new_record)
  end

  it "renders new advanced_water form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advanced_water_questionnaires_path, "post" do
      assert_select "input#advanced_water_something[name=?]", "advanced_water[something]"
    end
  end
end
