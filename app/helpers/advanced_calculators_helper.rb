module AdvancedCalculatorsHelper

  def options_for_water_system_exists
    [
      [ 'Installed', 0 ],
      [ 'Pre-existing', 1 ],
      [ 'Don\'t know', 2 ]
    ]
  end

  def options_for_sanitation_service_exists
    [
      [ 'Neither', 0 ],
      [ 'Existing', 1 ],
      [ 'Planned', 2 ],
      [ 'Don\'t know', 3 ]
    ]
  end

  def options_for_area_type
    [
      [ 'Rural', 0 ],
      [ 'Small town', 1 ],
      [ 'Peri-urban', 2 ],
      [ 'Urban', 3 ],
      [ 'Don\'t know', 4 ]
    ]
  end

  def options_for_service_management
    [
      [ 'Utility management', 0 ],
      [ 'Household management', 1 ],
      [ 'Other (define)', 2 ],
      [ 'Don\'t know', 3 ]
    ]
  end

  def options_for_construction_financier
    [
      [ 'Utility management', 0 ],
      [ 'Household management', 1 ],
      [ 'Other (define)', 2 ],
      [ 'Don\'t know', 3 ]
    ]
  end

  def options_for_infrastructure_operator
    [
      [ 'External donor', 0 ],
      [ 'Community-based management', 1 ],
      [ 'Public sector (local)', 2 ],
      [ 'Public sector (national)', 3 ],
      [ 'Private sector', 4 ],
      [ 'Utility management', 5 ],
      [ 'Household management', 6 ],
      [ 'Other', 7 ],
      [ 'Don\'t know', 8 ]
    ]
  end

  def options_for_service_responsbility
    [
      [ 'External donor', 0 ],
      [ 'Community-based management', 1 ],
      [ 'Public sector (local)', 2 ],
      [ 'Public sector (national)', 3 ],
      [ 'Private sector', 4 ],
      [ 'Utility management', 5 ],
      [ 'Household management', 6 ],
      [ 'Other', 7 ],
      [ 'Don\'t know', 8 ]
    ]
  end

  def options_for_standard_enforcer
    [
      [ 'External donor', 0 ],
      [ 'Community-based management', 1 ],
      [ 'Public sector (local)', 2 ],
      [ 'Public sector (national)', 3 ],
      [ 'Private sector', 4 ],
      [ 'Utility management', 5 ],
      [ 'Household management', 6 ],
      [ 'Other', 7 ],
      [ 'Don\'t know', 8 ]
    ]
  end

  def options_for_rehabilitation_cost_owner
    [
      [ 'External donor', 0 ],
      [ 'Community-based management', 1 ],
      [ 'Public sector (local)', 2 ],
      [ 'Public sector (national)', 3 ],
      [ 'Private sector', 4 ],
      [ 'Utility management', 5 ],
      [ 'Household management', 6 ],
      [ 'Other', 7 ],
      [ 'Don\'t know', 8 ]
    ]
  end

  def options_for_supply_system_technologies
    [
      [ 'Borehole and handpump', 0 ],
      [ 'Mechanised borehole', 1 ],
      [ 'Mechanised piped system (< 5,000 people)', 2 ],
      [ 'Mechanised piped system (5000 - 1000 people)', 3 ],
      [ 'Mechanised piped system (1000 - 20000 people)', 4 ],
      [ 'Mechanised piped system (> 20000 people)', 5 ],
      [ 'Multi-town system (< 5000 people)', 6 ],
      [ 'Multi-town system (5000 - 10000 people)', 7 ],
      [ 'Multi-town system (10000 - 2000 people)', 8 ],
      [ 'Multi-town system (> 2000 people)', 9 ],
      [ 'Gravity fed system (< 5000 people)', 10 ],
      [ 'Gravity fed system (5000 - 10000 people)', 11 ],
      [ 'Gravity fed system (10000 - 20000 people)', 12 ],
      [ 'Gravity fed system (>20000 people)', 13 ],
      [ 'Small scale rain fed system', 14 ],
      [ 'Protected well', 15 ]
    ]
  end

  def options_for_sanitation_technologies
    [
      [ 'Single Pit latrine with platform/squat plate (no slab)', 0 ],
      [ 'Single Pit latrine with impermeable slab (non-concrete slab)', 1 ],
      [ 'Double pit latrine with impermeable slab (non-concrete slab)', 2 ],
      [ 'Single pit composting latrine', 3 ],
      [ 'Single pit composting latrine with concrete slab', 4 ],
      [ 'Single Pit latrine with concrete slab', 5 ],
      [ 'Double pit latrine with concrete Slab', 6 ],
      [ 'Single ventilated improved pit latrine', 7 ],
      [ 'Double pit ventilated improved pit latrine', 8 ],
      [ 'Double pit composting toilet with concrete slab', 9 ],
      [ 'Single pit pour flush latrine with soak away', 10 ],
      [ 'Double pit pour flush latrine with soak away', 11 ],
      [ 'Urine diversion dry toilet', 12 ],
      [ 'Latrine with septic tank', 13 ],
      [ 'Single Pit latrine with platform/squat plate (no slab)', 14 ],
      [ 'Single Pit latrine with impermeable slab (non-concrete slab)', 15 ],
      [ 'Double pit latrine with impermeable slab (non-concrete slab)', 16 ],
      [ 'Single pit composting latrine', 17 ],
      [ 'Single pit composting latrine with concrete slab', 18 ],
      [ 'Single Pit latrine with concrete slab', 19 ],
      [ 'Double pit latrine with concrete Slab', 20 ],
      [ 'Single ventilated improved pit latrine', 21 ],
      [ 'Double pit ventilated improved pit latrine', 22 ],
      [ 'Double pit composting toilet with concrete slab', 23 ],
      [ 'Single pit pour flush latrine with soak away', 24 ],
      [ 'Double pit pour flush latrine with soak away', 25 ],
      [ 'Urine diversion dry toilet', 26 ],
      [ 'Latrine with septic tank', 27 ],
      [ 'Single Pit latrine with platform/squat plate (no slab)', 28 ],
      [ 'Single Pit latrine with impermeable slab (non-concrete slab)', 29 ],
      [ 'Double pit latrine with impermeable slab (non-concrete slab)', 30 ],
      [ 'Single pit composting latrine', 31 ],
      [ 'Single pit composting latrine with concrete slab', 32 ],
      [ 'Single Pit latrine with concrete slab', 33 ],
      [ 'Double pit latrine with concrete Slab', 34 ],
      [ 'Single ventilated improved pit latrine', 35 ],
      [ 'Double pit ventilated improved pit latrine', 36 ],
      [ 'Double pit composting toilet with concrete slab', 37 ],
      [ 'Single pit pour flush latrine with soak away', 38 ],
      [ 'Double pit pour flush latrine with soak away', 39 ],
      [ 'Urine diversion dry toilet', 40 ],
      [ 'Latrine with septic tank', 41 ],
      [ 'Single Pit latrine with platform/squat plate (no slab)', 42 ],
      [ 'Single Pit latrine with impermeable slab (non-concrete slab)', 43 ],
      [ 'Double pit latrine with impermeable slab (non-concrete slab)', 44 ],
      [ 'Single pit composting latrine', 45 ],
      [ 'Single pit composting latrine with concrete slab', 46 ],
      [ 'Single Pit latrine with concrete slab', 47 ],
      [ 'Double pit latrine with concrete Slab', 48 ],
      [ 'Single ventilated improved pit latrine', 49 ],
      [ 'Double pit ventilated improved pit latrine', 50 ],
      [ 'Double pit composting toilet with concrete slab', 51 ],
      [ 'Single pit pour flush latrine with soak away', 52 ],
      [ 'Double pit pour flush latrine with soak away', 53 ],
      [ 'Urine diversion dry toilet', 54 ],
      [ 'Latrine with septic tank', 55 ]
    ]
  end

  def options_for_water_source
    [
      [ 'Ground water', 0 ],
      [ 'Surface water', 1 ],
      [ 'Rain water', 2 ],
      [ 'Don\'t know', 3 ]
    ]
  end

  def options_for_surface_water_primary_source
    [
      [ 'Rainwater harvesting', 0 ],
      [ 'Catchment storage dam', 1 ],
      [ 'Sub-surface harvesting (sump)', 2 ],
      [ 'River', 3 ],
      [ 'Don\'t know', 4 ]
    ]
  end

  def options_for_water_treatment
    [
      [ 'No treatment', 0 ],
      [ 'Boiling', 1 ],
      [ 'Household filter', 2 ],
      [ 'Household cholorination', 3 ],
      [ 'Chlorination in piped system', 4 ],
      [ 'Water treatment works', 5 ],
      [ 'Not applicable', 6 ]
    ]
  end

  def options_for_power_supply
    [
      [ 'No power', 0 ],
      [ 'Mains electricity', 1 ],
      [ 'Windmills', 2 ],
      [ 'Solar power systems', 3 ],
      [ 'Generator', 4 ],
      [ 'Not applicable', 5 ]
    ]
  end

  def options_for_unpaid_labour
    [
      [ 'Yes', 0 ],
      [ 'No', 1 ],
      [ 'Don\'t know', 2 ]
    ]
  end

  def options_for_national_accessibility_norms
    [
      [ 'Yes', 0 ],
      [ 'No', 1 ],
      [ 'Don\'t know', 2 ]
    ]
  end

  def options_for_national_quantity_norms
    [
      [ 'Yes', 0 ],
      [ 'No', 1 ],
      [ 'Don\'t know', 2 ]
    ]
  end

  def options_for_national_quality_norms
    [
      [ 'Yes', 0 ],
      [ 'No', 1 ],
      [ 'Don\'t know', 2 ]
    ]
  end

  def options_for_national_reliability_norms
    [
      [ 'Yes', 0 ],
      [ 'No', 1 ],
      [ 'Don\'t know', 2 ]
    ]
  end

  def options_for_national_use_norms
    [
      [ 'Yes', 0 ],
      [ 'No', 1 ],
      [ 'Don\'t know', 2 ]
    ]
  end

  def options_for_national_environmental_protection_norms
    [
      [ 'Yes', 0 ],
      [ 'No', 1 ],
      [ 'Don\'t know', 2 ]
    ]
  end

end
