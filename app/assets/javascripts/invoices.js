

$( document ).ready(calculateInvoice);

// калькулятор по позициям и итого
    function calculateInvoice(val) {
	var table = document.getElementById("invoice_items").lastChild.children;
	for ( var i = 0; i<table.length; i++ ) { 
	var row = table.item(i);
	var quantity = row.cells[1].firstChild.firstChild.value;
	var price = row.cells[2].firstChild.firstChild.value;
	var sum = quantity*price;
	row.cells[3].firstChild.firstChild.value = sum;
	};
	var rows = $("tr.nested-fields:visible");
	var tot=0;
	for ( var i = 0; i<rows.length; i++ ) {
	var row = rows[i];
	var sum = row.cells[3].firstChild.firstChild;
	if(parseInt(sum.value))
	        tot += parseInt(sum.value);
	}
	var discount = document.getElementById("invoice_discount");
	var delivery = $('.delivery').html();
	if (parseInt(discount.value) > "0"){
	var newtot = tot - tot * parseInt(discount.value)/100 ;
	document.getElementById('invoice_total_price').value = newtot;
	} else { 
	document.getElementById('invoice_total_price').value = tot ;
	}
	};
	// 
	
$( document ).ready(function() {
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
	var delivery = $('.delivery').html();
	if (parseInt(discount.value) > "0"){
	var newtot = parseFloat(old_tot).toFixed(2) - (parseFloat(sum.value).toFixed(2) - (parseFloat(sum.value) * parseFloat(discount.value)/100).toFixed(2)).toFixed(2) ;
	document.getElementById('invoice_total_price').value = newtot;
	} else {
	var old_tot = document.getElementById('invoice_total_price').value
	var tot = parseFloat(old_tot).toFixed(2) - parseFloat(sum.value).toFixed(2); 
	document.getElementById('invoice_total_price').value = tot;
	}

	
	});
	
});
