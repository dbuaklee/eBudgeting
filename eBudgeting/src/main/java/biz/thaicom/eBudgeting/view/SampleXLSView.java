package biz.thaicom.eBudgeting.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class SampleXLSView extends AbstractPOIExcelView {

	@Override
	protected Workbook createWorkbook() {
		return new XSSFWorkbook();
	}

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Integer fiscalYear = (Integer) model.get("fiscalYear");
		String worksheetName = "ปี " + fiscalYear.toString();
		

		Font font = workbook.createFont();
		font.setFontHeightInPoints((short)8);
		font.setFontName("Tahoma");
		
		CellStyle style = workbook.createCellStyle();
		style.setFont(font);
		
		Sheet sheet = workbook.createSheet(worksheetName);
		
		
		Row firstRow = sheet.createRow(0);
		Cell firstCell = firstRow.createCell(0);
		
		firstCell.setCellStyle(style);
		firstCell.setCellValue("ปีงบประมาณ " + fiscalYear);
		
		
	}

}
