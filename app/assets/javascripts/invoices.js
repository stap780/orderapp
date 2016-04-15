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
	if (parseInt(discount.value) > "0"){
	var newtot = tot - tot * parseInt(discount.value)/100;
	document.getElementById('invoice_total_price').value = newtot;
	} else { 
	document.getElementById('invoice_total_price').value = tot;
	}
	};
	// 
	
