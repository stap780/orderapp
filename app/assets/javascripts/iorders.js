jQuery(function() {
/* alert('load'); */
$( document ).ready(function ()  {
var clientId = document.getElementById('iorder_client_id').value;
/* alert(clientId); */
	$.ajax({
		type: "GET",
		dataType: "json",
		data: {client_id: clientId},
		url: "/iorders/get_client_data",  
		success: function(data){
		$('#iorder_client_name').val(data[0].name);
		$('#iorder_client_middlename').val(data[0].middlename);
		$('#iorder_client_surname').val(data[0].surname);
		$('#iorder_phone').val(data[0].phone);
		$('#iorder_email').val(data[0].email);
		$('#iorder_shipping_zip').val(data[0].zip);
		$('#iorder_shipping_city').val(data[0].city);
		$('#iorder_shipping_address').val(data[0].address);
		}
	});
});


});