package biz.thaicom.eBudgeting.repositories;

import org.hibernate.cfg.Configuration;
import org.hibernate.ejb.Ejb3Configuration;
import org.hibernate.tool.hbm2ddl.SchemaExport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;

@SuppressWarnings("deprecation")
public class DatabaseSchemaExport {
	@Autowired LocalContainerEntityManagerFactoryBean fb;
	
	public String getSchema() {
		String s = "";

		Configuration cfg =	new Ejb3Configuration().configure(fb.getPersistenceUnitInfo(),fb.getJpaPropertyMap()).getHibernateConfiguration();
	    

	    SchemaExport schema = new SchemaExport(cfg);
	    //schema.setOutputFile("resources/sql/schema.sql");
	    schema.create(true, false);
		return s;
	}
	
	
}
