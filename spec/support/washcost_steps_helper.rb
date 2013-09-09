module WashCostStepsHelper
  # Starts a calculator from the tool selection page
  # @param tool_name [String] the name of the tool can be either :water or :sanitation
  # @param tool_type [String] the type of the tool can be either :basic or :advanced
  def start_calculator(tool_name, tool_type)
    visit cal_path

    find("label.tool#{tool_name.to_s.capitalize}").click
    find("label.tool#{tool_type.to_s.capitalize}").click

    click_button t('buttons.start')
  end
end
