package biz.thaicom.eBudgeting.view;

import java.util.HashMap;
import java.util.Map;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class Track1XLSView extends AbstractPOIExcelView {

	@Override
	protected Workbook createWorkbook() {
		return new XSSFWorkbook();
	}

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
        Map<String, CellStyle> styles = createStyles(workbook);
		Sheet sheet = workbook.createSheet("sheet1");

		Row row1 = sheet.createRow(0);
		Cell r1c1 = row1.createCell(0);
		r1c1.setCellValue("รายงานสรุปแผนและผลการอนุมัติการสงเคราะห์ ประจำปีงบประมาณ 2554");
		r1c1.setCellStyle(styles.get("title"));
		
		Row row2 = sheet.createRow(2);
		Cell r2c1 = row2.createCell(0);
		r2c1.setCellValue("ลำดับ");
		r2c1.setCellStyle(styles.get("header"));
				
		Cell r2c2 = row2.createCell(1);
		r2c2.setCellValue("หน่วยงาน");
		r2c2.setCellStyle(styles.get("header"));

		Cell r2c3 = row2.createCell(2);
		r2c3.setCellValue("แผน");
		r2c3.setCellStyle(styles.get("header"));

		Cell r2c4 = row2.createCell(3);
		r2c4.setCellValue("ตุลาคม");
		r2c4.setCellStyle(styles.get("header"));

		Cell r2c5 = row2.createCell(4);
		r2c5.setCellValue("พฤศจิกายน");
		r2c5.setCellStyle(styles.get("header"));

		Cell r2c6 = row2.createCell(5);
		r2c6.setCellValue("ธันวาคม");
		r2c6.setCellStyle(styles.get("header"));

		Cell r2c7 = row2.createCell(6);
		r2c7.setCellValue("มกราคม");
		r2c7.setCellStyle(styles.get("header"));

		Cell r2c8 = row2.createCell(7);
		r2c8.setCellValue("กุมภาพันธุ์");
		r2c8.setCellStyle(styles.get("header"));

		Cell r2c9 = row2.createCell(8);
		r2c9.setCellValue("มีนาคม");
		r2c9.setCellStyle(styles.get("header"));

		Cell r2c10 = row2.createCell(9);
		r2c10.setCellValue("เมษายน");
		r2c10.setCellStyle(styles.get("header"));

		Cell r2c11 = row2.createCell(10);
		r2c11.setCellValue("พฤษภาคม");
		r2c11.setCellStyle(styles.get("header"));

		Cell r2c12 = row2.createCell(11);
		r2c12.setCellValue("มิถุนายน");
		r2c12.setCellStyle(styles.get("header"));

		Cell r2c13 = row2.createCell(12);
		r2c13.setCellValue("กรกฎาคม");
		r2c13.setCellStyle(styles.get("header"));

		Cell r2c14 = row2.createCell(13);
		r2c14.setCellValue("สิงหาคม");
		r2c14.setCellStyle(styles.get("header"));

		Cell r2c15 = row2.createCell(14);
		r2c15.setCellValue("กันยายน");
		r2c15.setCellStyle(styles.get("header"));

		Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.234:1521:tmgdb", "mis2", "mis2");
		PreparedStatement ps = null;
		Statement st = connection.createStatement();
		ResultSet rs = st.executeQuery("select mis_seq, org_id, org_code||' '||org_name from glb_organization where org_id <> 0 and org_org_id = 0 order by mis_seq");

		int i = 3;
		int j = 0;
		while (rs.next()) {
			Row rows = sheet.createRow(i);
			
			Cell rsc0 = rows.createCell(0);
			rsc0.setCellValue(rs.getInt(1));
			rsc0.setCellStyle(styles.get("cellcenter"));
			
			Cell rsc1 = rows.createCell(1);
			rsc1.setCellValue(rs.getString(3));
			rsc1.setCellStyle(styles.get("cellleft"));
			
			Cell rsc2 = rows.createCell(2);
			rsc2.setCellValue("แผน");
			rsc2.setCellStyle(styles.get("cellcenter"));

			Statement st1 = connection.createStatement();
			ResultSet rs1 = st1.executeQuery("select f_code, app_qty from mis_month t1, (select month, sum(app_qty) app_qty from mis2_data_plan where fiscal_year = 2554 and main_id = " + rs.getString(2) + "  group by month) t2 where t1.m_code = t2.month (+) order by f_code");
			while (rs1.next()) {
				Cell rscs = rows.createCell(rs1.getInt(1)+2);
				rscs.setCellValue(rs1.getInt(2));
				rscs.setCellStyle(styles.get("cellright"));
			}
			rs1.close();

			Row rows2 = sheet.createRow(i+1);
			Cell rs2c2 = rows2.createCell(2);
			rs2c2.setCellValue("ผล");
			rs2c2.setCellStyle(styles.get("cellcenter"));
			
			Statement st2 = connection.createStatement();
			ResultSet rs2 = st2.executeQuery("select f_code, app_qty from mis_month t1, (select f_get_period2fmonth(period) mon, sum(app_qty) app_qty from mis2_data_result where fiscal_year = 2554 and main_id = " + rs.getString(2) + " group by f_get_period2fmonth(period)) t2 where t1.f_code = t2.mon (+) order by f_code");
			while (rs2.next()) {
				Cell rs2cs = rows2.createCell(rs2.getInt(1)+2);
				rs2cs.setCellValue(rs2.getInt(2));
				rs2cs.setCellStyle(styles.get("cellright"));
			}
			rs2.close();

//			Statement st1 = connection.createStatement();
//			for (j=1;j<=12;j++) {
//				ResultSet rs1 = st1.executeQuery("select sum(t1.app_qty) from mis2_data_plan t1, mis_month t2 where t1.month = t2.m_code and t1.fiscal_year = 2554 and t1.main_id = " + rs.getString(2) + " and t2.f_code = " + j);
//				rs1.next();
//				Cell rscs = rows.createCell(j+2);
//				rscs.setCellValue(rs1.getInt(1));
//				rscs.setCellStyle(styles.get("cellright"));
//				rs1.close();
				
//				ResultSet rs2 = st1.executeQuery("select sum(app_qty) from mis2_data_result where fiscal_year = 2554 and main_id = " + rs.getString(2) + " and f_get_period2fmonth(period) = " + j);
//				rs2.next();
//				Cell rs2cs = rows2.createCell(j+2);
//				rs2cs.setCellValue(rs2.getInt(1));
//				rs2cs.setCellStyle(styles.get("cellright"));
//				rs2.close();
//			}
			

//			Statement st2 = connection.createStatement();
//			ResultSet rs2 = st2.executeQuery("select f_get_period2fmonth(period), sum(app_qty) from mis2_data_result where fiscal_year = 2554 and main_id = " + rs.getString(2) + " group by f_get_period2fmonth(period)");
//			while (rs2.next()) {
//				Cell rscs = rows2.createCell(rs2.getInt(1)+2);
//				rscs.setCellValue(rs2.getInt(2));
//				rscs.setCellStyle(styles.get("cellright"));
//			}
//			rs2.close();

			i = i + 2;
		}
		rs.close();
		connection.close();
		sheet.autoSizeColumn(1);
		sheet.autoSizeColumn(2);
	}

    private static Map<String, CellStyle> createStyles(Workbook wb){
        Map<String, CellStyle> styles = new HashMap<String, CellStyle>();

        short borderColor = IndexedColors.GREY_50_PERCENT.getIndex();

        CellStyle style;
        Font titleFont = wb.createFont();
        titleFont.setFontHeightInPoints((short)18);
        titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_LEFT);
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

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
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

        return styles;
    }

}
