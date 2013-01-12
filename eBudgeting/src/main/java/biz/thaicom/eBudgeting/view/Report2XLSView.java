package biz.thaicom.eBudgeting.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class Report2XLSView extends AbstractPOIExcelView {

	@Override
	protected Workbook createWorkbook() {
		// TODO Auto-generated method stub
		return new XSSFWorkbook();
	}

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Sheet sheet1=workbook.createSheet("Sheet1");
		Row row1=sheet1.createRow(0);
		Cell cell1=row1.createCell(0);
		
		cell1.setCellValue("OOOOOOOKKKKKKKK");
		

	}

}
