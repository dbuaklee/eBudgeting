package biz.thaicom.eBudgeting.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;

public class M51R15XLSView extends AbstractPOIExcelView {

	@Override
	protected Workbook createWorkbook() {
		return new XSSFWorkbook();
	}

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
        Map<String, CellStyle> styles = createStyles(workbook);

		List<BudgetType> budgetType = (List<BudgetType>) model.get("type");
		Integer fiscalYear = (Integer) model.get("fiscalYear");
		Sheet sheet = workbook.createSheet("sheet1");

		Row firstRow = sheet.createRow(0);
		Cell cell11 = firstRow.createCell(0);
		cell11.setCellValue("รายงานตรวจสอบทะเบียนประเภทรายการกลาง");
		cell11.setCellStyle(styles.get("title"));
		Cell cell12 = firstRow.createCell(1);
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
		
/*		Row secondRow = sheet.createRow(1);
		Cell cell21 = secondRow.createCell(0);
		cell21.setCellValue("(ทะเบียนทั้งหมด)");
		cell21.setCellStyle(styles.get("title"));
		Cell cell22 = secondRow.createCell(1);
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 1));
*/		
		Row thirdRow = sheet.createRow(2);
		Cell cellA = thirdRow.createCell(0);
		cellA.setCellValue("หมวดรายจ่าย");
		cellA.setCellStyle(styles.get("header"));
		Cell cellB = thirdRow.createCell(1);
		cellB.setCellValue("รายการกรมฯ");
		cellB.setCellStyle(styles.get("header"));
		Cell cellC = thirdRow.createCell(2);
		cellC.setCellValue("ประเภทรายการกลาง");
		cellC.setCellStyle(styles.get("header"));
		Cell cellD = thirdRow.createCell(3);
		cellD.setCellValue("หน่วยนับ");
		cellD.setCellStyle(styles.get("header"));
		
		int i = 3;
		Long pid = null;
		String gname = null;
		for (BudgetType o:budgetType) {
			Row rows = sheet.createRow(i);
			if (pid != o.getParent().getId()) {
				gname = o.getParent().getName();
				pid = o.getParent().getId();
			}

			for(BudgetType child: o.getChildren()){
				Row rows2 = sheet.createRow(i);
				
				Cell cs1 = rows2.createCell(0);
				if(gname!=null) {
					cs1.setCellValue(o.getParent().getName());
					cs1.setCellStyle(styles.get("cellgroup"));
				}
				else {
					cs1.setCellStyle(styles.get("cellleft"));
				}

				Cell cs2 = rows2.createCell(1);
				cs2.setCellValue("<" + child.getCode() + "> " + child.getName());
				if (gname!=null) {
					cs2.setCellStyle(styles.get("cellgroup"));
				}
				else {
					cs2.setCellStyle(styles.get("cellleft"));
				}
				
				Cell cs3 = rows2.createCell(2);
				if(child.getCommonType()!=null){
					cs3.setCellValue(child.getCommonType().getName());
				}
				if (gname!=null) {
					cs3.setCellStyle(styles.get("cellgroup"));
				}
				else {
					cs3.setCellStyle(styles.get("cellleft"));
				}

				Cell cs4 = rows2.createCell(3);
				if(child.getUnit()!=null){
					cs4.setCellValue(child.getUnit().getName());
				}
				if (gname!=null) {
					cs4.setCellStyle(styles.get("cellgroup"));
				}
				else {
					cs4.setCellStyle(styles.get("cellleft"));
				}

				i++;
				gname = null;
			}
			
		}

		sheet.setColumnWidth(0, 5000);
		sheet.setColumnWidth(1, 25000);
		sheet.setColumnWidth(2, 5000);
		sheet.setColumnWidth(3, 3000);
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
        monthFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        style.setFont(monthFont);
        styles.put("header", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_LEFT);
        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setWrapText(false);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("cellgroup", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_LEFT);
        style.setWrapText(false);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("cellleft", style);

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
        styles.put("cellcenter", style);

        return styles;
    }

}
