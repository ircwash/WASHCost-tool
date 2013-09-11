module Basic::NavigationHelper
  # return just the items of each section in an specific questionnaire
  # @return [Array], each element contains Hash with attr used in the navigation (name, link and css class)
  def questionnaire_items
    current_path = navigation_context[:path]
    items = navigation_context.map{|k,v| v.is_a?(Hash) ? v[:items] : nil}.compact.reduce do |a, b|
      a.merge(b) { |k, v1, v2| v1 == v2 ? v1 : [v1, v2].flatten }
    end
    items.map do |k,v|
      {
          name: v,
          link: "#{current_path}/#{k.to_s}",
          class: item_class_by_action(k),
      }
    end
  end

  # return the css class associated with specific state of item (.active, .resolved or nothing)
  # @return [String]
  def item_class_by_action(action)
    form = "#{controller.controller_name}_form".to_sym
    if action.to_s == controller.action_name
      "active"
    elsif session[form].present? && session[form].has_key?(action.to_s)
      "resolved"
    end
  end

  # return the data associated with all navigation about the basic tool specified
  # @return [Hash]
  def navigation_context
    if controller.controller_name == "sanitation_basic"
      {
          path: cal_sanitation_basic_path,
          context: {
              offset: '0',
              items: {
                  country: I18n.t('nav.main.context.items.country'),
                  population: I18n.t('nav.main.context.items.population'),
                  latrine: I18n.t('nav.main.context.items.latrine'),
              }
          },
          cost: {
              offset: '-280',
              items: {
                  capital: I18n.t('nav.main.cost.items.capital'),
                  recurrent: I18n.t('nav.main.cost.items.recurrent')
              }
          },
          service: {
              offset:'-430',
              items: {
                  providing: I18n.t('nav.main.service.items.providing'),
                  impermeability: I18n.t('nav.main.service.items.impermeability'),
                  environment: I18n.t('nav.main.service.items.environment'),
                  usage: I18n.t('nav.main.service.items.usage')      ,
                  reliability: I18n.t('nav.main.service.items.reliability')
              }
          }
      }
    else
      {
          path: cal_water_basic_path,
          context: {
              offset: '0',
              items: {
                  country: I18n.t('nav.main.context.items.country'),
                  water: I18n.t('nav.main.context.items.water'),
                  population: I18n.t('nav.main.context.items.population')
              }
          },
          cost: {
              offset: '-210',
              items: {
                  capital: I18n.t('nav.main.cost.items.capital'),
                  recurrent: I18n.t('nav.main.cost.items.recurrent')
              }
          },
          service: {
              offset: '-210',
              items: {
                  time: I18n.t('nav.main.service.items.time'),
                  quantity: I18n.t('nav.main.service.items.quantity'),
                  quality: I18n.t('nav.main.service.items.quality'),
                  reliability: I18n.t('nav.main.service.items.reliability')
              }
          }
      }
    end
  end
end
