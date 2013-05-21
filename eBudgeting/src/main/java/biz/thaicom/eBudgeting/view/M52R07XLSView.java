package biz.thaicom.eBudgeting.view;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;
import biz.thaicom.security.models.ThaicomUserDetail;

public class M52R07XLSView extends AbstractExcelView {

	private static SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:sss");
	private static DecimalFormat df = new DecimalFormat("#,###,##0.0000");
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		ThaicomUserDetail currentUser = (ThaicomUserDetail) model.get("currentUser");

		Map<String, CellStyle> styles = createStyles(workbook);


		Long    sumYearOfObjective1 = (Long) model.get("sumYearOfObjective1");
		Long    sumYearOfObjective2 = (Long) model.get("sumYearOfObjective2");

		List<Objective> objectiveListobjectiveType119 = (List<Objective>) model.get("objectiveType119");
		List<Objective> objectiveListobjectiveType120 = (List<Objective>) model.get("objectiveType120");

        Integer fiscalYear1 = (Integer) model.get("fiscalYear1");
		Integer fiscalYear2 = (Integer) model.get("fiscalYear2");
		

		Sheet sheet = workbook.createSheet("sheet1");

		Row Row11 = sheet.createRow(0);
		Cell cell11 = Row11.createCell(0);
		cell11.setCellValue("(ผู้พิมพ์รายงาน " + " หน่วยงาน " + currentUser.getPerson().getWorkAt().getName() +
				currentUser.getPerson().getFirstName() + " " +	currentUser.getPerson().getLastName() + 
				" เวลาที่จัดทำรายงาน " +  sdf.format(new Date()) + "น.)");

		Row Row21 = sheet.createRow(1);
		Cell cell21 = Row21.createCell(0);
		cell21.setCellValue("แบบสรุปงบประมาณรายจ่ายประจำปีงบประมาณ  พ.ศ." + fiscalYear2);
		cell21.setCellStyle(styles.get("title"));

		
		Row Row31 = sheet.createRow(2);
		Cell cell31 = Row31.createCell(0);
		cell31.setCellValue("กระทรวง  : กระทรวงเกษตรและสหกรณ์");
		Row Row41 = sheet.createRow(3);
		Cell cell41 = Row41.createCell(0);
		cell41.setCellValue("กรม  : กรมพัฒนาที่ดิน");
		Row Row51 = sheet.createRow(4);
		Cell cell51 = Row51.createCell(0);
		cell51.setCellValue("หน่วยงาน  : " + currentUser.getPerson().getWorkAt().getName());

		Row Row61 = sheet.createRow(5);
		Cell cell61 = Row61.createCell(2);
		cell61.setCellValue("ล้านบาท(ทศนิยม 4 ตำแหน่ง) ");
		
		
			Row Row71 = sheet.createRow(6);
			Cell cell71 = Row71.createCell(0);
			cell71.setCellValue("งบประมาณประจำปี  " + fiscalYear1);
			Cell cell72 = Row71.createCell(1);
			Double sumYearOfObj1 = 0.0;
			if (sumYearOfObjective1 != null){

				sumYearOfObj1 = sumYearOfObjective1/1000000.0;
			}
			cell72.setCellValue(df.format(sumYearOfObj1));
			Cell cell73 = Row71.createCell(2);
			cell73.setCellValue("ล้านบาท  ");
			
	      
		    Row Row81 = sheet.createRow(7);
		    Cell cell81 = Row81.createCell(0);
		    cell81.setCellValue("งบประมาณประจำปี  " + fiscalYear2);
		    Cell cell82 = Row81.createCell(1);
			Double sumYearOfObj2 = 0.0;
		    if (sumYearOfObjective2 != null){
				sumYearOfObj2 = sumYearOfObjective2/1000000.0;
			}
			cell82.setCellValue(df.format(sumYearOfObj2));
	   	    Cell cell83 = Row81.createCell(2);
		    cell83.setCellValue("ล้านบาท  ");
		
		    Double   diffAmount = 0.0;
            
		    diffAmount = sumYearOfObj2 - sumYearOfObj1;
            
		    Row Row91 = sheet.createRow(8);
		    Cell cell91 = Row91.createCell(0);
		    cell91.setCellValue("เพิ่มขึ้น - ลดลง จากปี (" + fiscalYear1 + ")");
		    Cell cell92 = Row91.createCell(1);
		    cell92.setCellValue(df.format(diffAmount));
		    Cell cell93 = Row91.createCell(2);
		    cell93.setCellValue("ล้านบาท  ");
		
		    Double  diffPerc;
		    if (sumYearOfObj1 == 0){
		    	diffPerc = 100.0;
		    }
		    else
		    {
		    	diffPerc = diffAmount/sumYearOfObjective1*100;
		    }
		    
		    Row Row101 = sheet.createRow(9);
		    Cell cell101 = Row101.createCell(0);
		    cell101.setCellValue("ร้อยละ");
		    Cell cell102 = Row101.createCell(1);
		    cell102.setCellValue(df.format(diffPerc));
		


		Row Row131 = sheet.createRow(12);
		Cell cell132 = Row131.createCell(1);
		cell132.setCellValue("1. วิสัยทัศน์ :");

		int i = 13;
		for (Objective o:objectiveListobjectiveType119) {
			Row Row119 = sheet.createRow(i);
			Cell cell119 = Row119.createCell(1);
			cell119.setCellValue(o.getName());
			i++;
		}
		
		i++;
		Row Rows = sheet.createRow(i);
		Cell cellxy = Rows.createCell(1);
		cellxy.setCellValue("2. พันธกิจ :");
		i++;

		for (Objective o:objectiveListobjectiveType120) {
			Row Row120 = sheet.createRow(i);
			Cell cell120 = Row120.createCell(1);
			cell120.setCellValue(o.getName());
			i++;
		}
		
	}
	
    private static Map<String, CellStyle> createStyles(Workbook wb){
        Map<String, CellStyle> styles = new HashMap<String, CellStyle>();

        short borderColor = IndexedColors.GREY_50_PERCENT.getIndex();

        CellStyle style;
        Font titleFont = wb.createFont();
        titleFont.setFontHeightInPoints((short)12);
        titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFont(titleFont);
        styles.put("title", style);

        Font monthFont = wb.createFont();
        monthFont.setFontHeightInPoints((short)11);
        monthFont.setColor(IndexedColors.WHITE.getIndex());
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setFont(monthFont);
        style.setWrapText(true);
        styles.put("header", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_LEFT);
        style.setWrapText(true);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("cell1", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setWrapText(true);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("cell2", style);

        return styles;
    }


}
