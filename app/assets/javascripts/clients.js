/*
$("#my_autocomplete_field").autocomplete(
{  
     select: function(event, ui) {
    console.log(ui);
         }
  });
*/
  
document.onreadystatechange = function () {
    if (document.readyState === "complete") {
      ready();
    }
  }
  
  function myclientInnFunction(val) {
	var searchinn = val;
	    console.log(searchinn);
	    }