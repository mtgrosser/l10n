module L10n
  module ColumnTranslation
    
    def self.included(base)
      base.extend ClassMethods
      base.class_attribute :translated_attributes, :translation_options
      base.translated_attributes = []
      base.translation_options = {}
    end
    
    module ClassMethods
      def translates(*attrs)
        self.translation_options = attrs.last.is_a?(Hash) ? attrs.pop : {}
        self.translated_attributes = attrs
        
        definition_context = Proc.new do |attr_name|
          define_method "#{attr_name}_t" do
            read_attribute("#{attr_name}#{I18n.translation_suffix}")
          end
          define_method "#{attr_name}_t_with_fallback" do
            default_value = read_attribute(attr_name)
            if I18n.default?
              localized_value = default_value
            else
              localized_value = read_attribute("#{attr_name}_#{I18n.language_code}")
              localized_value = default_value if localized_value.blank?
            end
            localized_value
          end
          define_method "#{attr_name}_t=" do |value|
            write_attribute "#{attr_name}#{I18n.translation_suffix}", value
          end
          define_method "#{attr_name}_#{I18n.default_language_code}" do
            read_attribute attr_name
          end
          define_method "#{attr_name}_#{I18n.default_language_code}=" do |attr_value|
            write_attribute attr_name, attr_value
          end
          define_method "#{attr_name}_translations" do
            translations = { I18n.default_language_code => read_attribute(attr_name) }
            (I18n.supported_language_codes - [I18n.default_language_code]).each do |language_code|
              translations[language_code] = read_attribute("#{attr_name}_#{language_code}")
            end
            translations
          end
          define_method "#{attr_name}_translations=" do |translations|
            translations.each do |language_code, value|
              method_name = "#{attr_name}_#{language_code}="
              send("#{attr_name}_#{language_code}=", value) if respond_to?(method_name)
            end
          end
        end
        self.translated_attributes.each { |attr_name| definition_context.call attr_name }
      end
      
      def translates?(attr_name)
        translated_attributes.map(&:to_s).include?(attr_name.to_s)
      end
      
      def translate_column_name(column_name_t)
        column_name_t = column_name_t.to_s
        if column_name_t.ends_with?('_t') and translates?(column_name_t[0..-3])
          "#{column_name_t[0..-3]}#{I18n.translation_suffix}"
        else
          column_name_t
        end
      end

    end

  end
end

ActiveRecord::Base.class_eval { include L10n::ColumnTranslation }