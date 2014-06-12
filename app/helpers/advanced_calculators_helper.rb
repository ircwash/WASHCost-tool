module AdvancedCalculatorsHelper

  def options_for_sanitationwater_exists
    [
      [ t('advanced.water.questionnaire.options_for_sanitationwater_exists.neither'), 0 ],
      [ t('advanced.water.questionnaire.options_for_sanitationwater_exists.existing'), 1 ],
      [ t('advanced.water.questionnaire.options_for_sanitationwater_exists.planned'), 2 ],
      [ t('advanced.water.questionnaire.options_for_sanitationwater_exists.unknown'), 3 ]
    ]
  end

  def options_for_area_type
    [
      [ t('advanced.sanitation.questionnaire.options_for_area_type.rural'), 0 ],
      [ t('advanced.sanitation.questionnaire.options_for_area_type.small_town'), 1 ],
      [ t('advanced.sanitation.questionnaire.options_for_area_type.peri_urban'), 2 ],
      [ t('advanced.sanitation.questionnaire.options_for_area_type.urban'), 3 ],
      [ t('advanced.sanitation.questionnaire.options_for_area_type.mixed'), 4 ],
      [ t('advanced.sanitation.questionnaire.options_for_area_type.unknown'), 5 ]
    ]
  end

  def options_for_service_management
    [
      [ t('advanced.shared.options_for_service_management.community_based_management'), 0 ],
      [ t('advanced.shared.options_for_service_management.public_sector_local'), 1 ],
      [ t('advanced.shared.options_for_service_management.public_sector_national'), 2 ],
      [ t('advanced.shared.options_for_service_management.private_sector'), 3 ],
      [ t('advanced.shared.options_for_service_management.utility_management'), 4 ],
      [ t('advanced.shared.options_for_service_management.household_management'), 5 ],
      [ t('advanced.shared.options_for_service_management.other'), 6 ],
      [ t('advanced.shared.options_for_service_management.unknown'), 7 ]
    ]
  end

  def options_for_construction_financier
    [
      [ t('advanced.shared.options_for_construction_financier.external_donor'), 0 ],
      [ t('advanced.shared.options_for_construction_financier.community_based_management'), 1 ],
      [ t('advanced.shared.options_for_construction_financier.public_sector_local'), 2 ],
      [ t('advanced.shared.options_for_construction_financier.public_sector_national'), 3 ],
      [ t('advanced.shared.options_for_construction_financier.private_sector'), 4 ],
      [ t('advanced.shared.options_for_construction_financier.utility_management'), 5 ],
      [ t('advanced.shared.options_for_construction_financier.household_management'), 6 ],
      [ t('advanced.shared.options_for_construction_financier.other'), 7 ],
      [ t('advanced.shared.options_for_construction_financier.unknown'), 8 ]
    ]
  end

  def options_for_infrastructure_operator
    [
      [ t('advanced.shared.options_for_infrastructure_operator.external_donor'), 0 ],
      [ t('advanced.shared.options_for_infrastructure_operator.community_based_management'), 1 ],
      [ t('advanced.shared.options_for_infrastructure_operator.public_sector_local'), 2 ],
      [ t('advanced.shared.options_for_infrastructure_operator.public_sector_national'), 3 ],
      [ t('advanced.shared.options_for_infrastructure_operator.private_sector'), 4 ],
      [ t('advanced.shared.options_for_infrastructure_operator.utility_management'), 5 ],
      [ t('advanced.shared.options_for_infrastructure_operator.household_management'), 6 ],
      [ t('advanced.shared.options_for_infrastructure_operator.other'), 7 ],
      [ t('advanced.shared.options_for_infrastructure_operator.unknown'), 8 ]
    ]
  end

  def options_for_service_responsbility
    [
      [ t('advanced.shared.options_for_service_responsbility.external_donor'), 0 ],
      [ t('advanced.shared.options_for_service_responsbility.community_based_management'), 1 ],
      [ t('advanced.shared.options_for_service_responsbility.public_sector_local'), 2 ],
      [ t('advanced.shared.options_for_service_responsbility.public_sector_national'), 3 ],
      [ t('advanced.shared.options_for_service_responsbility.private_sector'), 4 ],
      [ t('advanced.shared.options_for_service_responsbility.utility_management'), 5 ],
      [ t('advanced.shared.options_for_service_responsbility.household_management'), 6 ],
      [ t('advanced.shared.options_for_service_responsbility.other'), 7 ],
      [ t('advanced.shared.options_for_service_responsbility.unknown'), 8 ]
    ]
  end

  def options_for_standard_enforcer
    [
      [ t('advanced.shared.options_for_standard_enforcer.external_donor'), 0 ],
      [ t('advanced.shared.options_for_standard_enforcer.community_based_management'), 1 ],
      [ t('advanced.shared.options_for_standard_enforcer.public_sector_local'), 2 ],
      [ t('advanced.shared.options_for_standard_enforcer.public_sector_national'), 3 ],
      [ t('advanced.shared.options_for_standard_enforcer.private_sector'), 4 ],
      [ t('advanced.shared.options_for_standard_enforcer.utility_management'), 5 ],
      [ t('advanced.shared.options_for_standard_enforcer.household_management'), 6 ],
      [ t('advanced.shared.options_for_standard_enforcer.other'), 7 ],
      [ t('advanced.shared.options_for_standard_enforcer.unknown'), 8 ]
    ]
  end

  def options_for_rehabilitation_cost_owner
    [
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.external_donor'), 0 ],
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.community_based_management'), 1 ],
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.public_sector_local'), 2 ],
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.public_sector_national'), 3 ],
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.private_sector'), 4 ],
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.utility_management'), 5 ],
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.household_management'), 6 ],
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.other'), 7 ],
      [ t('advanced.shared.options_for_rehabilitation_cost_owner.unknown'), 8 ]
    ]
  end

  def options_for_supply_system_technologies
    [
      [ t('advanced.shared.options_for_supply_system_technologies.borehole_and_handpump'), 0 ],
      [ t('advanced.shared.options_for_supply_system_technologies.mechanised_borehole'), 1 ],
      [ t('advanced.shared.options_for_supply_system_technologies.mechanised_pipe_system_1'), 2 ],
      [ t('advanced.shared.options_for_supply_system_technologies.mechanised_pipe_system_2'), 3 ],
      [ t('advanced.shared.options_for_supply_system_technologies.mechanised_pipe_system_3'), 4 ],
      [ t('advanced.shared.options_for_supply_system_technologies.mechanised_pipe_system_4'), 5 ],
      [ t('advanced.shared.options_for_supply_system_technologies.multi_town_system_1'), 6 ],
      [ t('advanced.shared.options_for_supply_system_technologies.multi_town_system_2'), 7 ],
      [ t('advanced.shared.options_for_supply_system_technologies.multi_town_system_3'), 8 ],
      [ t('advanced.shared.options_for_supply_system_technologies.multi_town_system_4'), 9 ],
      [ t('advanced.shared.options_for_supply_system_technologies.gravity_fed_system_1'), 10 ],
      [ t('advanced.shared.options_for_supply_system_technologies.gravity_fed_system_2'), 11 ],
      [ t('advanced.shared.options_for_supply_system_technologies.gravity_fed_system_3'), 12 ],
      [ t('advanced.shared.options_for_supply_system_technologies.gravity_fed_system_4'), 13 ],
      [ t('advanced.shared.options_for_supply_system_technologies.small_scale_rain_fed_system'), 14 ],
      [ t('advanced.shared.options_for_supply_system_technologies.protected_well'), 15 ]
    ]
  end

  def options_for_sanitation_technologies
    [
      [ t('advanced.shared.options_for_sanitation_technologies.single_pit_1'), 0 ],
      [ t('advanced.shared.options_for_sanitation_technologies.single_pit_2'), 1 ],
      [ t('advanced.shared.options_for_sanitation_technologies.double_pit_1'), 2 ],
      [ t('advanced.shared.options_for_sanitation_technologies.single_pit_3'), 3 ],
      [ t('advanced.shared.options_for_sanitation_technologies.single_pit_4'), 4 ],
      [ t('advanced.shared.options_for_sanitation_technologies.single_pit_5'), 5 ],
      [ t('advanced.shared.options_for_sanitation_technologies.double_pit_2'), 6 ],
      [ t('advanced.shared.options_for_sanitation_technologies.single_ventilated'), 7 ],
      [ t('advanced.shared.options_for_sanitation_technologies.double_pit_3'), 8 ],
      [ t('advanced.shared.options_for_sanitation_technologies.double_pit_4'), 9 ],
      [ t('advanced.shared.options_for_sanitation_technologies.single_pit_6'), 10 ],
      [ t('advanced.shared.options_for_sanitation_technologies.double_pit_5'), 11 ],
      [ t('advanced.shared.options_for_sanitation_technologies.urine'), 12 ],
      [ t('advanced.shared.options_for_sanitation_technologies.latrine'), 13 ]
    ]
  end

  def options_for_water_source
    [
      [ t('advanced.shared.options_for_water_source.ground_water'), 0 ],
      [ t('advanced.shared.options_for_water_source.surface_water'), 1 ],
      [ t('advanced.shared.options_for_water_source.rain_water'), 2 ],
      [ t('advanced.shared.options_for_water_source.unknown'), 3 ]
    ]
  end

  def options_for_surface_water_primary_source
    [
      [ t('advanced.shared.options_for_surface_water_primary_source.rainwater'), 0 ],
      [ t('advanced.shared.options_for_surface_water_primary_source.catchment'), 1 ],
      [ t('advanced.shared.options_for_surface_water_primary_source.sub_surface'), 2 ],
      [ t('advanced.shared.options_for_surface_water_primary_source.river'), 3 ],
      [ t('advanced.shared.options_for_surface_water_primary_source.unknown'), 4 ]
    ]
  end

  def options_for_water_treatment
    [
      [ t('advanced.shared.options_for_water_treatment.treatment'), 0 ],
      [ t('advanced.shared.options_for_water_treatment.boiling'), 1 ],
      [ t('advanced.shared.options_for_water_treatment.household_filer'), 2 ],
      [ t('advanced.shared.options_for_water_treatment.household_cholorination'), 3 ],
      [ t('advanced.shared.options_for_water_treatment.cholorination'), 4 ],
      [ t('advanced.shared.options_for_water_treatment.water_treatment'), 5 ],
      [ t('advanced.shared.options_for_water_treatment.not_applicable'), 6 ]
    ]
  end

  def options_for_power_supply
    [
      [ t('advanced.shared.options_for_power_supply.no_power'), 0 ],
      [ t('advanced.shared.options_for_power_supply.mains'), 1 ],
      [ t('advanced.shared.options_for_power_supply.windmills'), 2 ],
      [ t('advanced.shared.options_for_power_supply.solar'), 3 ],
      [ t('advanced.shared.options_for_power_supply.generator'), 4 ],
      [ t('advanced.shared.options_for_power_supply.not_applicable'), 5 ]
    ]
  end

  def options_for_unpaid_labour
    [
      [ t('advanced.shared.options_for_unpaid_labour.yes'), 0 ],
      [ t('advanced.shared.options_for_unpaid_labour.no'), 1 ],
      [ t('advanced.shared.options_for_unpaid_labour.unknown'), 2 ]
    ]
  end

  def options_for_national_accessibility_norms
    [
      [ t('advanced.shared.options_for_national_accessibility_norms.yes'), 0 ],
      [ t('advanced.shared.options_for_national_accessibility_norms.no'), 1 ],
      [ t('advanced.shared.options_for_national_accessibility_norms.unknown'), 2 ]
    ]
  end

  def options_for_national_quantity_norms
    [
      [ t('advanced.shared.options_for_national_quantity_norms.yes'), 0 ],
      [ t('advanced.shared.options_for_national_quantity_norms.no'), 1 ],
      [ t('advanced.shared.options_for_national_quantity_norms.unknown'), 2 ]
    ]
  end

  def options_for_national_quality_norms
    [
      [ t('advanced.shared.options_for_national_quality_norms.yes'), 0 ],
      [ t('advanced.shared.options_for_national_quality_norms.no'), 1 ],
      [ t('advanced.shared.options_for_national_quality_norms.unknown'), 2 ]
    ]
  end

  def options_for_national_reliability_norms
    [
      [ t('advanced.shared.options_for_national_reliability_norms.yes'), 0 ],
      [ t('advanced.shared.options_for_national_reliability_norms.no'), 1 ],
      [ t('advanced.shared.options_for_national_reliability_norms.unknown'), 2 ]
    ]
  end

  def options_for_national_use_norms
    [
      [ t('advanced.shared.options_for_national_use_norms.yes'), 0 ],
      [ t('advanced.shared.options_for_national_use_norms.no'), 1 ],
      [ t('advanced.shared.options_for_national_use_norms.unknown'), 2 ]
    ]
  end

  def options_for_national_environmental_protection_norms
    [
      [ t('advanced.shared.options_for_national_environmental_protection_norms.yes'), 0 ],
      [ t('advanced.shared.options_for_national_environmental_protection_norms.no'), 1 ],
      [ t('advanced.shared.options_for_national_environmental_protection_norms.unknown'), 2 ]
    ]
  end
  
end
