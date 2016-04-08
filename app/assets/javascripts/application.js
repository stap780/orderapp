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
    
    $('#invoice_list_date').datepicker({
     format: "dd/mm/yyyy",
    weekStart: 1,
    autoclose: true
	})
   ///////////////// 
  document.getElementById('add_items').onclick = function() {
  //document.getElementById('purchase_invoice_number').value = "10" ;// при нажатии на кнопку добавить позицию меняется поле номер счета на 10
	
	
  };
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
        

    
  /*
$("#purchase_invoice_items").on('click',"a.remove_fields",function(){
    var rows = $('#purchase_invoice_items').children().last().children();
    //console.log(rows);
	var tot=0;
	var newrows = rows.filter(function() {;
	return $(this).css('display') === 'none';
	});    
	console.log(newrows);
	for ( var i = 0; i<newrows.length; i++ ) {
	var row = newrows[i];
	var sum = row.cells[4].firstChild.firstChild;
	if(parseInt(sum.value))
	        tot += parseInt(sum.value);
	}
	var realtot = document.getElementById('purchase_invoice_total_price').value;
	var newtot = parseInt(realtot) - parseInt(tot);
	document.getElementById('purchase_invoice_total_price').value = newtot;
  //alert("Remove is clicked!");
	//$("#myclick").trigger("click"); // вызов (эмуляция) клика по элементу с id click. После чего вызывается функция привязанная к элементу
	});
*/
	
    /////////////////
    $("#purchase_invoice_items").on('cocoon:before-remove', function() {
        // allow some time for the animation to complete
        var a = $(this).data('remove-timeout')
        alert(a.value);
      });

	  
	/////////////////
	
	
    }
  }
 