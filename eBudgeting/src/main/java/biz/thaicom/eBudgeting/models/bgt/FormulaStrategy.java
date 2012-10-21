package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_FORMULASTRATEGY")
@SequenceGenerator(
		name="BGT_FORMULASTRATEGY_SEQ", 
		sequenceName="BGT_FORMULASTRATEGY_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class FormulaStrategy  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1200551194620169196L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_FORMULASTRATEGY_SEQ")
	private Long id;
	
	@Basic
	private Integer fiscalYear;

	@Basic
	private String name;
	
	@ManyToOne
	@JoinColumn(name="TYPE_BGT_BUDGETTYPE_ID")
	private BudgetType type;
	
	@Basic
	private Integer numberColumns;
	
	@Basic
	@Column(name="IDX")
	private Integer index;

	@OneToMany(fetch=FetchType.LAZY, mappedBy="strategy",
			cascade=CascadeType.REMOVE)
	@OrderColumn(name="IDX")
	private List<FormulaColumn> formulaColumns;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	public BudgetType getType() {
		return type;
	}

	public void setType(BudgetType type) {
		this.type = type;
	}

	public Integer getNumberColumns() {
		return numberColumns;
	}

	public void setNumberColumns(Integer numberColumns) {
		this.numberColumns = numberColumns;
	}

	public List<FormulaColumn> getFormulaColumns() {
		return formulaColumns;
	}

	public void setFormulaColumns(List<FormulaColumn> formulaColumns) {
		this.formulaColumns = formulaColumns;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	
	

}
