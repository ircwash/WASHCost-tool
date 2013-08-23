require 'spec_helper'

describe "Advanced::Water::QuestionOptions" do
  describe "GET /advanced_water_question_options" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get advanced_water_question_options_path
      response.status.should be(200)
    end
  end
end
