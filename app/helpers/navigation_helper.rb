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
    sections = navigation_context[ :sections ].keys

    sections.map do |section|
      {
          name: navigation_context[ :sections ][section][:name],
          redirect_to: navigation_context[ :sections ][section][:first_action],
          number_of_items: navigation_context[ :sections ][section][:items].length,
          class: navigation_context[ :sections ][section.to_sym][:items].has_key?(controller.action_name.to_sym) ? "active" : "",
      }
    end
  end

  # return an array with the items associated to each section
  # @return [Array]
  def index_questionnaire_item_active
    items = questionnaire_items
    items.each_with_index do |item|
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
    form = "#{controller.controller_name}_basic_form".to_sym
    if action.to_s == controller.action_name
      "active"
    elsif session[form].present? && session[form].has_key?(action.to_s)
      "resolved"
    end
  end

  # return the data associated with all navigation about the basic tool specified
  # @return [Hash]
  def navigation_context
    if controller_path == "basic/sanitation"
      {
        path: basic_sanitation_path,
        sections:
        {
          context:
          {
            name: I18n.t('nav.main.context.title'),
            first_action: :country,
            items:
            {
              country: I18n.t('nav.main.context.items.country'),
              population: I18n.t('nav.main.context.items.population'),
              latrine: I18n.t('nav.main.context.items.latrine'),
            }
          },
          cost:
          {
            first_action: :capital,
            name: I18n.t('nav.main.cost.title'),
            items:
            {
              capital: I18n.t('nav.main.cost.items.capital'),
              recurrent: I18n.t('nav.main.cost.items.recurrent')
            }
          },
          service:
          {
            first_action: :providing,
            name: I18n.t('nav.main.service.title'),
            items:
            {
              providing: I18n.t('nav.main.service.items.providing'),
              impermeability: I18n.t('nav.main.service.items.impermeability'),
              environment: I18n.t('nav.main.service.items.environment'),
              usage: I18n.t('nav.main.service.items.usage')      ,
              reliability: I18n.t('nav.main.service.items.reliability')
            }
          }
        }
      }
    elsif controller_path == "basic/water"
      {
        path: basic_water_path,
        sections:
        {
          context:
          {
            name: I18n.t('nav.main.context.title'),
            first_action: :country,
            items:
            {
              country: I18n.t('nav.main.context.items.country'),
              water: I18n.t('nav.main.context.items.water'),
              population: I18n.t('nav.main.context.items.population')
            }
          },
          cost:
          {
            first_action: :capital,
            name: I18n.t('nav.main.cost.title'),
            items:
            {
              capital: I18n.t('nav.main.cost.items.capital'),
              recurrent: I18n.t('nav.main.cost.items.recurrent')
            }
          },
          service:
          {
            first_action: :time,
            name: I18n.t('nav.main.service.title'),
            items:
            {
              time: I18n.t('nav.main.service.items.time'),
              quantity: I18n.t('nav.main.service.items.quantity'),
              quality: I18n.t('nav.main.service.items.quality'),
              reliability: I18n.t('nav.main.service.items.reliability')
            }
          }
        }
      }
    else
      {
        path: advanced_water_path,
        sections:
        {
          context:
          {
            name: I18n.t('nav.main.advanced.title'),
            first_action: :country,
            items:
            {
              context: I18n.t('nav.main.advanced.items.context'),
              system_management: I18n.t('nav.main.advanced.items.system_management'),
              system_characteristics: I18n.t('nav.main.advanced.items.system_characteristics'),
              cost: I18n.t('nav.main.advanced.items.cost'),
              service: I18n.t('nav.main.advanced.items.service')
            }
          }
        }
      }
    end
  end
end
