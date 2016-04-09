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
    // пересчет суммы при удалении позиции из перечня товаров
$("#purchase_invoice_items").children('tbody')
.on('cocoon:before-remove', function(e, task) {
        $(this).data('remove-timeout',1000);
        task.fadeOut('slow');
        //task.css('display',null);
        })
.on('cocoon:after-remove', function(e, task) {
        //console.log($(this));
  var row = task;
  //console.log(row);
	var cells = row.children();
  var sum = cells[4].firstChild.firstChild;
  console.log(sum.value);
	var old_tot = document.getElementById('purchase_invoice_total_price').value
	var tot = parseInt(old_tot) - parseInt(sum.value);
	//};
	document.getElementById('purchase_invoice_total_price').value = tot;
	});

	 //$("#myclick").trigger("click"); // вызов (эмуляция) клика по элементу с id click. После чего вызывается функция привязанная к элементу 
	/////////////////
	
	
    }
  }
 