package biz.thaicom.eBudgeting.dao;



import java.io.BufferedReader;
import java.io.Closeable;

import java.io.IOException;
import java.io.InputStreamReader;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class BgtJdbcDao  implements BgtDao {
	private static final Logger logger = LoggerFactory.getLogger(BgtJdbcDao.class);
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private Resource sqlSampleResource;
	
	public void setSqlSampleResource(Resource sqlSampleResource) {
		this.sqlSampleResource = sqlSampleResource;
	}
	
	
	@Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
	
	public Integer executeFromFile() {
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(sqlSampleResource.getInputStream()));
            String line = null;
            while ((line = reader.readLine()) != null) {
            	
            	// now ommit the line which begin with --
            	if(line.matches("^--.*") || line.length() == 0 ) {
            		// this is comment and we just disregard!
            		logger.debug("comment line: " + line);
            	} else {
            		// we try to execute this in jdbc;
            		this.jdbcTemplate.execute(line);
            	}
            }
                
            	
            	
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            closeQuietly(reader);
        }
       

		
		return 0;
	}

	private void closeQuietly(Closeable c) {
		if (c != null) {
            try {
                c.close();
            } catch (IOException ignored) {}
        }

		
	}

}
