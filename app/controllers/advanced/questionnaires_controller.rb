class Advanced::QuestionnairesController < ApplicationController
  def index
    @descriptor = Advanced::Tool::Descriptor.new
    technologies = []
    3.times.each do ||
      technology = Advanced::Tool::Technology.new
      technology.water_source = Advanced::Tool::WaterSource.new
      technology.costs = Advanced::Tool::Cost.new
      technology.costs.capital = Advanced::Tool::CapitalCost.new
      technology.costs.recurrent = Advanced::Tool::RecurrentCost.new
      technologies << technology
    end
    service_levels = []
    3.times.each do ||
      service_level = Advanced::Tool::ServiceLevel.new
      service_levels << service_level
    end
    @descriptor.technologies = technologies
    @descriptor.service_levels = service_levels
  end
end
