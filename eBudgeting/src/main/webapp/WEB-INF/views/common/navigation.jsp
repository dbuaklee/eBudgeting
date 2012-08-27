<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

 	<!--Create the Accordion widget and assign classes to each element-->
	<div id="Accordion1" class="Accordion">
		<div class="AccordionPanel">
			<div class="AccordionPanelTab">เกี่ยวกับงานสัมมนา</div>
			<div class="AccordionPanelContent">
				<a href="Home.html">หลักการและเหุตผล</a><br/>
				<a href="Schedule.html">กำหนดการ</a><br/>
                <a href="Venue.html">สถานที่จัดงาน</a><br/>
			</div>
		</div>
		<div class="AccordionPanel">
			<div class="AccordionPanelTab">สมัครเข้าร่วมสัมมนา</div>
			<div class="AccordionPanelContent">
				<a href="Register.html">กรอกใบสมัคร</a><br/>
				<a href="CheckRegistration.html">ตรวจสอบรายชื่อ</a><br/>
			</div>
		</div>
		<div class="AccordionPanel">
			<div class="AccordionPanelTab">รายละเอียดการบรรยาย</div>
			<div class="AccordionPanelContent">
        		Coming Soon...
			</div>
		</div>
		<div class="AccordionPanel">
			<div class="AccordionPanelTab">ติดต่อ/สอบถาม</div>
			<div class="AccordionPanelContent"><a href="About.html">ช่องทางการติดต่อ</a><br/>
  				<a href="AboutDSS.html">กรมวิทยาศาสตร์บริการ</a><br/>
			</div>
		</div>
	</div>
 
 <script type="text/javascript">
<!--
var Accordion1 = new Spry.Widget.Accordion("Accordion1",{ defaultPanel: ${page.defaultPanel} });
//-->
</script>
 
 