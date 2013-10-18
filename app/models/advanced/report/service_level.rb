class Advanced::Report::ServiceLevel

  include ActiveAttr::Model

  def washcost_standard(service_level)
    [service_level.accesibility_distance, service_level.quantity_use, service_level.quality_testing, service_level.reliability].min
  end

  def national_norm(service_level)
    [service_level.accesibility_norms, service_level.quantity_norms, service_level.quality_norms, service_level.reliability_norms].min
  end

  def washcost_standard_caption(index)
    ['No service',
    'Sub-standard service',
    'Basic service',
    'High level service'].at(index-1)
  end

  def national_norm_caption(index)
    ['Does not meet national norms',
    'Meets national norms'].at(index-1)
  end

  def percentage_population_served(service_level)
    service_level.percentage_using
  end

end
