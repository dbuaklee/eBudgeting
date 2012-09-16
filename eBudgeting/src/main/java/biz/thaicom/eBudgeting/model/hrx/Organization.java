package biz.thaicom.eBudgeting.model.hrx;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="ORGANIZATION")
@SequenceGenerator(name="ORGANIZATION_SEQ", sequenceName="ORGANIZATION_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Organization implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7959577438132453361L;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ORGANIZATION_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@Basic
	private String abbr;
	
	@Basic
	private Integer index;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="ORGANIZATION_PARENT_ID")
	private Organization parent;
	
	@OneToMany(mappedBy="parent", fetch=FetchType.LAZY)
	private List<Organization> children;

}
