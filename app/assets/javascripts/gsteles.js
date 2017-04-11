$(window).load(function() { //alert('load');

var gsteleIds = document.getElementsByClassName("gstele_id");

for (var i = 0; i < gsteleIds.length; i++) {
	
	$.ajax({
		type: "GET",
		dataType: "json",
		data: {product_option_id: 5, supplier_id: gsteleIds[i].innerHTML},
		url: "/variants/get_supplier_id_data",  
		success: function(data){
      if(data.length !== 0){
      $('.gstele_id').filter(function() {
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


