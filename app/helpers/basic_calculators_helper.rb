module BasicCalculatorsHelper

  def options_for_water_supply_technologies
    [
      [ 'borehole_handpump', 0 ],
      [ 'mechanised_borehole', 1 ],
      [ 'single_town_scheme', 2 ],
      [ 'multi_town_scheme', 3 ],
      [ 'mixed_pipe_supply', 4 ]
    ]
  end

end