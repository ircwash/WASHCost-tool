require 'spec_helper'

describe "advanced/waters/index" do
  before(:each) do
    assign(:advanced_water_question_option_groups, [
      stub_model(Advanced::Water::QuestionOptionGroup,
        :name => "Name"
      ),
      stub_model(Advanced::Water::QuestionOptionGroup,
        :name => "Name"
      )
    ])
  end

  it "renders a list of advanced/waters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
