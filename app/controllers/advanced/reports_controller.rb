class Advanced::ReportsController < ApplicationController

  def report
    descriptor = Advanced::Tool::Descriptor.new(params[:advanced_tool_descriptor])
    calculator = Advanced::Report::Calculator.new
    calculator.descriptor = descriptor
    calculator.technology = Advanced::Report::Technology.new
    calculator.technology.costs = Advanced::Report::Cost.new
    calculator.technology.costs.capital = Advanced::Report::CapitalCost.new
    calculator.technology.costs.recurrent = Advanced::Report::RecurrentCost.new

    @presenter = calculator.presenter

  end

end
