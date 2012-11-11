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
			<li>{{name}}
				<ul>
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
	name: "ข้อมูลพื้นฐานหน่วยงาน (m1)",
	menus: [{name: "m1f01: โครงสร้างหมวดงบประมาณ", link:"jsp/m1f01", disabled: "disabled"},
	        {name: "m1f02: หน่วยงานภายใน", link: "jsp/m1f02", disabled: "disabled"},
	        {name: "m1f03: ข้อมูลหน่วยนับเป้าหมาย", link: "page/m1f03/"},
	        {name: "m1f05: เพิ่มข้อมูลเริ่มต้นปีงบประมาณ", link: "page/m1f05/"}]
},{
	name: "ระบบทะเบียน (m5)",
	menus: [ 
	         {name: "ทะเบียนสายยุทธศาสตร์การจัดสรรงบประมาณ (m51)", menus: 
	        	 [{name: "m51f01: ทะเบียนยุทธศาสตร์การจัดสรร", link: "page/m51f01/"},
	 	         {name: "m51f02: ทะเบียนประเด็นยุทธศาสตร์", link: "page/m51f02/"},
		         {name: "m51f03: ทะเบียนเป้าหมายเชิงยุทธศาสตร์", link: "page/m51f03/"},
		         {name: "m51f04: ทะเบียนเป้าหมายบริการกระทรวง", link: "page/m51f04/"},
		         {name: "m51f05: ทะเบียนเป้าหมายบริการหน่วยงาน", link: "page/m51f05/"},
		         {name: "m51f06: ทะเบียนแผนงาน", link: "page/m51f06/"},
		         {name: "m51f07: ทะเบียนผลผลิต/โครงการ", link: "page/m51f07/"},
		         {name: "m51f08: ทะเบียนกิจกรรมและระดับกิจกรรม", link: "page/m51f08/"},
		         {name: "m51f09: ทะเบียนรายการและระดับรายการ", link: "page/m51f09/"},
		         {name: "m51f10: ทะเบียนรายการกลาง", link: "page/m51f10/"}
		         ]},
		         
	         {name: "ทะเบียนตามแผนปฏิบัติราชการ (m52)", menus: 
	        	 [ {name: "m52f01: ทะเบียนเป้าประสงค์เชิงนโยบนาย", link: "page/m52f01/"}]},
	        	 
	         {name: "ทะเบียนสายยุทธศาสตร์กระทรวง-หน่วยงาน (m53)", menus: 
	        	 [{name: "m53f01: ทะเบียนยุทธศาสตร์กระทรวง", link: "page/m53f01/"},
     	         {name: "m53f02: ทะเบียนกลยุทธ์หน่วยงาน", link: "page/m53f02/"},
     	         {name: "m53f03: ทะเบียนกลยุทธ์/วิธีการหน่วยงาน", link: "page/m53f03/"}
                 ]},
                 
	         {name: "ทะเบียนสายกลยุทธ์หลัก (m54)", menus: 
	        	 [{name: "m54f01: ทะเบียนแนวทางการจัดสรรงบประมาณ", link: "page/m54f01/"}]},
	         
	         {name: "ทะเบียนวิสัยทัศน์-พันธกิจ (m55)", menus: 
	        	 [{name: "m55f01: ทะเบียนวิสัยทัศน์ / พันธกิจหน่วยงาน", link: "page/m55f01/"}]}
	         
	         ]
},{
	name: "ระบบการบันทึกเงินคำของบประมาณ (m6)",
	menus: [{
		name: "การจัดทำคำของบประมาณ  (m61)", menus: 
       	 	[{name: "m61f01: การโยกข้อมูลงบประมาณและ MTEF จากปีงบประมาณก่อนหน้า (ระดับกิจกรรม)", link: "page/m2f14/"},
	         {name: "m61f02: การโยกข้อมูลงบประมาณและ MTEF จากปีงบประมาณก่อนหน้า (ระดับรายการ)", link: "page/m2f14/"},
	         {name: "m61f03: การบันทึกงบประมาณ ระดับกิจกรรม", link: "page/m2f14/"},
	         {name: "m61f04: การบันทึกงบประมาณ ระดับรายการ", link: "page/m2f14/"},
	         {name: "m61f05: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", link: "page/m2f14/"}
	        ]},
	         
	     {name: "การกระทบยอดเงินงบประมาณ (m62)", menus: 
	        [{name: "m62f01: การประมวลผลการกระทบยอดเงินงบประมาณจากระดับรายการมาที่ระดับกิจกรรม", link: "page/m2f14/"}
	        
	       	]},
		 {name: "การพิจารณากรอบวงเงินเพื่อตั้งคำของบประมาณ (เข้าระบบ e-Budgeing) (m63)", menus: 
		    [{name: "m63f01: การบันทึกงบประมาณระดับกิจกรรม", link: "page/m2f14/"},
		     {name: "m63f02: การบันทึกงบประมาณระดับรายการ", link: "page/m2f14/"},  
		     {name: "m61f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", link: "page/m2f14/"}]},
		 {name: "การพิจารณาตามชั้นกรรมาธิการ (วาระที่ 1 - 3) (m64)", menus: 
		    [{name: "m64f01: การบันทึกงบประมาณระดับกิจกรรม", link: "page/m2f14/"},
		     {name: "m64f02: การบันทึกงบประมาณระดับรายการ", link: "page/m2f14/"},
		     {name: "m64f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", link: "page/m2f14/"}]},
		 {name: "การอนุมัติงบประมาณ ตาม พ.ร.บ. (m65)", menus: 
		    [{name: "m65f01: การบันทึกงบประมาณระดับกิจกรรม", link: "page/m2f14/"},
		     {name: "m65f02: การบันทึกงบประมาณระดับรายการ", link: "page/m2f14/"},
		     {name: "m65f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", link: "page/m2f14/"}]}
		]
},{
	name: "ระบบการจัดสรรงบประมาณ (m7)",
	menus: [
		 {name: "การจัดสรรงบประมาณ (m71)", menus: 
		    [{name: "m71f01: การบันทึกงบประมาณระดับกิจกรรม", link: "page/m2f14/"},
		     {name: "m71f02: การบันทึกงบประมาณระดับรายการ", link: "page/m2f14/"},  
		     {name: "m71f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", link: "page/m2f14/"}]},
		 {name: "การจัดสรรเพิมเติม (m72)", menus: 
		    [{name: "m72f01: การบันทึกงบประมาณระดับกิจกรรม", link: "page/m2f14/"},
		     {name: "m72f02: การบันทึกงบประมาณระดับรายการ", link: "page/m2f14/"},
		     {name: "m72f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", link: "page/m2f14/"}]}
		   ]
},{
	name: "ระบบรายงาน (m8)",
	menus: [
		 {name: "รายงานทะเบียน (m81)", menus: 
		    [{name: "m81f01: การบันทึกงบประมาณระดับกิจกรรม", link: "page/m2f14/"},
		     {name: "m81f02: การบันทึกงบประมาณระดับรายการ", link: "page/m2f14/"},  
		     {name: "m81f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", link: "page/m2f14/"}]},
		 {name: "รายงานการตรวจสอบ (m82)", menus: 
		    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/"},
		     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/"},
		     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/"}]},
	     {name: "รายงานตามแบบแผนปฏิบัติราชการ] (m83)", menus: 
			    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/"},
			     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/"},
			     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/"}]},
	     {name: "รายงานตามแบบคำของบประมาณ (m84)", menus: 
			    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/"},
			     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/"},
			     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/"}]},
	     {name: "รายงานตามแบบตารางขวาง] (m85)", menus: 
			    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/"},
			     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/"},
			     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/"}]},
	     {name: "รายงานตามแผนปฏิบัติการและงบประมษณ (m86)", menus: 
			    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/"},
			     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/"},
			     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/"}]}
	    ]
}];

var menuOld = [
{
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