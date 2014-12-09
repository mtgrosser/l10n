module L10n
  module JavaScriptHelper
  
    def i18n_script_tag
      javascript_tag %<
      var I18n = I18n || {};
      
      I18n.locale = function() {
        return("#{I18n.locale}");
      };
      
      I18n.translations = #{I18n.t(:javascript).to_json};
      >
    end
    
  end
end