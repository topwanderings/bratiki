jQuery ->

  $(document).ready(()->
    $("#email").focus();
  )

  $("#email").live("click", () ->
    setTimeout(validate_email, 10)
  )

  $("#password").live("click", () ->
    setTimeout(validate_password, 10)
  )

  $("#email").live("keydown", () ->
    setTimeout(validate_email, 10)
  )

  $("#password").live("keydown", () ->
    setTimeout(validate_password, 10)
  )

  $(document).ajaxSend((e, xhr, options)->
    token = $("meta[name='csrf-token']").attr("content");
    xhr.setRequestHeader("X-CSRF-Token", token);
  );

  validate_email = ()->
    $("#email").css("background", "rgb(255, 255, 255)")
    $("#error_email").text("")

  validate_password = ()->
    $("#password").css("background", "rgb(255, 255, 255)")
    $("#error_password").text("")
