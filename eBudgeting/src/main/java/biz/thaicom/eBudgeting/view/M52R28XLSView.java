package biz.thaicom.eBudgeting.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.pln.Objective;

public class M52R28XLSView extends AbstractPOIExcelView {

	@Override
	protected Workbook createWorkbook() {
		return new XSSFWorkbook();
	}

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
        Map<String, CellStyle> styles = createStyles(workbook);

		List<Objective> objectiveList = (List<Objective>) model.get("objectiveList");
		List<BudgetType> budgetTypeList = (List<BudgetType>) model.get("budgetTypeList");
		Integer fiscalYear = (Integer) model.get("fiscalYear");
		Sheet sheet = workbook.createSheet("sheet1");

		Row firstRow = sheet.createRow(0);
		Cell cell11 = firstRow.createCell(0);
		cell11.setCellValue("ตารางเปรียบเทียบการจัดสรรงบประมาณปี " + fiscalYear);
		cell11.setCellStyle(styles.get("title"));
		Cell cell12 = firstRow.createCell(1);
		
		Row thirdRow = sheet.createRow(2);
		Cell cellA = thirdRow.createCell(0);
		cellA.setCellValue("ลำดับที่");
		cellA.setCellStyle(styles.get("header"));
		Cell cellB = thirdRow.createCell(1);
		cellB.setCellValue("กิจกรรม");
		cellB.setCellStyle(styles.get("header"));
		Cell cellC = thirdRow.createCell(2);
		cellC.setCellValue("งบประมาณปี " + fiscalYear + " ที่ได้รับ");
		cellC.setCellStyle(styles.get("header"));
		Cell cellD = thirdRow.createCell(3);
		cellD.setCellValue("การจัดสรรงบประมาณ");
		cellD.setCellStyle(styles.get("header"));
		
		Row forthRow = sheet.createRow(3);
		Cell r4c0 = forthRow.createCell(0);
		r4c0.setCellStyle(styles.get("groupright"));
		
		Cell r4c1 = forthRow.createCell(1);
		r4c1.setCellValue(" ภาพรวม");
		r4c1.setCellStyle(styles.get("groupleft"));
		
		Cell r4c2 = forthRow.createCell(2);
		r4c2.setCellType(HSSFCell.CELL_TYPE_FORMULA);
		r4c2.setCellStyle(styles.get("groupnumber"));
		Cell r4c3 = forthRow.createCell(3);
		r4c3.setCellType(HSSFCell.CELL_TYPE_FORMULA);
		r4c3.setCellStyle(styles.get("groupnumber"));

		int i = 4;
		int seq = 1;
		int mseq = 1;
		String sum1 = "";
		String sum2 = "";
		String[] sumArray1 = new String[budgetTypeList.size()];
		String[] sumArray2 = new String[budgetTypeList.size()];

		for (BudgetType b : budgetTypeList) {
			Row rowb = sheet.createRow(i);
			Cell cb1 = rowb.createCell(0);
			cb1.setCellStyle(styles.get("cellright"));
			
			Cell cb2 = rowb.createCell(1);
			cb2.setCellValue("      - " + b.getName());
			cb2.setCellStyle(styles.get("cellleft"));
			
			Cell cb3 = rowb.createCell(2);
			cb3.setCellType(HSSFCell.CELL_TYPE_FORMULA);
			cb3.setCellStyle(styles.get("cellnumber"));
			Cell cb4 = rowb.createCell(3);
			cb4.setCellType(HSSFCell.CELL_TYPE_FORMULA);
			cb4.setCellStyle(styles.get("cellnumber"));
			
			if (seq == 1) {
				sum1 = sum1 + "C" + (i+1);
				sum2 = sum2 + "D" + (i+1);
			}
			else {
				sum1 = sum1 + "+C" + (i+1);
				sum2 = sum2 + "+D" + (i+1);
			}
			
			sumArray1[seq-1] = "";
			sumArray2[seq-1] = "";
			
			i++;
			seq++;
		}
		
		r4c2.setCellFormula(sum1);
		r4c3.setCellFormula(sum2);

		for (Objective o:objectiveList) {
			Row rows = sheet.createRow(i);
			Cell cg1 = rows.createCell(0);
			cg1.setCellValue(i-8);
			cg1.setCellStyle(styles.get("groupright"));
			
			Cell cg2 = rows.createCell(1);
			cg2.setCellValue(o.getName());
			cg2.setCellStyle(styles.get("groupleft"));
			
			Cell cg3 = rows.createCell(2);
			cg3.setCellType(HSSFCell.CELL_TYPE_FORMULA);
			cg3.setCellStyle(styles.get("groupnumber"));
			Cell cg4 = rows.createCell(3);
			cg4.setCellType(HSSFCell.CELL_TYPE_FORMULA);
			cg4.setCellStyle(styles.get("groupnumber"));
			
			i++;
			sum1 = "";
			sum2 = "";
			seq = 1;

			for (BudgetType b : budgetTypeList) {
				Row rowb = sheet.createRow(i);
				Cell cb1 = rowb.createCell(0);
				cb1.setCellValue(i-8);
				cb1.setCellStyle(styles.get("cellright"));
				
				Cell cb2 = rowb.createCell(1);
				cb2.setCellValue("      - " + b.getName());
				cb2.setCellStyle(styles.get("cellleft"));
				
				Cell cb3 = rowb.createCell(2);
				cb3.setCellStyle(styles.get("cellnumber"));
				Cell cb4 = rowb.createCell(3);
				cb4.setCellStyle(styles.get("cellnumber"));
				
				if (seq == 1) {
					sum1 = "C" + (i+1);
					sum2 = "D" + (i+1);
				}
				else {
					sum1 = sum1 + "+C" + (i+1);
					sum2 = sum2 + "+D" + (i+1);
				}
				
				if (mseq == 1) {
					sumArray1[seq-1] = sumArray1[seq-1] + "C" + (i+1);
					sumArray2[seq-1] = sumArray2[seq-1] + "D" + (i+1);
				}
				else {
					sumArray1[seq-1] = sumArray1[seq-1] + "+C" + (i+1);
					sumArray2[seq-1] = sumArray2[seq-1] + "+D" + (i+1);
				}
				
				i++;
				seq++;
			}
			
			cg3.setCellFormula(sum1);
			cg4.setCellFormula(sum2);
			mseq++;
			
		}

		i = 4;
		seq = 0;
		for (BudgetType b : budgetTypeList) {
			Row rowb = sheet.getRow(i);
			Cell cb3 = rowb.getCell(2);
			cb3.setCellFormula(sumArray1[seq]);
			Cell cb4 = rowb.getCell(3);
			cb4.setCellFormula(sumArray2[seq]);
			i++;
			seq++;
		}
		
		sheet.setColumnWidth(0, 2000);
		sheet.setColumnWidth(1, 18000);
		sheet.setColumnWidth(2, 6000);
		sheet.setColumnWidth(3, 6000);
	}
	
    private static Map<String, CellStyle> createStyles(Workbook wb){
        Map<String, CellStyle> styles = new HashMap<String, CellStyle>();

        short borderColor = IndexedColors.GREY_50_PERCENT.getIndex();

        CellStyle style;
        Font titleFont = wb.createFont();
        titleFont.setFontName("Tahoma");
        titleFont.setFontHeightInPoints((short)12);
        titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_LEFT);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFont(titleFont);
        styles.put("title", style);

        Font headFont = wb.createFont();
        headFont.setFontName("Tahoma");
        headFont.setFontHeightInPoints((short)11);
        headFont.setColor(IndexedColors.WHITE.getIndex());
        headFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setFont(headFont);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        style.setWrapText(true);
        styles.put("header", style);

        Font groupFont = wb.createFont();
        groupFont.setFontName("Tahoma");
        groupFont.setFontHeightInPoints((short)11);
        groupFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_LEFT);
        style.setVerticalAlignment(CellStyle.VERTICAL_TOP);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setWrapText(true);
        style.setFont(groupFont);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("groupleft", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setVerticalAlignment(CellStyle.VERTICAL_TOP);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setWrapText(true);
        style.setFont(groupFont);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("groupright", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setVerticalAlignment(CellStyle.VERTICAL_TOP);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setWrapText(true);
        style.setDataFormat(HSSFDataFormat.getBuiltinFormat("$#,##0"));
        style.setFont(groupFont);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("groupnumber", style);

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

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
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
        styles.put("cellright", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setVerticalAlignment(CellStyle.VERTICAL_TOP);
        style.setWrapText(true);
        style.setDataFormat(HSSFDataFormat.getBuiltinFormat("$#,##0"));
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("cellnumber", style);

        return styles;
    }

}
