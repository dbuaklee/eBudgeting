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

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;

public class M54R01XLSView extends AbstractPOIExcelView {

	@Override
	protected Workbook createWorkbook() {
		return new XSSFWorkbook();
	}

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
        Map<String, CellStyle> styles = createStyles(workbook);

		ObjectiveType type = (ObjectiveType) model.get("type");
		List<Objective> objectiveList = (List<Objective>) model.get("objectiveList");
		Integer fiscalYear = (Integer) model.get("fiscalYear");
		Sheet sheet = workbook.createSheet("sheet1");

		Row firstRow = sheet.createRow(0);
		Cell cell11 = firstRow.createCell(0);
		cell11.setCellValue("รายงานตรวจสอบทะเบียน" + type.getName());
		cell11.setCellStyle(styles.get("title"));
		Cell cell12 = firstRow.createCell(1);
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 1));
		
		Row secondRow = sheet.createRow(1);
		Cell cell21 = secondRow.createCell(0);
		cell21.setCellValue("(ทะเบียนตามปีงบประมาณ " + fiscalYear + ")");
		cell21.setCellStyle(styles.get("title"));
		Cell cell22 = secondRow.createCell(1);
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 1));
		
		Row thirdRow = sheet.createRow(2);
		Cell cellA = thirdRow.createCell(0);
		cellA.setCellValue("รหัส");
		cellA.setCellStyle(styles.get("header"));
		Cell cellB = thirdRow.createCell(1);
		cellB.setCellValue("ชื่อ");
		cellB.setCellStyle(styles.get("header"));

		
		int i = 3;
		for (Objective o:objectiveList) {
			Row rows = sheet.createRow(i);
			Cell cellx = rows.createCell(0);
			cellx.setCellValue(o.getCode());
			cellx.setCellStyle(styles.get("cellcenter"));
			
			Cell celly = rows.createCell(1);
			celly.setCellValue(o.getName());
			celly.setCellStyle(styles.get("cellleft"));
			
			i++;
		}

		sheet.setColumnWidth(0, 3000);
		sheet.setColumnWidth(1, 30000);
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
        style.setVerticalAlignment(CellStyle.VERTICAL_TOP);
        style.setWrapText(true);
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
        style.setVerticalAlignment(CellStyle.VERTICAL_TOP);
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
