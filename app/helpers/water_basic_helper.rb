module WaterBasicHelper

  include ReportHelper

  def get_class_for_section(section)

    className= ''

    if params[:action].to_s === section.to_s
      className= 'active'
    elsif session[:water_basic_form].present? && session[:water_basic_form][section]
      className= 'done'
    end


    return className

  end

  def set_categories_for_navigation
    categories = {}
    current_action = params[:action]

    categories["context_class"] = true if !!(current_action.match /country|water|population|household|latrine/)
    categories["cost_class"] = true if !!(current_action.match /capital|recurrent/)
    categories["service_class"] = true if !!(current_action.match /time|quantity|quality|providing|impermeability|environment|usage|reliability/)

    params[:categories] = categories
  end

  def content_nav
    nav= {
      'country' => (I18n.t 'nav.main.content.items.country'),
      'water' => (I18n.t 'nav.main.content.items.water'),
      'population' => (I18n.t 'nav.main.content.items.population')
    }
    return nav
  end

  def cost_nav
    nav= {
      'capital' => (I18n.t 'nav.main.cost.items.capital'),
      'recurrent' => (I18n.t 'nav.main.cost.items.recurrent')
    }
  end

  def service_nav
    nav= {
      'quantity' => (I18n.t 'nav.main.service.items.quantity'),
      'quality' => (I18n.t 'nav.main.service.items.quality'),
      'reliability' => (I18n.t 'nav.main.service.items.reliability')
    }
  end

  def is_active_category?( name )
    params[:categories].has_key?(name) ? "active" : ""
  end



end
