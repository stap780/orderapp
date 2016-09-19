// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.


//= require jquery
//= require jquery.turbolinks
//= require cocoon
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require autocomplete-rails
//= require bootstrap
//= require datepicker
//= require bootstrap-filestyle
//= require_tree .



 document.onreadystatechange = function () {
    if (document.readyState === "complete") {
	    
	    $('#notice').addClass('animated bounceOutLeft');
    
    setTimeout(function() {
    $('#flash_messages').fadeOut('slow');
	}, 2900);
	
	
     
     $('#invoice_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
    
    $('#invoice_list_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
	
	$('#invoiceout_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
	
	$('#purchase_invoice_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
	
	$('#purchase_list_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
	
	$('#pl_date').datepicker({
     format: "dd/mm/yyyy",
    autoclose: true
	})
	
	$('#purchase_list_purchase_invoice_in_attributes_data').datepicker({
     format: "dd/mm/yyyy",
    autoclose: true
	})
/*
	if ($("#add_pii_info").is(":checked")){
	 	    //alert('hi');
	 	    var a = $('#purchase_list_purchase_invoice_in_attributes_data').val();
	alert(a);
	 	    }
*/


	/////////////////
	// поле загрузки файла
	$(":file").filestyle({buttonText: "Find file", size: "sm", placeholder: "import"});
	/////////////////
	
   ///////////////// 
 /*
 document.getElementById('add_items').onclick = function() {
  //document.getElementById('purchase_invoice_number').value = "10" ;// при нажатии на кнопку добавить позицию меняется поле номер счета на 10
	
	
  };
*/
  /////////////////
    // проверка работы пересчета итого по клику на слово Статус c id  myclick - работает
/*
    $( "#myclick" ).bind("click", (function ()  {
    
	var rows = $('.nested-fields:visible');
	var tot=0;
	for ( var i = 0; i<rows.length; i++ ) {
	var row = rows[i];
	var sum = row.cells[4].firstChild.firstChild;
	if(parseInt(sum.value))
	        tot += parseInt(sum.value);
	}
	document.getElementById('purchase_invoice_total_price').value = tot;
	alert("Status is clicked!");
	}));
*/
	//
	/////////////////
	// доп поля во входящем счете для накладной
	if ($('#add_pl_info').prop( "checked" )){
	$('.pl_info').show();
	} else {
	$('.pl_info').hide(); 
	}; 

	$('#add_pl_info').click(function(){
	if (this.checked){
	$('.pl_info').show();
	} else {
	$('.pl_info').hide();
	}  
	}); 
		/////////////////
	// доп поля во входящей накладной для сч-ф
	if ($('#add_pii_info').prop( "checked" )){
	$('.pii_info').show();
	} else {
	$('.pii_info').hide(); 
	}; 
	
	$('#add_pii_info').click(function(){
	if (this.checked){
	$('.pii_info').show();
	} else {
	$('.pii_info').hide();
	}  
	}); 
	
    /////////////////

    /////////////////
    // пересчет суммы при удалении позиции из перечня товаров во входящем счете
$("#purchase_invoice_items").children('tbody')
.on('cocoon:before-remove', function(e, task) {
        $(this).data('remove-timeout',1000);
        task.fadeOut('slow');
        })
.on('cocoon:after-remove', function(e, task) {
        //console.log($(this));
  var row = task; // за счет task мы получаем нашу строку которую как-бы удаляем (скрываем из видимости)
  //console.log(row);
	var cells = row.children();
  var sum = cells[4].firstChild.firstChild;
  //console.log(sum.value);
	var old_tot = document.getElementById('purchase_invoice_total_price').value
	var tot = parseFloat(old_tot).toFixed(2) - parseFloat(sum.value).toFixed(2);
	//};
	document.getElementById('purchase_invoice_total_price').value = tot;
	//$("#myclick").trigger("click"); // вызов (эмуляция) клика по элементу с id click. После чего вызывается функция привязанная к элементу 
	});

	 
	/////////////////
	
	$( "#skidka_click" ).bind("click", (function ()  {
	//alert("Skidka is clicked!");
	var table = $('#products');
	var rows = table.children();
	for ( var i = 0; i<rows.length; i++ ) {
	var row = rows[i];
	var price = row.cells[7].innerHTML;
	var skidka = document.getElementById('skidka');
	var sell = (parseFloat(price).toFixed(2) - (parseFloat(price)*parseFloat(skidka.value)/100).toFixed(2)).toFixed(2);
	row.cells[6].innerHTML = sell;
	}
	
	}));
  /////////////////


/////////////////
// Функция подсвечивающая строки товаров по поставщикам которые синхронизируются. Есть второй вариант - например поставщик Цифровой ангел (Angel.js).
var Ids = document.getElementsByClassName("id");
var poi = document.getElementById("product_option_id")
for (var i = 0; i < Ids.length; i++) {
	
	$.ajax({
		type: "GET",
		dataType: "json",
		data: {product_option_id: poi.innerHTML, supplier_id: Ids[i].innerHTML},
		url: "/variants/get_supplier_id_data",  
		success: function(data){
      if(data.length !== 0){
      $('.id').filter(function() {
  var a = data[0].supplier_id;
  var searchString = a.toString();
        //console.log(searchString);
  return ($(this).html() === searchString);
}).parent().css("background-color", "#ddd");
}
}
});
}
 ///////////////// 
 //почему-то не грузится скрипт из iorders.js и я скопировал сюда. Происходит подстановка по id данных клиента в форме заказа
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
 ///////////////// 

 ///////////////// 
  
	
	
    }
  }
 