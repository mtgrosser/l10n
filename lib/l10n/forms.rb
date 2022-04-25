module L10n
  module Forms
    module FormBuilder
      
      def amount_field(field, options = {})
        options = objectify_options(options)
        format_options = options.extract!(:locale, :precision, :significant, :separator, :delimiter, :strip_insignificant_zeros)
        value = L10n.number_to_rounded(object.public_send(field), format_options)
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
