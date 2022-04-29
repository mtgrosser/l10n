[![Gem Version](https://badge.fury.io/rb/l10n.png)](http://badge.fury.io/rb/l10n)
[![build](https://github.com/mtgrosser/l10n/actions/workflows/build.yml/badge.svg)](https://github.com/mtgrosser/l10n/actions/workflows/build.yml)

# L10n - I18n that roarrrs

L10n provides some useful extensions for Rails I18n, including column translations,
localization of numeric form fields and JavaScript translation support.

## Installation

```ruby
# Gemfile
gem 'l10n'
```

## Setting up your app

In your `<locale>.yml`, make sure to have definitions for 

```yaml
number:
  precision:
    format:
      delimiter: "."
```

## Features

### Active Record attribute translations

Translated attributes provide an `<attr>_t` suffix, which maps to the column determined by the current locale. There is no whatsoever "magic" remapping of actual attributes. The `<attr>_t` accessor is used exclusively for mapping to the column referred to by the current locale.

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

The `<attr>_t` and `<attr>_translations` setters map to the current locale:
```ruby
pear = Fruit.new
pear.name_translations = { en: 'Pear', de: 'Birne', fr: 'Poire' }

I18n.locale = :fr
pear.name => "Pear"
pear.name_t => "Poire"

I18n.locale = :en
pear.name => "Pear"
pear.name_t => "Pear"
pear.name_t = 'Williams Christ'
pear.name => "Williams Christ"
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

Strings and symbols provide a `translate` method, aliased as `t` which maps to `I18n.t`.

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

#### Formatting of numbers

Calling `to_lfs` on `Numeric`s returns the number as a localized formatted string.
The format is defined by the current locale and respects the decimal delimiters
and separators defined in your `<locale>.yml`.

```ruby
I18n.as('de') { 1234.5.to_formatted_s } => "1.234,50"
I18n.as('en') { 1234.5.to_formatted_s } => "1,234.50"
```

This also works with `BigDecimal`s.

#### Localization of decimal separator and delimiter for numbers

Localization converts decimal separators and delimiters between locales without
re-formatting strings. `to_localized_s` can be called on any object.

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

The `amount_field` form helper automatically formats numbers in the current locale.
Numeric columns automatically convert the localized strings into numbers,
respecting decimal delimiters and separators.

```ruby
# in your template
<%= form_for @car do |f| %>
  <%= f.amount_field :price, precision: 2 %>
<% end %>

# in your controller, or elsewhere
# params => { car: { price: "12.000,00" } }

I18n.locale = :de
@car = Car.new(params[:car]).price => 12000

I18n.locale = :en
@car = Car.new(params[:car]).price => 12
```

### Accept-Language header parsing in ActionDispatch::Request

The `Accept-Language` HTTP header will be parsed, and locales will be returned ordered
by user preference. This comes in handy when setting the current locale in a `before_action`.

```ruby
# in your controller
request.accept_locales => ["en-US", "en", "en-GB"]
```

### Javascript I18n, interpolation and pluralization

Due to the many different options of integrating JavaScript, the `l10n.js` file
is no longer provided as a standard Rails asset. Instead, it can be installed
manually using

```sh
rake l10n:install:js
```

Place your JavaScript translations below the `javascript` key:

```yaml
# en.yml
en:
  javascript:
    hello: Hello {name}!
    
    apple:
      one: '{count} apple'
      other: '{count} apples'
```

Import the module:

```javascript
import I18n from 'l10n';
```

Render the translations either as JSON via an endpoint, or include them in a
`script` tag:

```ruby
I18n.t(:javascript).to_json
```

Depending on the way the module is integrated, the translations can either be
set on the `I18n` object:

```javascript
import I18n from 'l10n';
window.I18n = I18n;
I18n.translations = { "hello": "Hello {name}!", "apple": { "one": "{count} apple", "other": "{count} apples" } };

I18n.t("hello", { name: "JS" }) => "Hello JS!"
I18n.t("apple", { count: 5 }) => "5 apples"
```

or you can supply them as an argument to the `translate` function:

```javascript
const translations = { "hello": "Hello {name}!", "apple": { "one": "{count} apple", "other": "{count} apples" } };

I18n.t("hello", { "name": "JS"}, translations)  => "Hello JS!"
I18n.t("apple", { count: 5 }, translations) => "5 apples"
```
