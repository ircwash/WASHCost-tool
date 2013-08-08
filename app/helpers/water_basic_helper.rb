module WaterBasicHelper

  include WaterReportHelper


  def get_class_for_section(form, section)

    className= ''

    if params[:action].to_s === section.to_s
      className= 'active'
    elsif session[form].present? && session[form].has_key?(section)
      className= 'done'
    end

    return className
  end

  def is_main_nav_current?(main_nav, action)

    is_current= false

    get_nav_items[main_nav][:items].each do |key, value|
      if action === key
        is_current= true
        break
      end
    end

    return is_current
  end

  def get_main_nav_cssClass(main_nav, action)

    cssClass=''

    if is_main_nav_current?(main_nav, action)
      cssClass= 'active'
    end

    return cssClass
  end

  def get_nav_offset

    nav_offset= '0'

    get_nav_items.each do |key, value|

      if is_main_nav_current?(key, params[:action])
        nav_offset= value[:offset]
        break
      end

    end

    return nav_offset
  end


  def get_nav_items

    if(params[:is_sanitation]== true)
      return {
          :context => {
              :offset => '0',
              :items => {
                  'country' => (I18n.t 'nav.main.context.items.country'),
                  'population' => (I18n.t 'nav.main.context.items.population'),
                  'latrine' => (I18n.t 'nav.main.context.items.latrine'),
              }
          },
          :cost => {
              :offset => '-280',
              :items => {
                  'capital' => (I18n.t 'nav.main.cost.items.capital'),
                  'recurrent' => (I18n.t 'nav.main.cost.items.recurrent')
              }
          },
          :service => {
              :offset => '-610',
              :items => {
                  'providing' => (I18n.t 'nav.main.service.items.providing'),
                  'impermeability' => (I18n.t 'nav.main.service.items.impermeability'),
                  'environment' => (I18n.t 'nav.main.service.items.environment'),
                  'usage' => (I18n.t 'nav.main.service.items.usage')      ,
                  'reliability' => (I18n.t 'nav.main.service.items.reliability')
              }
          }
      }
    end

    return {
        :context => {
            :offset => '0',
            :items => {
                'country' => (I18n.t 'nav.main.context.items.country'),
                'water' => (I18n.t 'nav.main.context.items.water'),
                'population' => (I18n.t 'nav.main.context.items.population')
            }
        },
        :cost => {
            :offset => '-250',
            :items => {
                'capital' => (I18n.t 'nav.main.cost.items.capital'),
                'recurrent' => (I18n.t 'nav.main.cost.items.recurrent')
            }
        },
        :service => {
            :offset => '-370',
            :items => {
                'time' => (I18n.t 'nav.main.service.items.time'),
                'quantity' => (I18n.t 'nav.main.service.items.quantity'),
                'quality' => (I18n.t 'nav.main.service.items.quality'),
                'reliability' => (I18n.t 'nav.main.service.items.reliability')
            }
        }
    }

  end

end
