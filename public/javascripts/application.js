// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function selectBoxOption(obj, selector, svalue){
  for (var i = 0; i < obj.options.length; i++) {
    if (selector == "value") {
      if (obj.options[i].value == svalue) {
        obj.options[i].selected = true;
      }
    }

    if (selector == "text") {
      if (obj.options[i].text == svalue) {
        obj.options[i].selected = true;
      }
    }
  }
}
