module TranslateHelper

	def from_locales
		# Attempt to get the list of locale from configuration
		from_loc = Rails.application.config.from_locales if Rails.application.config.respond_to?(:from_locales)
		return I18n.available_locales if from_loc.blank?
		raise StandardError, "from_locale expected to be an array" if from_loc.class != Array
		from_loc
	end

	def to_locales
    #to_loc = Rails.application.config.to_locales if Rails.application.config.respond_to?(:to_locales)
		#return I18n.available_locales if to_loc.blank?
		#raise StandardError, "to_locales expected to be an array" if to_loc.class != Array
    to_loc = []
    if current_user.translate_en == 1
      to_loc.push(:en)
    end
    if current_user.translate_fr == 1
      to_loc.push(:fr)
    end
    if current_user.translate_bn == 1
      to_loc.push(:bn)
    end
		to_loc
	end

  def simple_filter(labels, param_name = 'filter', selected_value = nil)
    selected_value ||= params[param_name]
    filter = []
    labels.each do |item|
      if item.is_a?(Array)
        type, label = item
      else
        type = label = item
      end
      if type.to_s == selected_value.to_s
        filter << "<i>#{label}</i>"
      else
        link_params = params.merge({param_name.to_s => type})
        link_params.merge!({"page" => nil}) if param_name.to_s != "page"
        filter << link_to(label, link_params)
      end
    end
    filter.join(" | ")
  end

  def n_lines(text, line_size)
    n_lines = 1
    if text.present?
      n_lines = text.split("\n").size
      if n_lines == 1 && text.length > line_size
        n_lines = text.length / line_size + 1
      end
    end
    n_lines
  end

  def translate_javascript_includes
    sources = []
    if File.exists?(File.join(Rails.root, "public", "javascripts", "prototype.js"))
      sources << "/javascripts/prototype.js"
    else
      sources << "http://ajax.googleapis.com/ajax/libs/prototype/1.7.0.0/prototype.js"
    end
    sources.map do |src|
      %Q{<script src="#{src}" type="text/javascript"></script>}
    end.join("\n").html_safe
  end

  def translate_link(key, text, from, to)
    method = if Translate.app_id
      'getBingTranslation'
    elsif Translate.api_key
      'getGoogleTranslation'
    else
      nil
    end
    return nil unless method
    link_to_function 'Auto Translate', "#{method}('#{key}', \"#{escape_javascript(text)}\", '#{from}', '#{to}')", :style => 'padding: 0; margin: 0;'
  end
end
