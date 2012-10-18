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
@Table(name="BGT_REQUESTCOLUMN")
@SequenceGenerator(
		name="BGT_REQUESTCOLUMN_SEQ", 
		sequenceName="BGT_REQUESTCOLUMN_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class RequestColumn implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5065087026603553557L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_REQUESTCOLUMN_SEQ")
	private Long id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="COLUMN_BGT_FORMULACOLUMN_ID")
	private FormulaColumn column;
	
	@ManyToOne()
	@JoinColumn(name="PROPOSAL_BGT_BUDGET_PROPOSAL")
	private BudgetProposal proposal;
			
	
	@Basic
	private Integer amount;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public FormulaColumn getColumn() {
		return column;
	}

	public void setColumn(FormulaColumn column) {
		this.column = column;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public BudgetProposal getProposal() {
		return proposal;
	}

	public void setProposal(BudgetProposal proposal) {
		this.proposal = proposal;
	}

	
	
}
