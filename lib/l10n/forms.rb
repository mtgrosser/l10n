module L10n
  module Forms
    module FormBuilder
      
      def amount_field(field, options = {})
        value = L10n.number_to_rounded(object.send(field))
        options[:value] = value
        options[:class] = "#{options[:class]} amount_field"
        text_field(field, options)
      end
      
    end
  end
end


ActionView::Helpers::FormBuilder.class_eval do
  include L10n::Forms::FormBuilder
end
