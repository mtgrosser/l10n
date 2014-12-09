var I18n = I18n || {};

I18n.translate = function(str, options) {
  options = options || {};
  var fallback = options['fallback'] || ('Translation missing: ' + str);  // default is a JS reserved word
  var translation, matches, method, match, interpolation_value;
  var count = options['count'];
  var keys = str.split('.');
  var obj = this.translations;
  while(obj && keys.length) obj = obj[keys.shift()];
  if (obj) {
    if ($.type(obj) == 'object' && count !== undefined) {
      translation = obj[1 == count ? 'one' : 'other'];
    } else {
      translation = obj;
    }
    if ($.type(translation) == 'string' && (matches = translation.match(/{\w+?}/g))) {
      while(match = matches.shift()) {
        method = match.substr(1, match.length - 2);
        interpolation_value = options[method];
        if (interpolation_value == undefined) interpolation_value = ('undefined interpolation value: ' + method);
        translation = translation.replace(new RegExp(match, 'g'), interpolation_value);
      }
    }
  }
  return translation || fallback;
};

I18n.t = function(str, options) {
  return this.translate(str, options);
};

String.prototype.t = function(options){ return(I18n.translate(this, options)); }
