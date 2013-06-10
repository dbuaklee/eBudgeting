package biz.thaicom.utils.jacksonHibernate;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.datatype.hibernate4.Hibernate4Module;
import com.fasterxml.jackson.datatype.hibernate4.Hibernate4Module.Feature;


public class HibernateAwareObjectMapper extends ObjectMapper {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6680743790736637700L;
	
	private static final Logger logger = LoggerFactory.getLogger(HibernateAwareObjectMapper.class);
	 
	public HibernateAwareObjectMapper() {
		logger.info("registering Hiberbate4Module");
		Hibernate4Module hm = new Hibernate4Module();
		hm.configure(Feature.FORCE_LAZY_LOADING, false);
		hm.configure(Feature.SERIALIZE_IDENTIFIER_FOR_LAZY_NOT_LOADED_OBJECTS, true);
		
		this.configure(SerializationFeature.WRITE_NULL_MAP_VALUES, false);
		this.getSerializerProvider().setNullKeySerializer(new MyNullKeySerializer());
		
		registerModule(hm);
	}
	
	

	@Override
	public String writeValueAsString(Object value)
			throws JsonProcessingException {
		logger.debug("XXXX" + getSerializerProvider().getDefaultNullKeySerializer());
		return super.writeValueAsString(value);
	}



	class MyNullKeySerializer extends JsonSerializer<Object>
	{
	  @Override
	  public void serialize(Object nullKey, JsonGenerator jsonGenerator, SerializerProvider unused) 
	      throws IOException, JsonProcessingException {
		logger.debug("nullKey" + nullKey);
	    jsonGenerator.writeFieldName("");
	  }
	}
}



