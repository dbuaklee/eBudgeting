package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import biz.thaicom.eBudgeting.models.pln.Objective;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_ALLOCATIONRECORD")
@SequenceGenerator(name="BGT_ALLOCATIONRECORD_SEQ", sequenceName="BGT_ALLOCATIONRECORD_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class AllocationRecord implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8389152899753513205L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_ALLOCATIONRECORD_SEQ")
	private Long id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="OBJECTIVE_PLN_OBJECTIVE_ID")
	private Objective forObjective;
	
	@Basic
	private Long amountAllocated;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="BUDGETTYPE_BGT_ID")
	private BudgetType budgetType;
	
	@Basic
	@Column(name="IDX")
	private Integer index;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}



	public Objective getForObjective() {
		return forObjective;
	}

	public void setForObjective(Objective forObjective) {
		this.forObjective = forObjective;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public Long getAmountAllocated() {
		return amountAllocated;
	}

	public void setAmountAllocated(Long amountAllocated) {
		this.amountAllocated = amountAllocated;
	}

	public BudgetType getBudgetType() {
		return budgetType;
	}

	public void setBudgetType(BudgetType budgetType) {
		this.budgetType = budgetType;
	}
	
	

}
