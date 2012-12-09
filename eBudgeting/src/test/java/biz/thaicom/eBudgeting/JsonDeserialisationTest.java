package biz.thaicom.eBudgeting;

import static org.junit.Assert.*;

import static org.hamcrest.CoreMatchers.*;

import org.junit.Test;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;

import biz.thaicom.eBudgeting.models.bgt.FormulaColumn;
import biz.thaicom.eBudgeting.models.bgt.ProposalStrategy;
import biz.thaicom.eBudgeting.models.pln.Objective;


public class JsonDeserialisationTest {

	MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();


	@Test
	public void allClassesUsedByOurControllersShouldBeDeserialisableByJackson()
			throws Exception {
		assertCanBeMapped(FormulaColumn.class);
		assertCanBeMapped(Objective.class);

	}
	
	@Test
	public void JsonShouldBeReadable() throws Exception {
		String src= "" +
				"{\"formulaStrategy\":{\"id\":100}," +
				"\"proposal\":{\"id\":100},\"totalCalculatedAmount\":10500}";
		converter.getObjectMapper().readValue(src, ProposalStrategy.class);
	}

	private void assertCanBeMapped(Class<?> classToTest) {
		String message = String
				.format("%s is not deserialisable, check the swallowed exception in StdDeserializerProvider.hasValueDeserializerFor",
						classToTest.getSimpleName());
		
		
		
		 assertThat(message, converter.canRead(classToTest, MediaType.APPLICATION_JSON), is(true));

	}
}
