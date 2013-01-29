package biz.thaicom.eBudgeting.view.word;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;

import biz.thaicom.eBudgeting.models.pln.ObjectiveDetail;
import biz.thaicom.eBudgeting.view.AbstractPOIWordView;
import biz.thaicom.security.models.ThaicomUserDetail;

public class M61f04DOCXView extends AbstractPOIWordView {

	@Override
	protected void buildWordDocument(Map<String, Object> model,
			XWPFDocument docx, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ObjectiveDetail detail = (ObjectiveDetail) model.get("detail");
		ThaicomUserDetail currentUser = (ThaicomUserDetail) model.get("currentUser");
		
		
		
		
		XWPFParagraph par1 = docx.createParagraph();
		par1.setAlignment(ParagraphAlignment.CENTER);
	    XWPFRun run = par1.createRun();
	    run.setText("แบบเสนอโครงการ" + detail.getForObjective().getName() + " ประจำปีงบประมาณ " + detail.getForObjective().getFiscalYear());
	    run.setFontSize(14);
	    run.setFontFamily("Angsana New");
	    run.setBold(true);
	    
	    XWPFParagraph par2 = docx.createParagraph();
	    XWPFRun run2 = par2.createRun();
	    run2.setFontSize(14);
	    run2.setFontFamily("Angsana New");
	    run2.setText("หน่วยงานที่เสนอของบประมาณ " + currentUser.getWorkAt().getName());
	    run2.addCarriageReturn();
	    run2.setText("ผู้รับผิดชอบโครงการ " + 
	    		detail.getOfficerInCharge() + 
	    		"    โทร " + detail.getPhoneNumber() +
	    		"    Email " + detail.getEmail());
	 
	    XWPFParagraph par3 = docx.createParagraph();
	    XWPFRun run3 = par3.createRun();
	    run3.setFontSize(14);
	    run3.setFontFamily("Angsana New");
	    run3.setBold(true);
	    run3.setText("1.หลักการและเหตุผล");
	    run3.addCarriageReturn();
	    run3.setBold(true);
	    run3.setText(detail.getReason());
	    
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	    
	    run3.setBold(true);
	    run3.setText("2. วัตถุประสงค์");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getProjectObjective());

	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	    
	    run3.setBold(true);
	    run3.setText("3. วิธีการและขั้นตอนการดำเนินงาน");
	    run3.addCarriageReturn();
	    run3.setText("3.1 การรวบรวมข้อมูลทั่วไป");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getMethodology1());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	    
	    run3.setBold(true);
	    run3.setText("3.2 การรวบรวมข้อมูลทางด้านเศรษฐกิจและสังคม");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getMethodology2());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	    
	    run3.setBold(true);
	    run3.setText("3.3 การนำเขาและวิเคราะห์ข้อมูล");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getMethodology3());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	    
	    
	    run3.setBold(true);
	    run3.setText("4. สถานที่ดำเนินการ");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getLocation());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();

	    run3.setBold(true);
	    run3.setText("5. ระยะเวลาดำเนินการ");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getTimeframe());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	    
	    
	    run3.setBold(true);
	    run3.setText("6. เป้าหมายและงบประมาณ");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getTargetDescription());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	    
	    run3.setBold(true);
	    run3.setText("7. ผลประโยชน์ที่คาดว่าจะได้รับ");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getOutcome());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	    
	    run3.setBold(true);
	    run3.setText("8. ผลการดำเนินงานตั้งแต่เริ่มต้น");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getOutput());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	
	    run3.setBold(true);
	    run3.setText("9. พื้นที่เป้าหมาย");
	    run3.addCarriageReturn();
	    run3.setBold(false);
	    run3.setText(detail.getTargetArea());
	    run3.addCarriageReturn();
	    run3.addCarriageReturn();
	}

	
}
