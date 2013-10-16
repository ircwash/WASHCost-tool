class Advanced::QuestionnairesController < ApplicationController
  def index
    @descriptor = Advanced::Report::Descriptor.new
    technologies = []
    3.times.each do ||
      technology = Advanced::Report::Technology.new
      technologies << technology
    end
    @descriptor.technologies = technologies
  end
end
