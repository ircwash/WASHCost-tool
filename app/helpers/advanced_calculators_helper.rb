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

end
