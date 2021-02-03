$(document).ready(function(){
	if($("#plan_currency").val() == ""){
		var row = "<option value=\"" + "" + "\">" + "Select Country" + "</option>";
		$(row).appendTo("#plan_country").prop('selected', true);
	}
	$(document).on('change', '#plan_country', function(evt){
	  var country_code = $("#plan_country").val();
	  $.ajax({
	    url: "/admin/plans/" + country_code + "/get_currency_code",
	    type: "GET",
	    dataType: "html", 
	    data: { "id": country_code }, 
	    error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus);
      },
      success: function(data, textStatus, jqXHR) {
      	$("#plan_currency").val(data);
      }
	  });
	});
});