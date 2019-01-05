$(document).ready(function(){

//  $(':input:enabled:visible:first').focus();

  $("form#new_exam").submit(function(){
    $('div#newexamloader').show();
  });

// FIXME: try to find why autogrow makes problems for IE
  $('textarea.autogrow').autogrow();

  // show submit only when javascript is disabled
  $('#exam_question_submit').hide();

});

