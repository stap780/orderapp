$( document ).ready(function() {
	
	var id;
	var dataId;
$("#dover_items")
.on('cocoon:before-insert', function(e, insertedItem) {
       // alert('hi');
  var row = insertedItem; 
  id = row.children([0]).children([0]).children([0]).attr('id')
  console.log(id);
	})
	.bind('railsAutocomplete.select', function(event, data){
  dataId = data.item.id;
  console.log(dataId);
  $("input[id='"+id+"']").val(dataId);
});
   
   

 	
 	
 	});  
 

	function getloadID(id){
	 	var id = id;
	 	console.log(id);
$("input[id='"+id+"']")
	 	.bind('railsAutocomplete.select', function(event, data){
dataId = data.item.id;
console.log(dataId);
var number = id.match(/\d+/)[0]
$("input[id='dover_dover_items_attributes_"+number+"_product_id']").val(dataId);
});

	 	
 	}

