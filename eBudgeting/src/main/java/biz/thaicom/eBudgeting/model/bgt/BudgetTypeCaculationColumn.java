package biz.thaicom.eBudgeting.model.bgt;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BUDGETTYPECALCULATIONCOLUMN")
@SequenceGenerator(
		name="BUDGETTYPECALCULATIONCOLUMN_SEQ", 
		sequenceName="BUDGETTYPECALCULATIONCOLUMN_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class BudgetTypeCaculationColumn implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -884672569445236675L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BUDGETTYPECALCULATIONSTRATEGY_SEQ")
	private Long id;

	@Basic
	@Column(name="IDX")
	private Integer index;

	private String columnName;
	
	private String unitName;
	
	private Boolean isFixed;
	
	private Long value;
	
}
