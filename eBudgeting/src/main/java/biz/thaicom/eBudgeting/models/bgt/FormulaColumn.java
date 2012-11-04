package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
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
@Table(name = "BGT_FORMULACOLUMN")
@SequenceGenerator(name = "BGT_FORMULACOLUMN_SEQ", sequenceName = "BGT_FORMULACOLUMN_SEQ", allocationSize = 1)
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class FormulaColumn implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -884672569445236675L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BGT_FORMULACOLUMN_SEQ")
	private Long id;

	@Basic
	@Column(name = "IDX")
	private Integer index;

	@ManyToOne
	@JoinColumn(name = "STRATEGY_BGT_STRATEGY_ID")
	private FormulaStrategy strategy;

	@Basic
	private String columnName;

	@Basic
	private String unitName;

	@Basic
	private Boolean isFixed;

	@Basic
	private Long value;
	
	@Basic
	private Long allocatedValue;

	public Long getId() {
		return id;
	}

	
	
	public FormulaColumn() {
		this.id = null;
	}



	public void setId(Long id) {
		this.id = id;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public FormulaStrategy getStrategy() {
		return strategy;
	}

	public void setStrategy(FormulaStrategy strategy) {
		this.strategy = strategy;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public Boolean getIsFixed() {
		return isFixed;
	}

	public void setIsFixed(Boolean isFixed) {
		this.isFixed = isFixed;
	}

	public Long getValue() {
		return value;
	}

	public void setValue(Long value) {
		this.value = value;
	}

	public Long getAllocatedValue() {
		return allocatedValue;
	}

	public void setAllocatedValue(Long allocatedValue) {
		this.allocatedValue = allocatedValue;
	}
	

}
