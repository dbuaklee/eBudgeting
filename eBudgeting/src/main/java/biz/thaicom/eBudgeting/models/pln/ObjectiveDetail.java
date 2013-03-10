package biz.thaicom.eBudgeting.models.pln;

import java.io.Serializable;
import java.lang.reflect.Field;

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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import biz.thaicom.eBudgeting.models.hrx.Organization;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.fasterxml.jackson.databind.JsonNode;

@Entity
@Table(name="PLN_OBJECTIVEDETAIL")
@SequenceGenerator(name="PLN_OBJECTIVEDETAIL_SEQ", sequenceName="PLN_OBJECTIVEDETAIL_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class ObjectiveDetail implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(ObjectiveDetail.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = -6180654799984161197L;
	
	public ObjectiveDetail() {
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_OBJECTIVEDETAIL_SEQ")
	private Long id;
	
	/**
	 * ผู้รับผิดชอบ
	 */
	@Basic
	@Column(length=100)
	private String officerInCharge;
	
	/**
	 * เบอร์โทรศัพท์
	 */
	@Basic
	@Column(length=30)
	private String phoneNumber;
	
	/**
	 * email
	 */
	@Basic
	@Column(length=100)
	private String email;
	
	
	
	/**
	 * หลักการเหตุผล
	 */
	@Basic
	@Column(length=1000)
	private String reason;
	
	/**
	 * วัตถุประสงค์
	 */
	@Basic
	@Column(length=1000)
	private String projectObjective;
	
	/**
	 * วิธีการดำเนินการ  / การรวบรวมข้อมูลทั่วไป
	 */
	@Basic
	@Column(length=1000)
	private String methodology1;
	
	/**
	 * วิธีการดำเนินการ  / การรวบรวมข้อมูลด้านเศรษฐกิจและสังคม
	 */
	@Basic
	@Column(length=1000)
	private String methodology2;
	
	/**
	 * วิธีการดำเนินการ  / การรวบรวมข้อมูลทั่วไป
	 */
	@Basic
	@Column(length=1000)
	private String methodology3;
	
	/**
	 * สถานที่ดำเนินการ
	 */
	@Basic
	@Column(length=200)
	private String location;
	
	/**
	 * ระยะเวลาดำเนินการ
	 */
	@Basic
	@Column(length=200)
	private String timeframe;
	
	/**
	 * เป้าหมาย
	 */
	@Basic
	@Column(length=1000)
	private String targetDescription;
	
	/**
	 * ผลประโยชน์ที่คาดว่าจะได้รับ
	 */
	@Basic
	@Column(length=1000)
	private String outcome;
	
	/**
	 * ผลการดำเนินงาน
	 */
	@Basic
	@Column(length=1000)
	private String output;
	
	/**
	 * พื้นที่เป้าหมาย
	 */
	@Basic
	@Column(length=1000)
	private String targetArea;
	
	@ManyToOne
	@JoinColumn(name="PLN_OBJECTIVE_ID")
	private Objective forObjective;
	
	@ManyToOne
	@JoinColumn(name="HRX_ORGANIZATION_ID")
	private Organization owner;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getOfficerInCharge() {
		return officerInCharge;
	}

	public void setOfficerInCharge(String officerInCharge) {
		this.officerInCharge = officerInCharge;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getProjectObjective() {
		return projectObjective;
	}

	public void setProjectObjective(String projectOjective) {
		this.projectObjective = projectOjective;
	}

	public String getMethodology1() {
		return methodology1;
	}

	public void setMethodology1(String methodology1) {
		this.methodology1 = methodology1;
	}

	public String getMethodology2() {
		return methodology2;
	}

	public void setMethodology2(String methodology2) {
		this.methodology2 = methodology2;
	}

	public String getMethodology3() {
		return methodology3;
	}

	public void setMethodology3(String methodology3) {
		this.methodology3 = methodology3;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getTimeframe() {
		return timeframe;
	}

	public void setTimeframe(String timeframe) {
		this.timeframe = timeframe;
	}

	public String getTargetDescription() {
		return targetDescription;
	}

	public void setTargetDescription(String targetDescription) {
		this.targetDescription = targetDescription;
	}

	public String getOutcome() {
		return outcome;
	}

	public void setOutcome(String outcome) {
		this.outcome = outcome;
	}

	public String getOutput() {
		return output;
	}

	public void setOutput(String output) {
		this.output = output;
	}

	public String getTargetArea() {
		return targetArea;
	}

	public void setTargetArea(String targetArea) {
		this.targetArea = targetArea;
	}

	public Objective getForObjective() {
		return forObjective;
	}

	public void setForObjective(Objective forObjective) {
		this.forObjective = forObjective;
	}

	public Organization getOwner() {
		return owner;
	}

	public void setOwner(Organization owner) {
		this.owner = owner;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void updateField(String string, JsonNode jsonNode) {
		try {
			
			Field field = ObjectiveDetail.class.getDeclaredField(string);
			if(jsonNode != null && !jsonNode.asText().equals("null") ) {
				field.set(this, jsonNode.asText());
			} else {
				field.set(this, null);
			}
			
		} catch (NoSuchFieldException e) {
			return;
		} catch (SecurityException e) {
			return;
		} catch (IllegalArgumentException e) {
			return;
		} catch (IllegalAccessException e) {
			return;
		}
		
	}
	
	

}
