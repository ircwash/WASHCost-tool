require 'spec_helper'

describe "advanced/waters/index" do
  before(:each) do
    assign(:advanced_water_question_options, [
      stub_model(Advanced::Water::QuestionOption,
        :label => "Label",
        :class_name => "Class Name"
      ),
      stub_model(Advanced::Water::QuestionOption,
        :label => "Label",
        :class_name => "Class Name"
      )
    ])
  end

  it "renders a list of advanced/waters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => "Class Name".to_s, :count => 2
  end
end
