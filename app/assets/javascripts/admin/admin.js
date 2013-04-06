/**
 * Created with JetBrains RubyMine.
 * User: bratiki
 * Date: 6/23/12
 * Time: 10:54 AM
 * To change this template use File | Settings | File Templates.
 */

$(document).ajaxSend(function(e, xhr, options) {
    var token;
    token = $("meta[name='csrf-token']").attr("content");
    return xhr.setRequestHeader("X-CSRF-Token", token);
});

$(document).on('click', '.ActivateUser', function(){
    var user_id = $(this).parents('.User').attr('id');
    $.post('/admin/user/'+ user_id +'/activate');
    $('article').load('/admin section');
});