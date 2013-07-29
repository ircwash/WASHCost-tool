module SanitationBasicHelper

  include SanitationReportHelper

  def sanitation_context_nav
    nav= {
        'country' => (I18n.t 'nav.main.content.items.country'),
        'household' => (I18n.t 'nav.main.content.items.household'),
        'latrine' => (I18n.t 'nav.main.content.items.latrine'),
    }
    return nav
  end


  def sanitation_service_nav
    nav= {
        'providing' => (I18n.t 'nav.main.service.items.providing'),
        'impermeability' => (I18n.t 'nav.main.service.items.impermeability'),
        'environment' => (I18n.t 'nav.main.service.items.environment'),
        'usage' => (I18n.t 'nav.main.service.items.usage')      ,
        'reliability' => (I18n.t 'nav.main.service.items.reliability')
    }
  end

end
