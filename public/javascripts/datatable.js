$(document).ready( function() {// When the Dom is ready	
	$('#users').dataTable({"bRetrieve":true,"sPaginationType": "full_numbers"});
	$('#users_timesheet').dataTable({"bRetrieve":true,"sPaginationType": "full_numbers"});
	$('#projects').dataTable({"bAutoWidth": true, "bLengthChange": false, "bPaginate": true,  "bInfo": false, "bRetrieve":true});
	$('#comments').dataTable({"bAutoWidth": true, "bLengthChange": false, "bPaginate": true,  "bInfo": false, "bRetrieve":true, "aaSorting": [[ 2, "asc" ]]});
	$('#companies2').dataTable({"bAutoWidth": true, "bLengthChange": false, "bPaginate": true,  "bInfo": false, "bRetrieve":true, "aaSorting": [[ 2, "asc" ]]});
	$('#companies').dataTable({"bRetrieve":true,"sPaginationType": "full_numbers"});
	$('#contacts').dataTable({"bRetrieve":true,"sPaginationType": "full_numbers"});
	$('#opportunities').dataTable({"bRetrieve":true,"sPaginationType": "full_numbers"});
	$('#projectlist').dataTable({"bRetrieve":true,"sPaginationType": "full_numbers"});
	$('#users').dataTable().columnFilter();
});
