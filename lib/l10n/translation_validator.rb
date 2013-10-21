module L10n
  class TranslationValidator < ActiveModel::EachValidator
    def self.kind
      :translation
    end

    def validate_each(record, attribute, value)
      translations = record.public_send("#{attribute}_translations")
      I18n.available_language_codes.each do |language_code|
        if translations[language_code].blank?
          record.errors.add(record.class.translate_column_name("#{attribute}_t", language_code), options[:message] || :blank)
        end
      end
    end
  end
end

module ActiveModel
  module Validations
    module HelperMethods
      def validates_translation_of(*attr_names)
        validates_with L10n::TranslationValidator, _merge_attributes(attr_names)
      end
    end
  end
end
