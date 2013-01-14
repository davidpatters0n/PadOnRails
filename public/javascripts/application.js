// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function updateTotal() {
	var total = 0;
	$(".dayinput").map(function() {
		total += $(this).val() * 8;
	});
	$(".hourinput").map(function() {
		total += $(this).val() * 1;
	});
	$("#total").val(total);
	if(total >= 40) {
		$("#total").removeClass("total_low");
		$("#total").addClass("total_ok");
	} else {
		$("#total").removeClass("total_ok");
		$("#total").addClass("total_low");
	}
}

function validateUpdateTotal() {
	if(($(this).val() - 0) != $(this).val()) {
		alert("Invalid number");
		$(this).val("");
	} else
		updateTotal();
}


function initPage() {
    
    $.ajaxSetup({
        'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
    })
    
    $.fn.submitWithAjax = function() {
        this.submit(function() {
            $.post(this.action, $(this).serialize(), null, "script");
            return false;
        });
        return this;
    };

    $(".groups").hide();
    $(".hidden").hide();
    $(".hours").hide();
    $(".widget").hide();
    $(".second").hide();
    $("#hour").click(function() {
        $(".hours").fadeIn(1000);
        $(".second").fadeIn(1000);
    });
    $(".dayinput").change(validateUpdateTotal);
    $(".hourinput").change(validateUpdateTotal);
   function log(message) {
        $( "<div/>" ).text( message ).prependTo("#log");
    }

    $(".managerlist").autocomplete({
    	minLength: 2,
        source: function(request, response) {
            $.ajax({
                url: "/managerlist",
                dataType: "json",
                data: {
                    style: "full",
                    maxRows: 12,
                    term: request.term
                },
                success: function(data) {
                    var results = [];
                    $.each(data, function(i, item) {
                        var itemToAdd = {
                            value: item,
                            label: item
                        };
                        results.push(itemToAdd);
                    });
                    return response(results);
    
                }
            });
        }
    });

  function log(message) {
        $( "<div/>" ).text( message ).prependTo("#log");
    }

    $("#tags1").autocomplete({
    	minLength: 2,
        source: function(request, response) {
            $.ajax({
                url: "/positionlist",
                dataType: "json",
                data: {
                    style: "full",
                    maxRows: 12,
                    term: request.term
                },
                success: function(data) {
                    var results = [];
                    $.each(data, function(i, item) {
                        var itemToAdd = {
                            value: item,
                            label: item
                        };
                        results.push(itemToAdd);
                    });
                    return response(results);
    
                }
            });
        }
    });
}

$(document).ready(initPage);

function remove_fields(link) {
	//$(link).prev("input[type=hidden]").value = "1";
	//$(link).parent(".fields").hide();
	//$(link).parent('tr').remove();
	$(link).remove();
}
function add_fields(link, association, content) {  
    var new_id = new Date().getTime();  
    var regexp = new RegExp("new_" + association, "g");  
    $(link).parent().before(content.replace(regexp, new_id));  
}

function hiddenFields() {
	$(".group").hide();
};







