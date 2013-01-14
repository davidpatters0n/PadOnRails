/**
 * Function to check through the effort fields on the screen, and update the
 * value for total field.
 */
function updateTotal()
{
  var total = 0;
  //$(".dayinput").map( function() { total += $(this).val() * 8; } );
  $(".hourinput").map( function() { total += $(this).val() * 1; } );
 //$('input[name^="effort_"]').map(function() { total += $(this).val() * 1; });
  $('input[name^="effort_"]').map(function() {
    total += $(this).val() * (parseInt($(this).attr('name').substr(7))<4 ? 8 : 1);
  });

 
 
 
 
  $("#total").val( total );

  if( total >= 40 )
  {
    $("#total").removeClass( "total_low" );
    $("#total").addClass( "total_ok" );
  }
  else
  {
    $("#total").removeClass( "total_ok" );
    $("#total").addClass( "total_low" );
  }
}


/**
 * Submit the hidden effort form via AJAX
 */
function submiteffort(elem, tid) {
    $("#effort_hours").val($(elem).val());
    $("#task_id").val(tid);
    $("#effort_form").submit();
    /* $.post( "/submiteffort", )   */
}


/**
 * Validate the just-entered field value and update the total
 */
function validateUpdateTotal()
{
  if( ($(this).val()-0) != $(this).val() )
  {
    alert( "Invalid number" );
    $(this).val( "" );
  }
  else
  {
    submiteffort( this, $(this).attr('id').substring(7) );
    updateTotal();
  }
}

/**
 * Called when user uses the project selector
 */
function selectProject()
{
  if( $('#project_selector').val() == 'more' )
  {
    $.ajax('/timesheet/showalltasks');
  }
  else
  {
    $.ajax('/projects/' + $('#project_selector').val() + '/project_tasks.js');
  }
}

function initPage()
{
  updateTotal();
  //$(".dayinput").change( validateUpdateTotal );
  //$(".hourinput").change(validateUpdateTotal );
  $('input[name^="effort_"]').live( 'change', validateUpdateTotal );
  $('.toil').hide();
  $(".flip").click(function() { $(".toil").fadeToggle("slow", function () {}); });

  
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

  $("#effort_form").submitWithAjax();
}

function add() {
	$(document).ready( initPage );
}

$(document).ready( initPage );

function show()
{
	$('.toil').show();
}
