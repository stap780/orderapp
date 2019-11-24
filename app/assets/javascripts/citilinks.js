$(window).load(function() {

var ctIds = document.getElementsByClassName("ct_id");

for (var i = 0; i < ctIds.length; i++) {
	
	$.ajax({
		type: "GET",
		dataType: "json",
		data: {product_option_id: 12, supplier_id: ctIds[i].innerHTML},
		url: "/variants/get_supplier_id_data",  
		success: function(data){
      if(data.length !== 0){
      $('.ct_id').filter(function() {
  var a = data[0].supplier_id;
  var searchString = a.toString();
        //console.log(searchString);
  return ($(this).html() === searchString);
}).parent().css("background-color", "#ddd");
}
}
});
}  

$('[data-toggle="popover"]').popover({
    container: 'body'
  }); 





});