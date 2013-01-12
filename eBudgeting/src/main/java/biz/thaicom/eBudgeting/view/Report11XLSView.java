package biz.thaicom.eBudgeting.view;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;


public class Report11XLSView extends AbstractPOIExcelView {

	@Override
	protected Workbook createWorkbook() {
		return new XSSFWorkbook();
	}

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ObjectiveType type = (ObjectiveType) model.get("type");
		List<Objective> objectiveList = (List<Objective>) model.get("objectiveList");
	
		Sheet sheet11=workbook.createSheet("Sheet11");
		Row firstRow=sheet11.createRow(0);
		Cell cell1=firstRow.createCell(0);
		cell1.setCellValue("ทะเบียน " + type.getName());
		
		Row secondRow=sheet11.createRow(1);
		Cell cellA=secondRow.createCell(0);
		cellA.setCellValue("รหัส");
		
		Cell cellB=secondRow.createCell(1);
		cellB.setCellValue("ชื่อ " + type.getName() );
		
		int i = 2 ;
		for (Objective o:objectiveList) {
			Row thirdRow=sheet11.createRow(i);
			Cell cellx=thirdRow.createCell(0);
			cellx.setCellValue(o.getCode());
			Cell celly=thirdRow.createCell(1);
			celly.setCellValue(o.getName());
		i++;
		}


				
				
	}
	

}
