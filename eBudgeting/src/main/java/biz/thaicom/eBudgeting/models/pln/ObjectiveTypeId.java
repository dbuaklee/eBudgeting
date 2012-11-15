package biz.thaicom.eBudgeting.models.pln;

public enum ObjectiveTypeId {
	ROOT(100L), แผนงาน(101L), ผลผลิตโครงการ(102L), กิจกรรมหลัก(103L), 
	กิจกรรมรอง(104L), กิจกรรมย่อย(105L), กิจกรรมเสริม(106L),กิจกรรมสนับสนุน (107L);
	
	 private final long id;
	 private ObjectiveTypeId(long id) {
		this.id = id;
	 }
	 public long getValue() { return id; }
}
