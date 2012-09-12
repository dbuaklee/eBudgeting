<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<div class="row">
	
	<div class="span12" id="#menuDiv">
		<h2>Admin Menu</h2>
		<ol>
			<li id="newDatabaseSchema"><a href="#" onClick="confirmAndExec('newDatabaseSchema')">Create New Database Schema</a> <span class="label label-warning">Warning</span> All data will be lost! </li>
			<li id="populateSampleData"><a href="#" onClick="confirmAndExec('populateSampleData')">Populate Sample Data</a> </li>
		</ol>
	</div>
</div>

<script type="text/javascript">

function confirmAndExec(choice) {
	var r = confirm("You are sure?");
	if(r==true) {
		// only then we'll call newDatabaseSchema!
		if(choice == 'newDatabaseSchema') {
			newDatabaseSchema();
		} else if(choice == 'populateSampleData') {
			populateSampleData();
		}
		
	}
	
	return false;
}

function newDatabaseSchema() {
	$('#newDatabaseSchema').append('<span id="newDatabaseSchema_1"><img src="../resources/graphics/loading-small.gif"/></span>');
	
	$.get('newDatabaseSchema', function(data){		
		$('#newDatabaseSchema_1').html('<img src="../resources/graphics/green-check-mark.png"/> Done');
	});
}

function populateSampleData() {
	$('#populateSampleData').append('<span id="populateSampleData_1"><img src="../resources/graphics/loading-small.gif"/></span>');
	$.get('populateSampleData', function(data){
		$('#populateSampleData_1').html('<img src="../resources/graphics/green-check-mark.png"/> Done');
	});
}

</script>