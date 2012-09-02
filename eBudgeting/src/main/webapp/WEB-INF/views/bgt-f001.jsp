<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
	    <ul class="breadcrumb">
		    <li><a href="dashboard">Home</a> <span class="divider">/</span></li>
		    <li><a href="#">ข้อมูลพื้นฐาน</a> <span class="divider">/</span></li>
		    <li class="active">บันทึกข้อมูลยุทธศาสตร์หน่วยงาน</li>
	    </ul>

		<h3>ปีงบประมาณ 2556</h3>
		
		<div class="table-menu">
			<button class="btn btn-mini btn-info"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</button>
			<button class="btn btn-mini btn-primary"><i class="icon icon-edit icon-white"></i> แก้ไข</button>
			<button class="btn btn-mini btn-danger"><i class="icon icon-trash icon-white"></i> ลบ</button> 	
		</div>
		
		<table class="table table-bordered">
			<thead>
				<tr>
					<td width="20"></td>
					<td width="50">ลำดับที่</td>
					<td>ชื่อยุทธศาสตร์</td>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>
							<input type="checkbox"/> </td>
						<td> 1. </td>
						<td> ยุทธศาสตร์การพัฒนาที่ดิน</td>
					</tr>
			</tbody>
		</table>
	</div>

</div>