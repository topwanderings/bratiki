
jQuery ->

  $("#subject").live("change", () -> 
    setTimeout(change_subject, 10)
    )

  change_subject = () ->
    subject = $("select#subject :selected").val();
    if subject
      subject = subject
    else
      subject = 0
    jQuery.get('/teacher/update_subject_select/' + subject, (data)->($("#group").parent('p').html(data)));
