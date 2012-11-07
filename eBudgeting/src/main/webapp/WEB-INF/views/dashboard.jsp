<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="row">
	<div class="span12" id="#menuDiv">
		
	</div>
</div>

<div class="row">
	<div class="span12">
		<div id="menuDiv"></div>
	</div>
</div>

<script id="menuTemplate" type="text/x-handlebars-template">
{{#each this}}
<div style="margin-bottom: 25px;">
	<h3 style="margin-bottom: 0px;">{{name}}</h3>
	<ul style="padding-top:0px;">
		{{#each menus}}
			<li>
				{{#if disabled}} 
					{{name}}
				{{else}}
					<a href="{{link}}" >{{name}}</a>
				{{/if}}
			</li>
		{{/each}}
	</ul>
</div>
{{/each}}
</script>

<sec:authorize access="hasRole('ROLE_USER_PLAN')">
<script type="text/javascript">
var ROLE_USER_PLAN = true;
</script>
</sec:authorize>


<script type="text/javascript">
var menuJson = [{
	name: "ข้อมูลพื้นฐานหน่วยงาน",
	menus: [{name: "m1f01: โครงสร้างหมวดงบประมาณ", link:"jsp/m1f01", disabled: "disabled"},
	        {name: "m1f02: หน่วยงานภายใน", link: "jsp/m1f02", disabled: "disabled"},
	        {name: "m1f03: ข้อมูลหน่วยนับเป้าหมาย", link: "page/m1f03/"},
	        {name: "m1f05: เพิ่มข้อมูลเริ่มต้นปีงบประมาณ", link: "page/m1f05/"}]
},{
	name: "ระบบจัดทำคำขอตั้ง",
	menus: [ {name: "m2f14: ข้อมูลเป้าหมาย", link: "page/m2f14/"},
	        {name: "m2f13: กำหนดงบประมาณพื้นฐาน (default) ของหมวดงบประมาณ", link: "page/m2f13/"},
	        {name: "m2f11: การกำหนดระดับชั้นของแผนงาน", link: "page/m2f11/"},
	        {name: "m2f06: โครงสร้างแผนงาน/กิจกรรม/ตัวชี้วัด/หน่วยงานปฏิบัติ", link: "page/m2f06/"},
	        {name: "m2f12: บันทึกข้อมูลงบประมาณ", link: "page/m2f12/", user: true},
	        {name: "m2f10: วิสัยทัศน์-พันธกิจ หน่วยงาน", link: "jsp/m2f10"},
	        {name: "m2f08: กลยุทธ์หน่วยงาน", link: "jsp/m2f08", disabled: "disabled"},
            {name: "m2f09: กลยุทธ์-วิธีการกรมฯ", link: "jsp/m2f09", disabled: "disabled"},
	        {name: "m2f01: ยุทธศาสตร์จัดสรร (รัฐบาล)", link: "jsp/m2f01", disabled: "disabled"},
            {name: "m2f02: ประเด็นยุทธศาสตร์ (รัฐบาล)", link: "jsp/m2f02", disabled: "disabled"},
            {name: "m2f03: เป้าหมายเชิงยุทธศาสตร์ (รัฐบาล)", link: "jsp/m2f03", disabled: "disabled"},
            {name: "m2f04: เป้าหมายบริการกระทรวงฯ ", link: "jsp/m2f04"},
            {name: "m2f05: เป้าหมายบริการหน่วยงาน", link: "jsp/m2f05"},
            {name: "m2f07: ยุทธศาสตร์กระทรวงฯ", link: "jsp/m2f07", disabled: "disabled"}
            
			]
},{
	  name: "ระบบการปรับลดบประมาณ",
	    menus: [{name: "m3f04: ประมวลผลก่อนการปรับลดครั้งที่1",link: "page/m3f04/"},
	            {name: "m3f01: บันทึกการปรับลดงประมาณ  ชั้น สำนักงบ (อธิบดีปรับลด)",link: "page/m3f01/"},
	            {name: "m3f04: ประมวลผลก่อนการปรับลดครั้งที่2",link: "page/m3f05/"},
	            {name: "m3f02: บันทึกการปรับลดงบประมาณ ชั้น กรรมาธิการ (สงป. ปรับลด)]", link: "page/m3f02/"},
	            {name: "m3f04: ประมวลผลก่อนการปรับลดครั้งที่3",link: "page/m3f06/"},
	            {name: "m3f03: บันทึกการปรับลดงบประมาณ ชั้น พ.ร.บ. (กมธ. ปรับลด)]", link: "page/m3f03/"}]
},{            
    name: "ระบบการจัดสรรงบประมาณ",
    menus: [{name: "m4f01: ประมวลผลก่อนการจัดสรร",link: "page/m4f01/"},
            {name: "m4f02: จัดสรรงบประมาณที่ได้รับลงหน่วยรับ",link: "page/m4f02/"}]
},{            
    name: "ระบบรายงาน",
    menus: [{name: "m5r01: รายงานคำขอตั้งงบประมาณ",link: "jsp/m4f01/", disabled: "disabled", user: true},
            {name: "m5r02: รายงานงบประมาณที่ได้รับจัดสรร", link: "jsp/m4f02/", disabled: "disabled", user: true}]
}];


var menuUserJson = [{
	name: "ระบบจัดทำคำขอตั้ง",
	menus: [{name: "m2f12: บันทึกข้อมูลงบประมาณ", link: "page/m2f12/", user: true},
	        ]
},{            
    name: "ระบบรายงาน",
    menus: [{name: "m5r01: รายงานคำขอตั้งงบประมาณ",link: "jsp/m4f01/", disabled: "disabled", user: true},
            {name: "m5r02: รายงานงบประมาณที่ได้รับจัดสรร", link: "jsp/m4f02/", disabled: "disabled", user: true}]
}];

var menuTemplate = Handlebars.compile($("#menuTemplate").html());


$(document).ready(function() {
	if (typeof ROLE_USER_PLAN != "undefined"){
	 	$("#menuDiv").html(menuTemplate(menuJson));
	} else {
		$("#menuDiv").html(menuTemplate(menuUserJson));
	}
});

</script>