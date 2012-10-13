package biz.thaicom.eBudgeting.model.bgt;

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
@Table(name="BUDGETTYPEREQUESTCOLUMN")
@SequenceGenerator(
		name="BUDGETTYPEREQUESTCOLUMN_SEQ", 
		sequenceName="BUDGETTYPEREQUESTCOLUMN_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class BudgetTypeRequestColumn implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5065087026603553557L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BUDGETTYPEREQUESTCOLUMN_SEQ")
	private Long id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="BUDGETTYPEFORMULACOLUMN_ID")
	private BudgetTypeFormulaColumn column;
	
	@Basic
	private Integer amount;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public BudgetTypeFormulaColumn getColumn() {
		return column;
	}

	public void setColumn(BudgetTypeFormulaColumn column) {
		this.column = column;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	
	
}
