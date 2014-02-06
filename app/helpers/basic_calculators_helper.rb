module BasicCalculatorsHelper

  # constants

  def minimum_capital_expenditure_for_water
    0
  end

  def maximum_capital_expenditure_for_water
    300
  end

  def minimum_guidance_capital_expenditure_for_water
    20
  end

  def maximum_guidance_capital_expenditure_for_water
    61
  end

  def minimum_recurrent_expenditure_for_water
    0
  end

  def maximum_recurrent_expenditure_for_water
    30
  end

  def minimum_guidance_recurrent_expenditure_for_water
    3
  end

  def maximum_guidance_recurrent_expenditure_for_water
    6
  end

  def minimum_access_for_water
    0
  end

  def maximum_access_for_water
    3
  end

  # options

  def options_for_water_supply_technologies
    [
      [ 'borehole_handpump', 0 ],
      [ 'mechanised_borehole', 1 ],
      [ 'single_town_scheme', 2 ],
      [ 'multi_town_scheme', 3 ],
      [ 'mixed_pipe_supply', 4 ]
    ]
  end

  def options_for_water_access
    [
      t( 'basic.water.questionnaire.access.options.less_than_ten' ),
      t( 'basic.water.questionnaire.access.options.between_ten_and_thirty' ),
      t( 'basic.water.questionnaire.access.options.between_thirty_and_sixty' ),
      t( 'basic.water.questionnaire.access.options.more_thank_sixty' )
    ]
  end

  def options_for_water_quantities
    [
      [ 'less_than_five_litres', 0 ],
      [ 'between_five_and_nineteen_litres', 1 ],
      [ 'between_twenty_and_sixty_litres', 2 ],
      [ 'more_than_sixy_litres', 3 ]
    ]
  end

  def options_for_water_qualities
    [
      [ 'regular_and_meets_standards', 0 ],
      [ 'occasional_and_meets_standards', 1 ],
      [ 'one_off_after_construction', 2 ],
      [ 'no_testing', 3 ]
    ]
  end

  def options_for_water_reliability
    [
      [ 'works_all_the_time', 0 ],
      [ 'not_working_less_than_twelve_days_a_year', 1 ],
      [ 'not_working_more_than_twelve_days_a_year', 2 ],
      [ 'not_working_all_of_the_time', 3 ]
    ]
  end

end