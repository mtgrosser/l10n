const I18n = {
  translate: function(str, options, data) {
    options = options || {};
    var fallback = options['fallback'] || ('Translation missing: ' + str);  // default is a JS reserved word
    var translation, matches, method, match, interpolation_value;
    var count = options['count'];
    var keys = str.split('.');
    var obj = data || this.translations;
  
    var isString = function(value) {
      return typeof value === 'string' || value instanceof String;
    };
  
    var isObject = function(value) {
      return value && typeof value === 'object' && value.constructor === Object;
    };
  
    while(obj && keys.length) obj = obj[keys.shift()];
    if (obj) {
      if (isObject(obj) && count !== undefined) {
        translation = obj[1 == count ? 'one' : 'other'];
      } else {
        translation = obj;
      }
      if (isString(translation) && (matches = translation.match(/{\w+?}/g))) {
        while(match = matches.shift()) {
          method = match.substr(1, match.length - 2);
          interpolation_value = options[method];
          if (interpolation_value == undefined) interpolation_value = ('undefined interpolation value: ' + method);
          translation = translation.replace(new RegExp(match, 'g'), interpolation_value);
        }
      }
    }
    return translation || fallback;
  },
  
  t: function(str, options, data) {
    return this.translate(str, options, data);
  },
  
  translations: {}

};

export default I18n;
