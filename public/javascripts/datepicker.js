$(function()
{
    var startDate;
    var endDate;
    var date;
    var selectCurrentWeek = function()
    {
        window.setTimeout(function () { $('.week-picker').find('.ui-datepicker-current-day a').addClass('ui-state-active')}, 1);
    }
    function check(d) {
        if(d.length() == 2) {
            dd = d;
            return dd;
        } else {
            dd = "0" + myDateParts[0];
            return dd;
        }
    }

    var selectedWeek;//remember which week the user selected here

    $('.week-picker').datepicker( {
        beforeShowDay: $.datepicker.noWeekends,
        showOtherMonths: true,
        selectOtherMonths: true,
        onSelect: function(dateText, inst) {
            var date = $(this).datepicker('getDate');
            startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 1);
            endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
            var dateFormat = 'yy-mm-dd'
            var newDate = $('#startDate').text($.datepicker.formatDate( dateFormat, startDate, inst.settings ));

            var oldDate = document.getElementById('startDate');
            var date_textnode = oldDate.firstChild;
            var date_text = date_textnode.data;
            myDateParts = date_text.split("-");

            var dd = myDateParts[2];

            var mm = myDateParts[1];

            var yy = myDateParts[0];

            selectCurrentWeek();
			
			var date = yy + "-" + mm + "-" + dd;
            window.location.href = "/timesheet?week_commencing=" + yy + "-" + mm + "-" + dd;

        },
        beforeShowDay: function(date) {

            var cssClass = '';
            if(date >= startDate && date <= endDate)
                cssClass = 'ui-datepicker-current-day';
            return [true, cssClass];
        },
        onChangeMonthYear: function(year, month, inst) {
            selectCurrentWeek();
        }
    });
    
    
    var selectDate = date;
    
    $('.week-picker').datepicker({
    	defaultDate: selectDate
    }).click(function(event) {
    	$(".ui-datepicker-current-day").parent().addClass('ui-state-hover');
    	//$(".ui-datepicker-current-day:eq(0)").siblings().find('a').addClass('white');
    }).click();

  
    $('.week-picker .ui-datepicker-calendar tr').live('mousemove', function() { $(this).find('td a').addClass('ui-state-hover'); });
    $('.week-picker .ui-datepicker-calendar tr').live('mouseleave', function() { $(this).find('td a').removeClass('ui-state-hover'); });


});
