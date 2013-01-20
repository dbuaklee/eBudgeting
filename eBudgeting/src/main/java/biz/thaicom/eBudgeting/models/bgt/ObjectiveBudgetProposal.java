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

import biz.thaicom.eBudgeting.models.hrx.Organization;
import biz.thaicom.eBudgeting.models.pln.Objective;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_OBJBUDGETPROPOSAL")
@SequenceGenerator(name="BGT_OBJBUDGETPROPOSAL_SEQ", sequenceName="BGT_OBJBUDGETPROPOSAL_SEQ", allocationSize=1)
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class ObjectiveBudgetProposal implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8480014876053926515L;


	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_OBJBUDGETPROPOSAL_SEQ")
	private Long id;
	
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="BUDGETTYPE_BGT_BUDGETTYPE_ID")
	private BudgetType budgetType;
	
	
	@Basic
	private String name;
	
	@Basic
	private Long amountRequest;
	
	@Basic
	private Long amountRequestNext1Year;
	
	@Basic
	private Long amountRequestNext2Year;
	
	@Basic
	private Long amountRequestNext3Year;
	
	
	@Basic
	private Long amountAllocated;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="ORGANIZATION_ID")
	private Organization owner;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="OBJECTIVE_ID")
	private Objective forObjective;

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getAmountRequest() {
		return amountRequest;
	}

	public void setAmountRequest(Long amountRequest) {
		this.amountRequest = amountRequest;
	}

	public Long getAmountRequestNext1Year() {
		return amountRequestNext1Year;
	}

	public void setAmountRequestNext1Year(Long amountRequestNext1Year) {
		this.amountRequestNext1Year = amountRequestNext1Year;
	}

	public Long getAmountRequestNext2Year() {
		return amountRequestNext2Year;
	}

	public void setAmountRequestNext2Year(Long amountRequestNext2Year) {
		this.amountRequestNext2Year = amountRequestNext2Year;
	}

	public Long getAmountRequestNext3Year() {
		return amountRequestNext3Year;
	}

	public void setAmountRequestNext3Year(Long amountRequestNext3Year) {
		this.amountRequestNext3Year = amountRequestNext3Year;
	}

	public Long getAmountAllocated() {
		return amountAllocated;
	}

	public void setAmountAllocated(Long amountAllocated) {
		this.amountAllocated = amountAllocated;
	}

	public Organization getOwner() {
		return owner;
	}

	public void setOwner(Organization owner) {
		this.owner = owner;
	}

	public Objective getForObjective() {
		return forObjective;
	}

	public void setForObjective(Objective forObjective) {
		this.forObjective = forObjective;
	}

	public void copyValue(ObjectiveBudgetProposal obp) {
		this.amountRequest = nullReturnZero(obp.getAmountRequest());
		this.amountAllocated = nullReturnZero(obp.getAmountAllocated());
		this.amountRequestNext1Year = nullReturnZero(obp.getAmountRequestNext1Year());
		this.amountRequestNext2Year = nullReturnZero(obp.getAmountRequestNext2Year());
		this.amountRequestNext3Year = nullReturnZero(obp.getAmountRequestNext3Year());
	}

	private long nullReturnZero(Long longValue) {
		return longValue == null ? 0L: longValue.longValue();
	}

	public void adjustAmount(ObjectiveBudgetProposal obp, ObjectiveBudgetProposal obpOldValue) {
		this.amountRequest = nullReturnZero(this.amountRequest) + nullReturnZero(obp.getAmountRequest()) - nullReturnZero(obpOldValue.getAmountRequest());
		this.amountAllocated = nullReturnZero(this.amountAllocated) + nullReturnZero(obp.getAmountAllocated()) - nullReturnZero(obpOldValue.getAmountAllocated());
		this.amountRequestNext1Year = nullReturnZero(this.amountRequestNext1Year) + nullReturnZero(obp.getAmountRequestNext1Year()) - nullReturnZero(obpOldValue.getAmountRequestNext1Year());
		this.amountRequestNext2Year = nullReturnZero(this.amountRequestNext2Year) + nullReturnZero(obp.getAmountRequestNext2Year()) - nullReturnZero(obpOldValue.getAmountRequestNext2Year());
		this.amountRequestNext3Year = nullReturnZero(this.amountRequestNext3Year) + nullReturnZero(obp.getAmountRequestNext3Year()) - nullReturnZero(obpOldValue.getAmountRequestNext3Year());
		
	}
	
	



	
	
}
