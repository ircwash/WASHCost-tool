module NavigationHelper
  # return just the items of each section in an specific questionnaire
  # @return [Array], each element contains Hash with attr used in the navigation (name, link and css class)
  def questionnaire_items_list
    current_path = navigation_context[:path]
    items = questionnaire_items

    case controller_path
      when "basic/water"
        path_helper = "basic_water_action"
      when "basic/sanitation"
        path_helper = "basic_sanitation_action"
      when "advanced/water"
        path_helper = "advanced_water_action"
      when "advanced/sanitation"
        path_helper = "advanced_sanitation_action"
    end

    items.map do |k,v|
      {
        name: v,
        link: send( "#{path_helper}_path", I18n.locale, k.to_s ),
        class: item_class_by_action(k),
      }
    end
  end

  # return a Hash Set with the attributtes of each nav section (name, link and css class)
  # @return [Array]
  def questionnaire_sections
    current_path = navigation_context[ :path ]
    sections     = navigation_context[ :sections ].keys

    sections.map do |section|
    {
      name: navigation_context[ :sections ][section][:name],
      redirect_to: navigation_context[ :sections ][section][:first_action],
      number_of_items: navigation_context[ :sections ][section][:items].length,
      class: navigation_context[ :sections ][section.to_sym][:items].has_key?( params[ :section ].to_sym ) ? "active" : "",
    }
    end
  end


  private

  # return just the items of each section in an specific questionnaire
  # @return [Hash Set], each element contains Hash with attr used in the navigation (name, link and css class)
  def questionnaire_items
    navigation_context[ :sections ].map{|k,v| v[:items] }.compact.reduce do |a, b|
      a.merge(b) { |k, v1, v2| v1 == v2 ? v1 : [v1, v2].flatten }
    end
  end

  # return the css class associated with specific state of item (.active, .resolved or nothing)
  # @return [String]
  def item_class_by_action(action)
    if action.to_s == params[ :section ]
      "active"
    elsif @questionnaire.methods.include?( action ) && @questionnaire.send( action ) != nil
      "resolved"
    end
  end

  # return the data associated with all navigation about the basic tool specified
  # @return [Hash]
  def navigation_context
    if controller_path == 'basic/water'
      {
        path: basic_water_path,
        sections:
        {
          context:
          {
            name: I18n.t( 'navigation.calculators.context' ),
            first_action: :country,
            items:
            {
              country: I18n.t( 'navigation.calculators.country' ),
              technology: I18n.t( 'navigation.calculators.technology' ),
              population: I18n.t( 'navigation.calculators.population' )
            }
          },
          cost:
          {
            first_action: :capital_expenditure,
            name: I18n.t( 'navigation.calculators.cost' ),
            items:
            {
              capital_expenditure: I18n.t( 'navigation.calculators.capital_expenditure' ),
              recurrent_expenditure: I18n.t( 'navigation.calculators.recurrent_expenditure' )
            }
          },
          service:
          {
            first_action: :access,
            name: I18n.t( 'navigation.calculators.service' ),
            items:
            {
              access: I18n.t( 'navigation.calculators.access' ),
              quantity: I18n.t( 'navigation.calculators.quantity' ),
              quality: I18n.t( 'navigation.calculators.quality' ),
              reliability: I18n.t( 'navigation.calculators.reliability' )
            }
          }
        }
      }
    elsif controller_path == 'basic/sanitation'
      {
        path: basic_sanitation_path,
        sections:
        {
          context:
          {
            name: I18n.t( 'navigation.calculators.context' ),
            first_action: :country,
            items:
            {
              country: I18n.t( 'navigation.calculators.country' ),
              population: I18n.t( 'navigation.calculators.population' ),
              latrine: I18n.t( 'navigation.calculators.latrine' ),
            }
          },
          cost:
          {
            first_action: :capital_expenditure,
            name: I18n.t( 'navigation.calculators.cost' ),
            items:
            {
              capital_expenditure: I18n.t( 'navigation.calculators.capital_expenditure' ),
              recurrent_expenditure: I18n.t( 'navigation.calculators.recurrent_expenditure' )
            }
          },
          service:
          {
            first_action: :household_latrine,
            name: I18n.t( 'navigation.calculators.service' ),
            items:
            {
              household_latrine: I18n.t( 'navigation.calculators.household_latrine' ),
              impermeability: I18n.t( 'navigation.calculators.impermeability' ),
              environmental_impact: I18n.t( 'navigation.calculators.environmental_impact' ),
              usage: I18n.t( 'navigation.calculators.usage' ),
              reliability: I18n.t( 'navigation.calculators.reliability' )
            }
          }
        }
      }
    elsif controller_path == 'advanced/water'
      {
        path: advanced_water_path,
        sections:
        {
          context:
          {
            name: I18n.t( 'navigation.calculators.advanced' ),
            items:
            {
              service_area: I18n.t( 'navigation.calculators.service_area' ),
              technology: I18n.t( 'navigation.calculators.technology' ),
              service_level: I18n.t( 'navigation.calculators.service_level' )
            }
          }
        }
      }
    elsif controller_path == 'advanced/sanitation'
      {
        path: advanced_sanitation_path,
        sections:
        {
          context:
          {
            name: I18n.t( 'navigation.calculators.advanced.title' ),
            items:
            {
              service_area: I18n.t( 'navigation.calculators.service_area' ),
              technology: I18n.t( 'navigation.calculators.technology' ),
              service_level: I18n.t( 'navigation.calculators.service_level' )
            }
          }
        }
      }
    end
  end
end
