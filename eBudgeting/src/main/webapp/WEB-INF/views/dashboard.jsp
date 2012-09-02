<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

<script type="text/javascript">
var menuJson = [{
	name: "ข้อมูลพื้นฐานหน่วยงาน",
	menus: [{name: "m1f01: โครงสร้างหมวดงบประมาณ", link:"jsp/m1f01", disabled: "disabled"},
	        {name: "m1f02: หน่วยงานภายใน", link: "jsp/m1f02", disabled: "disabled"}]
},{
	name: "ข้อมูลคำขอตั้งเชิงงบประมาณ",
	menus: [{name: "m2f01: ยุทธศาสตร์จัดสรร (รัฐบาล)", link: "jsp/m2f01", disabled: "disabled"},
            {name: "m2f02: ประเด็นยุทธศาสตร์ (รัฐบาล)", link: "jsp/m2f02", disabled: "disabled"},
            {name: "m2f03: เป้าหมายเชิงยุทธศาสตร์ (รัฐบาล)", link: "jsp/m2f03", disabled: "disabled"},
            {name: "m2f04: เป้าหมายบริการกระทรวงฯ ", link: "jsp/m2f04"},
            {name: "m2f05: เป้าหมายบริการหน่วยงาน", link: "jsp/m2f05"},
            {name: "m2f06: แผนงาน/งบประมาณ", link: "jsp/m2f06"},
            {name: "m2f07: ผลผลิต/โครงการ", link: "jsp/m2f07"},
            {name: "m2f08: กิจกรรมหลัก/รอง/สนับสนุน", link: "jsp/m2f08"},
            {name: "m2f09: กิจกรรมหน่วยงาน", link: "jsp/m2f09", disabled: "disabled"}]
},{           
	name: "ข้อมูลคำขอตั้งเชิงยุทธศาสตร์",
	menus: [{name: "m3f01: ยุทธศาสตร์กระทรวงฯ", link: "jsp/m3f01", disabled: "disabled"},
            {name: "m3f02: กลยุทธ์หน่วยงาน", link: "jsp/m3f02", disabled: "disabled"},
            {name: "m3f03: กลยุทธ์-วิธีการกรมฯ", link: "jsp/m3f03", disabled: "disabled"},
            {name: "m3f04: วิสัยทัศน์-พันธกิจ หน่วยงาน", link: "jsp/m3f04"}]
},{            
    name: "การจัดสรรงบประมาณ",
    menus: [{name: "m4f01: บันทึกงบประมาณที่ได้รับการจัดสรร (รายกิจกรรม)",link: "jsp/m4f01", disabled: "disabled"},
            {name: "m4f02: ปรับแก้ไขรายละเอียดงบประมาณกิจกรรมหน่วยงาน]", link: "jsp/m4f02", disabled: "disabled"}]
}];

var menuTemplate = Handlebars.compile($("#menuTemplate").html());

$(document).ready(function() {
	 $("#menuDiv").html(menuTemplate(menuJson));
});

</script>