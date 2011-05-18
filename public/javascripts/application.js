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

$(document).keyup(function(e) {
  if (e.keyCode == 27) {
      $('#servermgmt_overlay').hide();
  }
});

$(document).ready( function(){

  $("#sshuser_username").autocomplete({
      source: [  ]
  });

  if ($("#sshuser_server_id").length > 0 ) {
     $("#sshuser_server_id").change(function(){
         var server_id = $("#sshuser_server_id").val();
         if (server_id) {
             $.ajax({
                 url: '/servers/' + server_id + '/puppet_userlist',
                 type: 'get',
                 dataType: 'script'
             });
         }
     });
  }
  
  $("#servermgmt_overlay_close_btn").click(function() {
    $("#servermgmt_overlay").hide();
  });

  $(".sshkey_draggable").draggable({ revert: true, zIndex: +9999999, cursor: 'crosshair', helper: 'clone'  });
  $(".sshkeygroup_draggable").draggable({ revert: true, zIndex: +9999999, cursor: 'crosshair', helper: 'clone'  });

  $(".sshuser_dropable").droppable({
      hoverClass: 'drophover',
      drop: function( event, ui ) {
          var sshuser_div = $(this).attr('data-divname');
          var sshkey_type = ui.draggable.attr('data-keytype');
          var sshuser_id = $(this).attr("data-id");
          var sshkey_id = ui.draggable.attr('data-id');
          var post_request = "";
          if (sshkey_type == "sshkeygroup") {
              post_request = "&sshuser_mbr[sshkey_group_id]=" + sshkey_id
          }
          else {
              post_request = "&sshuser_mbr[sshkey_id]=" + sshkey_id
          }
          $.ajax({
              url: "/sshusers/" + sshuser_id + "/sshuser_mbrs",
              type: "post",
              dataType: 'script',
              data:  "ajax_from=sshkeymgmts" + post_request + "&sshuser_mbr[sshuser_id]=" + sshuser_id + "&ajax_div=" + sshuser_div
          });
      }

  });

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

