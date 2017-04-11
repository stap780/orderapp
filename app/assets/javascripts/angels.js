$(window).load(function() {
var angelIds = document.getElementsByClassName("angel_id");

for (var i = 0; i < angelIds.length; i++) {
	
	$.ajax({
		type: "GET",
		dataType: "json",
		data: {product_option_id: 7, supplier_id: angelIds[i].innerHTML},
		url: "/variants/get_supplier_id_data",  
		success: function(data){
      if(data.length !== 0){
      $('.angel_id').filter(function() {
  var a = data[0].supplier_id;
  var searchString = a.toString();
        //console.log(searchString);
  return ($(this).html() === searchString);
}).parent().css("background-color", "#ddd");
}
}
});
}  


});
