  jQuery(function() {
  $('form').on('click', '.remove_fields', function(event) {
    $(this).closest('.field').remove();
    return event.preventDefault();
  });
  return $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).after($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });
  });
 
  jQuery(function() {
  $('#selectAll').click(function(){
  if (this.checked){
    $(':checkbox').each(function(){
      this.checked = true;
    });
  } else {
    $(':checkbox').each(function(){
      this.checked = false;
    });
  }
});
  });

