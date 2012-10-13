package biz.thaicom.eBudgeting.model.bgt;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BUDGETTYPECALCULATIONSTRATEGY")
@SequenceGenerator(
		name="BUDGETTYPECALCULATIONSTRATEGY_SEQ", 
		sequenceName="BUDGETTYPECALCULATIONSTRATEGY_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class BudgetTypeCalculationStrategy  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1200551194620169196L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BUDGETTYPECALCULATIONSTRATEGY_SEQ")
	private Long id;
	
	private Integer fiscalYear;
	
	private BudgetType budgetType;
	
	private Integer numberColumn;

	List<BudgetTypeCaculationColumn> calculationColumns;
}
