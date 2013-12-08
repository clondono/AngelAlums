$(document).on("click", ".toggle-field", function() {
  var id = $(this).attr("id");
  
  $.ajax({
    url:'/admin_post', //Defined in your routes file
      data:(
        'highlight_id=' + id
      ),
      type: 'POST'
  })

});