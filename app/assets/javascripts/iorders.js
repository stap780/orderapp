
var do_on_load = function() { 
  var myready = document.getElementById("q_payment_cont");
	myready.addEventListener("mouseover", myFunction);
		function myFunction() {
		a = myready.value;
	console.log(a);
	};
}
$(document).ready(do_on_load)
$(window).bind('page:change', do_on_load)