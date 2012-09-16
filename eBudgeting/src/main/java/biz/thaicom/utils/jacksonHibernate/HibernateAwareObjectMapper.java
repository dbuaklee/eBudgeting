package biz.thaicom.utils.jacksonHibernate;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.hibernate4.Hibernate4Module;
import com.fasterxml.jackson.datatype.hibernate4.Hibernate4Module.Feature;


public class HibernateAwareObjectMapper extends ObjectMapper {
	private static final Logger logger = LoggerFactory.getLogger(HibernateAwareObjectMapper.class);
	 
	public HibernateAwareObjectMapper() {
		logger.info("registering Hiberbate4Module");
		Hibernate4Module hm = new Hibernate4Module();
		hm.configure(Feature.FORCE_LAZY_LOADING, false);
		registerModule(hm);
		
	}
		  
}