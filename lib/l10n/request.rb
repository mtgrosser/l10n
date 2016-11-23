module L10n
  module Request
    
    def accept_locales
      return [] if env['HTTP_ACCEPT_LANGUAGE'].blank?
      locale_groups = env['HTTP_ACCEPT_LANGUAGE'].split(',')
      preferred_locales = []
      for locale_group in locale_groups
        locale = locale_group.split(';')
        language_code, params = locale[0].to_s.strip, locale[1].to_s.strip
        if /\A[A-z]{2}(-[A-z]{2})?\z/.match(language_code)
          if params.present?
            name, value = params.split('=')
            q = (name == 'q' && value.to_f > 0 ? value.to_f : 1.0)
          else
            q = 1.0
          end
          preferred_locales << [language_code, q]
        end
      end
      preferred_locales.sort { |a, b| b.last <=> a.last }.map(&:first)
    end
        
  end
end

ActionDispatch::Request.class_eval { include L10n::Request }