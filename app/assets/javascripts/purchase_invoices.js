 
    // калькулятор по позициям и итого
    function calculate(val) {
	var table = document.getElementById("purchase_invoice_items").lastChild.children;
	for ( var i = 0; i<table.length; i++ ) { 
	var row = table.item(i);
	var quantity = row.cells[2].firstChild.firstChild.value;
	var price = row.cells[3].firstChild.firstChild.value;
	var sum = quantity*price;
	row.cells[4].firstChild.firstChild.value = sum;
	};
	var rows = $("tr.nested-fields:visible");
	var tot=0;
	for ( var i = 0; i<rows.length; i++ ) {
	var row = rows[i];
	var sum = row.cells[4].firstChild.firstChild;
	if(parseInt(sum.value))
	        tot += parseInt(sum.value);
	}
	document.getElementById('purchase_invoice_total_price').value = tot;
	};
	// 
    
	
	

	/////////////////
	
	  
	  
	/////////////////
 
    
  
	
			
		
      
	
	
	 
