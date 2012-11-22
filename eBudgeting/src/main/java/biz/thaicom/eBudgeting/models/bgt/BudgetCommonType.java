package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_BUDGETCOMMONTYPE")
@SequenceGenerator(name="BGT_BUDGETCOMMONTYPE_SEQ", sequenceName="BGT_BUDGETCOMMONTYPE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
@JsonIgnoreProperties(ignoreUnknown = true)
public class BudgetCommonType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6438620330559138915L;

	
	// Field
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_BUDGETCOMMONTYPE_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@Basic
	private String code;

	@Basic
	private Integer fiscalYear;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}
	
	
}
