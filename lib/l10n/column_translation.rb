module L10n
  module ColumnTranslation
    
    def self.included(base)
      base.extend ClassMethods
      base.class_attribute :translated_attributes
      base.translated_attributes = []
    end
    
    module ClassMethods
      def translates(*attrs)
        self.translated_attributes = (translated_attributes + attrs).map(&:to_sym).uniq
        
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
            I18n.translation_language_codes.each do |language_code|
              translations[language_code] = read_attribute("#{attr_name}_#{language_code}")
            end
            translations
          end
          define_method "#{attr_name}_translations=" do |translations|
            translations = translations.dup
            if all = translations.delete(:all)
              send("#{attr_name}=", all)
              I18n.translation_language_codes.each do |language_code|
                method_name = "#{attr_name}_#{language_code}="
                send(method_name, all) if respond_to?(method_name)
              end
            end
            translations.each do |language_code, value|
              method_name = "#{attr_name}_#{language_code}="
              send(method_name, value) if respond_to?(method_name)
            end
          end
        end
        self.translated_attributes.each { |attr_name| definition_context.call attr_name }
      end
      
      def translates?(attr_name)
        translated_attributes.map(&:to_s).include?(attr_name.to_s)
      end
      
      def translated_column_name?(name)
        !!column_language_code(name)
      end
      
      def column_language_code(name)
        name = name.to_s
        return I18n.default_language_code if translates?(name)
        if match = name.match(/_([a-z]{2})\z/) and I18n.translation_language_codes.map(&:to_s).include?(code = match.captures.first)
          code.to_sym
        end
      end
      
      def translate_column_name(column_name_t, language_code = nil)
        name = column_name_t.to_s
        if name.ends_with?('_t') and translates?(name[0..-3])
          "#{name[0..-3]}#{I18n.translation_suffix(language_code)}".to_sym
        else
          column_name_t
        end
      end

    end

  end
end

ActiveRecord::Base.class_eval { include L10n::ColumnTranslation }