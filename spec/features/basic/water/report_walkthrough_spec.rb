require 'spec_helper'

describe "Basic Tool Walkthrough" do
  context 'when a guest user uses the calculator', :focus do

    it 'starts the calculator' do
      start_calculator :water, :basic
      current_path.should == water_basic_path
    end


  end

  # Starts a calculator from the tool selection page
  # @param tool_name [String] the name of the tool can be either :water or :sanitation
  # @param tool_type [String] the type of the tool can be either :basic or :advanced
  def start_calculator(tool_name, tool_type)
    visit root_path
    choose "#{tool_name}_tool"
    choose "#{tool_type}_tool"
    click_button t(:start_the_calculator)
  end
end
