package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
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

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_PROPOSALSTRATEGY")
@SequenceGenerator(
		name="BGT_PROPOSALSTRATEGY_SEQ", 
		sequenceName="BGT_PROPOSALSTRATEGY_SEQ", allocationSize=1)
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class ProposalStrategy implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8803018798530957948L;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_PROPOSALSTRATEGY_SEQ")
	private Long id;
	
	@ManyToOne()
	@JoinColumn(name="BUDGETPROPOSAL_ID")
	private BudgetProposal proposal;
	
	@Basic
	private Long totalCalculatedAmount;
	
	@Basic
	private String name;
	
	@ManyToOne
	@JoinColumn(name="FORMULASTRATEGY_ID")
	private FormulaStrategy formulaStrategy;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="proposalStrategy",
			cascade=CascadeType.REMOVE)
	private List<RequestColumn> requestColumns;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public FormulaStrategy getFormulaStrategy() {
		return formulaStrategy;
	}

	public void setFormulaStrategy(FormulaStrategy formulaStrategy) {
		this.formulaStrategy = formulaStrategy;
	}

	public List<RequestColumn> getRequestColumns() {
		return requestColumns;
	}

	public void setRequestColumns(List<RequestColumn> requestColumns) {
		this.requestColumns = requestColumns;
	}

	public BudgetProposal getProposal() {
		return proposal;
	}

	public void setProposal(BudgetProposal proposal) {
		this.proposal = proposal;
	}

	public Long getTotalCalculatedAmount() {
		return totalCalculatedAmount;
	}

	public void setTotalCalculatedAmount(Long totalCalculatedAmount) {
		this.totalCalculatedAmount = totalCalculatedAmount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	

}
