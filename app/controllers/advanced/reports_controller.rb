class Advanced::ReportsController < ApplicationController

  def save
    @descriptor = Advanced::Tool::Descriptor.new(params[:advanced_tool_descriptor])
    binding.pry
    redirect_to root_path
  end

end
