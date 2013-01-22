<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="hero-unit white">

<div class="row">
	<div class="span3 menu" id="main1" data-id="1">
		
	</div>
	
	<div class="span3 menu" id="main2" data-id="2">
		
	</div>
	
	<div class="span4 menu" id="main3" data-id="3">
		
	</div>
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

<script id="subMenuTemplate" type="text/x-handlebars-template">
{{#each this}}
<ul style="padding-top:0px;">
		<li>
					{{#if disabled}} 
						{{name}}
					{{else}}
						<a {{#if link}}href="{{link}}"{{else}}href="#"{{/if}}>{{name}}</a>
					{{/if}}

			</li>
		
	</ul>	
{{/each}}
</script>

<sec:authorize access="hasRole('ROLE_USER_PLAN')">
<script type="text/javascript">
var ROLE_USER_PLAN = true;
</script>
</sec:authorize>


<script type="text/javascript">
var menuCode='${menuCode}';
var menuLevel='${menuLevel}';
var fiscalYear = parseInt("${currentRootFY.fiscalYear}");

var menuJson = [{
	name: "ข้อมูลพื้นฐานหน่วยงาน (m1)",
	code: "m1",
	menus: [{name: "ข้อมูลพื้นฐานงบประมาณ(m11)", code: "m11", menus: [
				{name: "m1f05: เพิ่มข้อมูลเริ่มต้นปีงบประมาณ", code:"m1f05", link: "page/m1f05/"}
	        	]}
	        	]
},{
	name: "ระบบทะเบียน (m5)", code: "m5",
	menus: [  
	         {name: "ทะเบียนสายยุทธศาสตร์การจัดสรรงบประมาณ (m51)", code: "m51", menus: 
	        	 [
	        	  {name: "m51f01:(1) ทะเบียนยุทธศาสตร์การจัดสรร", code: "m51f01", link: "page/m51f01/"},
	 	         {name: "m51f02: (2) ทะเบียนประเด็นยุทธศาสตร์", code: "m51f02", link: "page/m51f02/"},
		         {name: "m51f03: ทะเบียนเป้าหมายเชิงยุทธศาสตร์", code: "m51f03", link: "page/m51f03/"},
		         {name: "m51f04: ทะเบียนเป้าหมายบริการกระทรวง", code: "m51f04", link: "page/m51f04/"},
		         {name: "m51f06: (3) ทะเบียนแผนงาน", code: "m51f05", link: "page/m51f06/"},
		         {name: "m51f05: ทะเบียนเป้าหมายบริการหน่วยงาน", code: "m51f06", link: "page/m51f05/"},
		         {name: "m51f07: (4) ทะเบียนผลผลิต/โครงการ", code: "m51f07", link: "page/m51f07/"},
		         {name: "m51f08: (5) ทะเบียนกิจกรรมหลัก", code: "m51f08", link: "page/m51f08/"},
		         {name: "m51f09: (6) ทะเบียนกิจกรรมรอง", code: "m51f09", link: "page/m51f09/"},
		         {name: "m51f10: (7) ทะเบียนกิจกรรมย่อย", code: "m51f10", link: "page/m51f10/"},
		         {name: "m51f11: (8) ทะเบียนกิจกรรมเสริม", code: "m51f11", link: "page/m51f11/"},
		         {name: "m51f12: (9) ทะเบียนกิจกรรมสนับสนุน", code: "m51f12", link: "page/m51f12/"},
		         {name: "m51f13: (10) ทะเบียนกิจกรรมรายละเอียด", code: "m51f13", link: "page/m51f13/"},
		         {name: "m51f14: ทะเบียนรายการและรายการย่อย", code: "m51f14", link: "page/m51f14/"},
		         {name: "m51f15: ทะเบียนรายการกลาง", code: "m51f15", link: "page/m51f15/"},
		         {name: "m51f16: ทะเบียนรายการหลักสำหรับบันทึกงบประมาณกิจกรรม", code: "m51f16", link: "page/m51f16/"},
		         {name: "m51f17: การเชื่อมโยงกิจกรรม", code: "m51f17", link: "page/m51f17/"},
		         {name: "m51f18: ทะเบียนหน่วยนับ", code: "m51f18", link: "page/m51f18/"}
		         ]},
		         
	         {name: "ทะเบียนตามแผนปฏิบัติราชการ (m52)", code: "m52",  menus: 
	        	 [ {name: "m52f01: ทะเบียนเป้าประสงค์ (เป้าหมาย) เชิงนโยบนาย", code: "m52f01",  link: "page/m52f01/"}]},
	        	 
	         {name: "ทะเบียนสายยุทธศาสตร์กระทรวง-หน่วยงาน (m53)", code: "m53",  menus: 
	        	 [{name: "m53f01: ทะเบียนยุทธศาสตร์กระทรวง", code: "m53f01",  link: "page/m53f01/"},
     	         {name: "m53f02: ทะเบียนกลยุทธ์หน่วยงาน",code: "m53f02",  link: "page/m53f02/"},
     	         {name: "m53f03: ทะเบียนกลยุทธ์/วิธีการกรมฯ", code: "m53f03",  link: "page/m53f03/"}
                 ]},
                 
	         {name: "ทะเบียนสายกลยุทธ์หลัก (m54)", code: "m54",  menus: 
	        	 [{name: "m54f01: ทะเบียนแนวทางการจัดสรรงบประมาณ (กลยุทธ์หลัก)", code: "m54f01",  link: "page/m54f01/"}]},
	         
	         {name: "ทะเบียนวิสัยทัศน์-พันธกิจ (m55)",code: "m55",  menus: 
	        	 [{name: "m55f01: ทะเบียนวิสัยทัศน์หน่วยงาน", code: "m55f01", link: "page/m55f01/"},
	        	  {name: "m55f02: ทะเบียนพันธกิจหน่วยงาน", code: "m55f02", link: "page/m55f02/"}]}
	         
	         ]
},{
	name: "ระบบการบันทึกเงินคำของบประมาณ (m6)",code: "m6", 
	menus: [{
		name: "การจัดทำคำของบประมาณ  (m61)",code: "m61",  menus: 
       	 	[{name: "m61f01: การโยกข้อมูลงบประมาณและ MTEF จากปีงบประมาณก่อนหน้า (ระดับกิจกรรม)", code: "m61f01", link: "page/m2f14/", disabled: "disabled"},
	         {name: "m61f02: การโยกข้อมูลงบประมาณและ MTEF จากปีงบประมาณก่อนหน้า (ระดับรายการ)",code: "m61f02",  link: "page/m2f14/", disabled: "disabled"},
	         {name: "m61f03: การบันทึกงบประมาณ ระดับกิจกรรม",code: "m61f03",  link: "page/m61f03_1/"},
	         {name: "m61f04: การบันทึกงบประมาณ ระดับรายการ", code: "m61f04", link: "page/m61f04_1/"},
	         {name: "m61f05: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)",code: "m61f05",  link: "page/m61f05/" }
	        ]},
	         
	     {name: "การกระทบยอดเงินงบประมาณ (m62)", code: "m62", menus: 
	        [{name: "m62f01: การประมวลผลการกระทบยอดเงินงบประมาณจากระดับรายการมาที่ระดับกิจกรรม", code: "m62f01", link: "page/m62f01/"}
	        
	       	]},
		 {name: "การพิจารณากรอบวงเงินเพื่อตั้งคำของบประมาณ (เข้าระบบ e-Budgeting) (m63)",code: "m63",  menus: 
		    [{name: "m3f04: การประมวลผลก่อนการปรับลดรอบที่ 1", code: "m3f04", link: "page/m3f04/"},
		     {name: "m63f01: การบันทึกงบประมาณระดับกิจกรรม",code: "m63f01",  link: "page/m2f14/", disabled: "disabled"},
		     {name: "m63f02: การบันทึกงบประมาณระดับรายการ", code: "m63f02", link: "page/m63f02/"},  
		     {name: "m63f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", code: "m63f03", link: "page/m2f14/", disabled: "disabled"}]},
		 {name: "การพิจารณาตามชั้นกรรมาธิการ (วาระที่ 1 - 3) (m64)", code: "m64", menus: 
		    [{name: "m3f05: การประมวลผลก่อนการปรับลดรอบที่ 2", code: "m3f05", link: "page/m3f05/"},
		     {name: "m64f01: การบันทึกงบประมาณระดับกิจกรรม", code: "m64f01", link: "page/m2f14/", disabled: "disabled"},
		     {name: "m64f02: การบันทึกงบประมาณระดับรายการ", code: "m64f02", link: "page/m64f02/"},
		     {name: "m64f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", code: "m64f03", link: "page/m2f14/", disabled: "disabled"}]},
		 {name: "การอนุมัติงบประมาณ ตาม พ.ร.บ. (m65)",code: "m65",  menus: 
		    [{name: "m3f06: การประมวลผลก่อนการปรับลดรอบที่ 3", code: "m3f06", link: "page/m3f06/"},
		     {name: "m65f01: การบันทึกงบประมาณระดับกิจกรรม", code: "m65f01", link: "page/m2f14/", disabled: "disabled"},
		     {name: "m65f02: การบันทึกงบประมาณระดับรายการ", code: "m65f02", link: "page/m65f02/"},
		     {name: "m65f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", code: "m65f03", link: "page/m2f14/", disabled: "disabled"}]}
		]
},{
	name: "ระบบการจัดสรรงบประมาณ (m7)", code: "m7", 
	menus: [
		 {name: "การจัดสรรงบประมาณ (m71)",code: "m71",  menus: 
		    [{name: "m3f04: การประมวลผลก่อนการจัดสรรงบประมาณ", code: "m3f04", link: "page/m4f01/"},
		     {name: "m71f01: การบันทึกงบประมาณระดับกิจกรรม", code: "m71f01", link: "page/m2f14/", disabled: "disabled"},
		     {name: "m71f02: การบันทึกงบประมาณระดับรายการ", code: "m71f02", link: "page/m71f02/"},  
		     {name: "m71f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", code: "m71f03", link: "page/m2f14/", disabled: "disabled"}]},
		 {name: "การจัดสรรเพิมเติม (m72)",code: "m72",  menus: 
		    [{name: "m72f01: การบันทึกงบประมาณระดับกิจกรรม",code: "m72f01",  link: "page/m2f14/", disabled: "disabled"},
		     {name: "m72f02: การบันทึกงบประมาณระดับรายการ", code: "m72f02", link: "page/m2f14/", disabled: "disabled"},
		     {name: "m72f03: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)",code: "m72f03",  link: "page/m2f14/", disabled: "disabled"}]}
		   ]
},{
	name: "ระบบรายงาน (r)", code: "m8", 
	menus: [
		 {name: "รายงานทะเบียน (m51r)", code: "m81", menus: 
		    [{name: "m51r01: ทะเบียนยุทธศาสตร์จัดสรร", link: "m51r01.xls/"+fiscalYear+"/file/m51r01.xls"},
		     {name: "m51r02: ทะเบียนประเด็นยุทธศาสตร์", link: "m51r02.xls/"+fiscalYear+"/file/m51r02.xls"},
		     {name: "m51r03: ทะเบียนเป้าหมายเชิงยุทธศาสตร์", link: "m51r03.xls/"+fiscalYear+"/file/m51r03.xls"},
		     {name: "m51r04: ทะเบียนเป้าหมายบริการกระทรวง", link: "m51r04.xls/"+fiscalYear+"/file/m51r04.xls"},
		     {name: "m51r05: ทะเบียนเป้าหมายบริการหน่วยงาน", link: "m51r05.xls/"+fiscalYear+"/file/m51r05.xls"},
		     {name: "m51r06: ทะเบียนแผนงาน", link: "m51r06.xls/"+fiscalYear+"/file/m51r06.xls"},
		     {name: "m51r07: ทะเบียนผลผลิต-โครงการ และรายละเอียดประกอบ", link: "m51r07.xls/"+fiscalYear+"/file/m51r07.xls"},
		     {name: "m51r08: ทะเบียนกิจกรรมหลัก", link: "m51r08.xls/"+fiscalYear+"/file/m51r08.xls"},
		     {name: "m51r09: ทะเบียนกิจกรรมรอง", link: "m51r09.xls/"+fiscalYear+"/file/m51r09.xls"},
		     {name: "m51r10: ทะเบียนกิจกรรมย่อย", link: "m51r10.xls/"+fiscalYear+"/file/m51r10.xls"},
		     {name: "m51r11: ทะเบียนกิจกรรมเสริม", link: "m51r11.xls/"+fiscalYear+"/file/m51r11.xls"},
		     {name: "m51r12: ทะเบียนกิจกรรมสนับสนุน", link: "m51r12.xls/"+fiscalYear+"/file/m51r12.xls"},
		     {name: "m51r13: ทะเบียนกิจกรรมรายละเอียด", link: "m51r13.xls/"+fiscalYear+"/file/m51r13.xls"},
		
		     {name: "m51r15: ทะเบียนประเภทรายการกลาง", link: "m51r15.xls/"+fiscalYear+"/file/m51r15.xls"},
		     {name: "m51r16: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "m51r16.xls/"+fiscalYear+"/file/m51r16.xls", disabled: "disabled"},
		     {name: "m51r17: ตรวจสอบสายการเชื่อมโยงข้อมูล (สายยุทธศาสตร์กระทรวงฯ-กลยุทธ์หน่วยงาน)", link: "m51r17.xls/"+fiscalYear+"/file/m51r17.xls",disabled: "disabled"},
		     {name: "m51r17: ทะเบียนหน่วยนับ", link: "m51r18.xls/"+fiscalYear+"/file/m51r18.xls"}
		     ]},
	  {name: "รายงานการตรวจสอบ (m52r)", menus: 
				    [{name: "m52r01: การบันทึกงบประมาณระดับกิจกรรม", link: "m52r01_1.xls/"+fiscalYear+"/file/m52r01_1.xls"},
				     {name: "m52r02: การบันทึกงบประมาณระดับรายการ", link: "m52r02_1.xls/"+fiscalYear+"/file/m52r02_1.xls"}]},		 
	     {name: "รายงานตามแบบแผนปฏิบัติราชการ] (m83)", code: "m83",  menus: 
			    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/", disabled: "disabled"},
			     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/", disabled: "disabled"},
			     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/", disabled: "disabled"}]},
	     {name: "รายงานตามแบบคำของบประมาณ (m84)", code: "m84", menus: 
			    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/", disabled: "disabled"},
			     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/", disabled: "disabled"},
			     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/", disabled: "disabled"}]},
	     {name: "รายงานตามแบบตารางขวาง] (m85)", code: "m85", menus: 
			    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/", disabled: "disabled"},
			     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/", disabled: "disabled"},
			     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/", disabled: "disabled"}]},
	     {name: "รายงานตามแผนปฏิบัติการและงบประมาณ (m86)", code: "m86", menus: 
			    [{name: "m82f01: ตรวจสอบสายการเชื่อมโยงข้อมูล", link: "page/m2f14/", disabled: "disabled"},
			     {name: "m82f02: ตรวจสอบการบันทึกเงินระดับกิจกรรม", link: "page/m2f14/", disabled: "disabled"},
			     {name: "m82f03: ตรวจสอบการบันทึกเงินระดับรายการ", link: "page/m2f14/", disabled: "disabled"}]}
	    ]
}];

var menuOld = [
{
	name: "ระบบจัดทำคำขอตั้ง",
	menus: [ {name: "m2f14: ข้อมูลพื้นฐานหน่วยนับ", link: "page/m2f14/"},
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
	name: "ระบบการบันทึกเงินคำของบประมาณ (m6)",code: "m6", 
	menus: [{
		name: "การจัดทำคำของบประมาณ  (m61)", code: "m61", menus: 
	         [{name: "m61f03: การบันทึกงบประมาณ ระดับกิจกรรมหลัก",code: "m61f03",  link: "page/m61f03_1/"},
		      {name: "m61f04: การบันทึกงบประมาณ ระดับรายการ", code: "m61f04", link: "page/m61f04_1/"},
	          {name: "m61f05: การนำส่งคำของบประมาณ (Sign off) / ถอนนำส่ง (Release)", code: "m61f05", link: "page/m61f05/"}
	        ]}]
	         
},{
	name: "ระบบรายงาน (Report)",
	menus: [
		 {name: "รายงานการตรวจสอบ (m52r)", menus: 
		    [{name: "m52r01: การบันทึกงบประมาณระดับกิจกรรม", link: "m52r01_1.xls/"+fiscalYear+"/file/m52r01_1.xls"},
		     {name: "m52r02: การบันทึกงบประมาณระดับรายการ", link: "m52r02_1.xls/"+fiscalYear+"/file/m52r02_1.xls"}]}]
}];

var menuTemplate = Handlebars.compile($("#menuTemplate").html());

var mainview;
var e1;


$(document).ready(function() {
	
	
	var MainView = Backbone.View.extend({
		initialize: function(options){
	    	
		},
		subMenuTemplate: Handlebars.compile($("#subMenuTemplate").html()),
		el: "body",
		render: function() {
			$("#main1").html(this.subMenuTemplate(this.menu));
		},
		
		renderWith: function(m) {
			this.menu = m;
			this.render();
		},
		events: {
			"click a" : "menuClick"
		},
		
		menuClick: function(e) {
			e1 = e;
			
			var parentDiv = $(e.target).parents('div.menu');
			var li = $(e.target).parent();
			
			//e1=parentDiv;
			var level = parentDiv.attr('data-id');
			
			if(level == 1) {
				// get this index
				var i = parentDiv.find('li').index(li);
				
				this.currentFirstLevelIndex  = i;
				$("#main3").empty();
				
				$("#main2").html(this.subMenuTemplate(this.menu[i].menus));
				
				$("#navbarBreadcrumb").empty();
				$("#navbarBreadcrumb").html("<li><a href='#'>" + $(e.target).html() +"</a></li>");
				
				$.ajax({
					type: 'POST',
					data: {
						level: 0,
						value: this.menu[i].name,
						code: this.menu[i].code
					},
					url: appUrl('/Session/updateNavbarBreadcrumb')
				});
				
				
			} else if (level==2) {
				// get this index
				var i = parentDiv.find('li').index(li);
				
				$("#main3").html(this.subMenuTemplate(this.menu[this.currentFirstLevelIndex].menus[i].menus));
				
				
				$("#navbarBreadcrumb").empty();
				$("#navbarBreadcrumb").html("<li><a href='#'>" + this.menu[this.currentFirstLevelIndex].name +"</a> <span class='divider'>/</span></li>");
				$("#navbarBreadcrumb").append("<li><a href='#'>" + $(e.target).html() +"</a></li>");
				
				$.ajax({
					type: 'POST',
					data: {
						level: 1,
						value: this.menu[this.currentFirstLevelIndex].menus[i].name,
						code: this.menu[this.currentFirstLevelIndex].menus[i].code
					},
					url: appUrl('/Session/updateNavbarBreadcrumb')
				});
				
			} else if (level==3) {
				
			}
		}
	});
	
	mainView = new MainView();
	
	if (typeof ROLE_USER_PLAN != "undefined"){
		mainView.renderWith(menuJson);
	 	//$("#menuDiv").html(menuTemplate(menuJson));
	 	
	 	if(menuLevel == '0') {
	 		var firstMenu = _.where(menuJson, {code: menuCode})[0];
	 		$("#main2").html(mainView.subMenuTemplate(firstMenu.menus));
	 		mainView.currentFirstLevelIndex = _.indexOf(menuJson, firstMenu);
	 	} else if(menuLevel == '1') {
	 		var firstMenu = _.find(menuJson, function(menu) { return _.where(menu.menus, {code: menuCode}).length > 0; });
			mainView.currentFirstLevelIndex = _.indexOf(menuJson, firstMenu);
			$("#main2").html(mainView.subMenuTemplate(firstMenu.menus));
			
			var secondMenu = _.where(firstMenu.menus, {code: menuCode})[0];
			$("#main3").html(mainView.subMenuTemplate(secondMenu.menus));
	 	}
	 	
	} else {
		mainView.renderWith(menuUserJson);
		//$("#menuDiv").html(menuTemplate(menuUserJson));
		
	}
	
	
	
});

</script>