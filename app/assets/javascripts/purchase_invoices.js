
		function addId() {
		var id;
		var dataId;
		//alert('hi');
		$("#purchase_invoice_items")
		.on('cocoon:before-insert', function(e, insertedItem) {
		// alert('hi');
		var row = insertedItem; 
		id = row.children('td').children([0]).children([0]).attr('id')
		console.log(id);
		})
		.bind('railsAutocomplete.select', function(event, data){
		dataId = data.item.id;
		console.log(dataId);
		$("input[id='"+id+"']").val(dataId);
		});
		}  
		
		function getloadID(id){
		var id = id;
		console.log(id);
		$("input[id='"+id+"']")
		.bind('railsAutocomplete.select', function(event, data){
		dataId = data.item.id;
		console.log(dataId);
		var number = id.match(/\d+/)[0]
		$("input[id='purchase_invoice_purchase_invoice_items_attributes_"+number+"_product_id']").val(dataId);
		});
		
		} 
    
    // калькулятор по позициям и итого
    function calculate(val) {
	var table = document.getElementById("purchase_invoice_items").lastChild.children;
	for ( var i = 0; i<table.length; i++ ) { 
	var row = table.item(i);
	var quantity = row.cells[2].firstChild.firstChild.value;
	var price = row.cells[3].firstChild.firstChild.value;
	var sum = quantity*price;
	row.cells[4].firstChild.firstChild.value = sum.toFixed(2);;
	};
	var rows = $("tr.nested-fields:visible");
	var tot=0;
	for ( var i = 0; i<rows.length; i++ ) {
	var row = rows[i];
	var sum = row.cells[4].firstChild.firstChild;
	if(parseInt(sum.value))
	        tot += parseFloat(sum.value);
	}
	document.getElementById('purchase_invoice_total_price').value = tot.toFixed(2);;
	};
	// 
    



	/////////////////
	
	  
	  
	/////////////////
 

//alert('load');

/*
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
*/


	
	
			
		
      
	
	
	 
