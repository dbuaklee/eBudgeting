package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_FISCALBUDGETYPE")
@SequenceGenerator(name="BGT_FISCALBUDGETYPE_SEQ", sequenceName="BGT_FISCALBUDGETYPE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class FiscalBudgetType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5466268930439563453L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_FISCALBUDGETYPE_SEQ")
	private Long id;

	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="BUDGETTYPE_BGT_BUDGETTYPE_ID")
	private BudgetType budgetType;
	
	@Basic
	private Integer fiscalYear;
	
	@Basic
	private Boolean isMainType;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public BudgetType getBudgetType() {
		return budgetType;
	}

	public void setBudgetType(BudgetType budgetType) {
		this.budgetType = budgetType;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	public Boolean getIsMainType() {
		return isMainType;
	}

	public void setIsMainType(Boolean isMainType) {
		this.isMainType = isMainType;
	}
	
	
	
}
