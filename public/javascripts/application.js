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

$(document).ready( function(){
  
  $("#servermgmt_overlay_close_btn").click(function() {
    $("#servermgmt_overlay").hide();
  });

  
  $(".sshkey_draggable").draggable();

  $('#sshkey_search_box_clear').click(function() {
    $('#sshkey_search_box').val("");
    $('#sshkey_search_box').keyup();
  });
  $('#sshkey_search_box').keyup(function() {
    dataType = $.ajaxSettings && $.ajaxSettings.dataType;
    $.ajax({
      url: "/sshkeys.js",
      method: "post",
      dataType: 'script',
      data: "search=" + $('#sshkey_search_box').val(),
    });
  });

  $('#sshkey_groups_search_box_clear').click(function() {
    $('#sshkey_groups_search_box').val("");
    $('#sshkey_groups_search_box').keyup();
  });
  $('#sshkey_groups_search_box').keyup(function() {
    dataType = $.ajaxSettings && $.ajaxSettings.dataType;
    $.ajax({
      url: "/sshkey_groups.js",
      method: "post",
      dataType: 'script',
      data: "search=" + $('#sshkey_groups_search_box').val(),
    });
  });
});

