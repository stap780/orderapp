document.onreadystatechange = function () {
    if (document.readyState === "complete") {
      ready();
    }
  } //определяем что статус документа -> загрузился и определяем функцию

  function ready() {
	var x = document.getElementById("company_inn");
	x.addEventListener("mouseover", myFunction);
	function myFunction() {
	console.log("test");
	}
  }
    
	function myInnFunction(val) {
	var searchinn = val;
	    console.log(searchinn);
	    
	 if (searchinn)
     // $.ajax ({   ---> это формирует и передаёт запрос на метод getcompany в рэилс
    //    url: "/companies/getcompany?inn="+searchinn,
    //    type: 'GET',
	//})
	//}
	
	var datasearchinn = {"query": searchinn}
	$.ajax ({
	url: "https://dadata.ru/api/v2/suggest/party",
	dataType: 'json',
	headers: {"Authorization": "Token c06864b3c1082f24e05f15e674b38c30f906b427"},
	type: 'POST',
	contentType: 'application/json',
	data: JSON.stringify(datasearchinn),
	success: function (data) {
            $("#company_title").val(data["suggestions"][0]["data"]["name"]["short"]);
            $("#company_fulltitle").val(data["suggestions"][0]["data"]["name"]["full_with_opf"]);
            $("#company_kpp").val(data["suggestions"][0]["data"]["kpp"]);
            $("#company_ogrn").val(data["suggestions"][0]["data"]["ogrn"]);
            $("#company_okpo").val(data["suggestions"][0]["data"]["okpo"]);
            $("#company_uraddress").val(data["suggestions"][0]["data"]["address"]["data"]["postal_code"] + ' ' + data["suggestions"][0]["data"]["address"]["value"]);
            }
	})
	}
	
	function myBikFunction(val) {
	var searchbik = val;
	    console.log(searchbik);
	    
	 if (searchbik)
	
	var datasearchinn = {"query": searchbik}
	$.ajax ({
	url: "https://dadata.ru/api/v2/suggest/bank",
	dataType: 'json',
	headers: {"Authorization": "Token c06864b3c1082f24e05f15e674b38c30f906b427"},
	type: 'POST',
	contentType: 'application/json',
	data: JSON.stringify(datasearchinn),
	success: function (data) {
            $("#company_banktitle").val(data["suggestions"][0]["data"]["name"]["full"]);
            }
	})
	}