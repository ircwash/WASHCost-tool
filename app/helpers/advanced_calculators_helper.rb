module AdvancedCalculatorsHelper

  def options_for_water_system_exists
    [
      [ 'Installed', 0 ],
      [ 'Pre-existing', 1 ],
      [ 'Don\'t know', 2 ]
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

end
