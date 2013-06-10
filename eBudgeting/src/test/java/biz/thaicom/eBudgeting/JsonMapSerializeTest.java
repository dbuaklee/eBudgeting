package biz.thaicom.eBudgeting;

import static org.junit.Assert.*;

import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.collection.internal.PersistentMap;
import org.junit.Test;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;

public class JsonMapSerializeTest {

	MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();

	@Test
	public void testSerialization() {
	

	    Map<Integer, String> map = new HashMap();
	    map.put(1,"b");

	    StringWriter sw = new StringWriter();
	    try {
	        converter.getObjectMapper().writeValue(sw, map);
	    }
	    catch (Exception e) {
	        e.printStackTrace();
	        fail();
	    }

	    assertEquals(sw.toString(), "{\"1\":\"b\"}");
	}
	
}
