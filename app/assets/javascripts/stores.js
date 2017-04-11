
$(window).load(function() {
 // executes when complete page is fully loaded, including all frames, objects and images


var sumPricein = 0;
// iterate through each td based on class and add the values
var pricein = document.getElementsByClassName("pricein");
for (var i = 0; i < pricein.length; i++) {

    var value = pricein[i].innerHTML;
  sumPricein += parseFloat(value);
  var newsumPricein = sumPricein.toFixed(2);
    var s =document.getElementById("totalPricein");
  s.innerHTML = newsumPricein;
};
var sumPrice = 0;
// iterate through each td based on class and add the values
var price = document.getElementsByClassName("price");
for (var i = 0; i < price.length; i++) {

    var value = price[i].innerHTML;
  sumPrice += parseFloat(value);
  var newsumPrice = sumPrice.toFixed(2);
    var s =document.getElementById("totalPrice");
  s.innerHTML = newsumPrice;
};

});

   
/*
$(".pricein").each(function() {

    var value = $(this).text();
    // add only if the value is number
    if(!isNaN(value) && value.length != 0) {
        sumPricein += parseFloat(value).toFixed(2);
     alert(sumPricein);   
    }
    $('#totalPricein').text(sumPricein);
});
var sumPrice = 0;
// iterate through each td based on class and add the values
$(".price").each(function() {

    var value = $(this).text();
    // add only if the value is number
    if(!isNaN(value) && value.length != 0) {
        sumPrice += parseFloat(value).toFixed(2);
    }
    $('#totalPricein').text(sumPrice);
});
*/


