# L10n - I18n that roarrrs

## Installation

```ruby
# Gemfile
gem 'l10n'
```

## Setting up your app

In your <language>.yml, make sure to have definitions for 

number:
  precision:
    format:
      separator: ","
      delimiter: "."
      precision: 2
      
As there is currently a bug in Rails: https://github.com/rails/rails/issues/4420

## Features

### ActiveRecord column translations

```ruby
class Fruit < ActiveRecord::Base
  # columns: name, name_de, name_fr
  
  translates :name
end

apple = Fruit.new(name: 'Apple', name_de: 'Apfel', name_fr: 'Pomme')

I18n.as(:en) { apple.name_t } => "Apple"
I18n.as(:de) { apple.name_t } => "Apfel"
I18n.as(:fr) { apple.name_t } => "Pomme"

apple.name_translations => { en: "Apple", de: "Apfel", fr: "Pomme" }
```

Translated columns also support validation:

```ruby
class Fruit < ActiveRecord::Base
  translates :name
  
  # all translation columns for "name" must be present
  validate :name, translation: true
end
```

### Core extensions

#### String and Symbol

```yaml
# de.yml
de:
  words:
    one: Eins
    two: Zwei
    three: Drei
    four: Vier
    five: Fünf
    
  hello: "Hallo %{name}!"
```

```ruby
I18n.locale = :de

'words.one'.t => 'Eins'

'hello'.t(name: 'Otto') => "Hallo Otto!"
```

This also works with symbols.

#### Formatting of numbers

```ruby
I18n.as('de') { 1234.5.to_formatted_s } => "1.234,50"
I18n.as('en') { 1234.5.to_formatted_s } => "1,234.50"
```

This also works with instances of BigDecimal.

#### Localization of decimal separator and delimiter for numbers

```ruby
I18n.as('de') { 1234.5.to_localized_s } => "1.234,5"
I18n.as('en') { 1234.5.to_localized_s } => "1,234.5"
```

#### Localization of decimal separator and delimiter for numeric strings

```ruby
I18n.as(:de) { Numeric.localize('1,234.50') } => "1.234,50"
I18n.as(:en) { Numeric.localize('1,234.50') } => "1,234.50"
```

### Automatic localization of numeric values in Rails forms and models

```ruby
# in your template
<%= form_for @car do |f| %>
  <% f.amount_field :price, precision: 2 %>
<% end %>

# in your controller, or elsewhere
# params => { car: { price: "12.000,00" } }

I18n.locale = :de
@car = Car.new(params[:car]).price => 12000

I18n.locale = :en
@car = Car.new(params[:car]).price => 12
```

### Accept-Language header parsing in ActionDispatch::Request

The Accept-Language header will be parsed, and locales will be returned ordered by user preference.

```ruby
# in your controller
request.accept_locales => ["en-US", "en", "en-GB"]
```

