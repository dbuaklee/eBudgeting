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
@Table(name="ALLOCATIONRECORD")
@SequenceGenerator(name="ALLOCATIONRECORD_SEQ", sequenceName="ALLOCATIONRECORD_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class AllocationRecord implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8389152899753513205L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ALLOCATIONRECORD_SEQ")
	private Long id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="BUDGETPROPOSAL_ID")
	private BudgetProposal proposal;
	
	@Basic
	private Long amountAllocated;

}
