// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.


//= require jquery
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
    
    setTimeout(function() {
    $('#flash_messages').fadeOut('slow');
	}, 2900);
	
	
     
     $('#invoice_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
	$('#purchase_invoice_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
    
    $('#invoice_list_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
	
	/////////////////
	// поле загрузки файла
	$(":file").filestyle({buttonText: "Find file", size: "sm", placeholder: "No file"});
	/////////////////
	
   ///////////////// 
 /*
 document.getElementById('add_items').onclick = function() {
  //document.getElementById('purchase_invoice_number').value = "10" ;// при нажатии на кнопку добавить позицию меняется поле номер счета на 10
	
	
  };
*/
  /////////////////
    // проверка работы пересчета итого по клику на слово Статус c id  myclick - работает
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
	//
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
	// пересчет суммы при удалении позиции из перечня товаров в исходящем счете
	$("#invoice_items").children('tbody')
.on('cocoon:before-remove', function(e, task) {
        $(this).data('remove-timeout',1000);
        task.fadeOut('slow');
        })
.on('cocoon:after-remove', function(e, task) {
        //console.log($(this));
  var row = task; 
  //console.log(row);
	var cells = row.children();
  var sum = cells[3].firstChild.firstChild;
  //console.log(sum.value);
	var old_tot = document.getElementById('invoice_total_price').value;	
	var discount = document.getElementById("invoice_discount");
	if (parseInt(discount.value) > "0"){
	var newtot = parseFloat(old_tot).toFixed(2) - (parseFloat(sum.value).toFixed(2) - (parseFloat(sum.value) * parseFloat(discount.value)/100).toFixed(2)).toFixed(2);
	document.getElementById('invoice_total_price').value = newtot;
	} else {
	var old_tot = document.getElementById('invoice_total_price').value
	var tot = parseFloat(old_tot).toFixed(2) - parseFloat(sum.value).toFixed(2); 
	document.getElementById('invoice_total_price').value = tot;
	}

	
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
  
	
	
    }
  }
 