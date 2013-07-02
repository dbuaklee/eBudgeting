-- Database Schema changelog
-- Recent changes are intentionally put at the end so we can 
-- easily replay from eariler version


-- Version 1 / initialize 
-- Modified Date: BEFORE JAN 20, 2012 
	create table APP_INFO (DB_VERSION number);
	insert into APP_INFO values (1);


    create table BGT_ALLOCATIONRECORD (
        id number(19,0) not null,
        amountAllocated number(19,0),
        IDX number(10,0),
        BUDGETTYPE_BGT_ID number(19,0),
        OBJECTIVE_PLN_OBJECTIVE_ID number(19,0),
        primary key (id)
    );

    create table BGT_BUDGETCOMMONTYPE (
        id number(19,0) not null,
        code varchar2(255 char),
        fiscalYear number(10,0),
        name varchar2(255 char),
        primary key (id)
    );

    create table BGT_BUDGETLEVEL (
        id number(19,0) not null,
        levelNumber number(10,0),
        name varchar2(255 char),
        primary key (id)
    );

    create table BGT_BUDGETPROPOSAL (
        id number(19,0) not null,
        amountAllocated number(19,0),
        amountRequest number(19,0),
        amountRequestNext1Year number(19,0),
        amountRequestNext2Year number(19,0),
        amountRequestNext3Year number(19,0),
        name varchar2(255 char),
        BUDGETTYPE_BGT_BUDGETTYPE_ID number(19,0),
        OBJECTIVE_ID number(19,0),
        ORGANIZATION_ID number(19,0),
        primary key (id)
    );

    create table BGT_BUDGETSIGNOFF (
        id number(19,0) not null,
        fiscalYear number(10,0),
        round number(10,0),
        status varchar2(255 char),
        ORGANIZATION_ID number(19,0),
        primary key (id)
    );

    create table BGT_BUDGETSIGNOFFLOG (
        id number(19,0) not null,
        round number(10,0),
        timestamp date,
        toStatus varchar2(255 char),
        USER_ID number(19,0),
        primary key (id)
    );

    create table BGT_BUDGETTYPE (
        id number(19,0) not null,
        code number(10,0),
        fiscalYear number(10,0),
        IDX number(10,0),
        lineNumber number(10,0),
        name varchar2(255 char),
        parentLevel number(10,0),
        parentPath varchar2(255 char),
        COMMONTYPE_BGT_ID number(19,0),
        BGT_BUDGETLEVEL_ID number(19,0),
        PARENT_BGT_BUDGETTYPE_ID number(19,0),
        PLN_UNIT_ID number(19,0),
        primary key (id)
    );

    create table BGT_FISCALBUDGETYPE (
        id number(19,0) not null,
        fiscalYear number(10,0),
        isMainType number(1,0),
        BUDGETTYPE_BGT_BUDGETTYPE_ID number(19,0),
        primary key (id)
    );

    create table BGT_FORMULACOLUMN (
        id number(19,0) not null,
        allocatedValue number(19,0),
        columnName varchar2(255 char),
        IDX number(10,0),
        isFixed number(1,0),
        unitName varchar2(255 char),
        value number(19,0),
        STRATEGY_BGT_STRATEGY_ID number(19,0),
        primary key (id)
    );

    create table BGT_FORMULASTRATEGY (
        id number(19,0) not null,
        fiscalYear number(10,0),
        IDX number(10,0),
        isStandardItem number(1,0),
        name varchar2(255 char),
        standardPrice number(10,0),
        COMMONTYPE_BGT_ID number(19,0),
        TYPE_BGT_BUDGETTYPE_ID number(19,0),
        UNIT_ID number(19,0),
        primary key (id)
    );

    create table BGT_OBJBUDGETPROPOSAL (
        id number(19,0) not null,
        amountAllocated number(19,0),
        amountRequest number(19,0),
        amountRequestNext1Year number(19,0),
        amountRequestNext2Year number(19,0),
        amountRequestNext3Year number(19,0),
        name varchar2(255 char),
        BUDGETTYPE_BGT_BUDGETTYPE_ID number(19,0),
        OBJECTIVE_ID number(19,0),
        ORGANIZATION_ID number(19,0),
        primary key (id)
    );

    create table BGT_OBJECTIVE_BUDGETTYPE (
        PLN_OBJECTIVE_id number(19,0) not null,
        budgetTypes_id number(19,0) not null
    );

    create table BGT_PROPOSALSTRATEGY (
        id number(19,0) not null,
        amountRequestNext1Year number(19,0),
        amountRequestNext2Year number(19,0),
        amountRequestNext3Year number(19,0),
        name varchar2(255 char),
        targetValue number(19,0),
        totalCalculatedAllocatedAmount number(19,0),
        totalCalculatedAmount number(19,0),
        FORMULASTRATEGY_ID number(19,0),
        BUDGETPROPOSAL_ID number(19,0),
        PLN_UNIT_ID number(19,0),
        primary key (id)
    );

    create table BGT_REQUESTCOLUMN (
        id number(19,0) not null,
        allocatedAmount number(10,0),
        amount number(10,0),
        COLUMN_BGT_FORMULACOLUMN_ID number(19,0),
        BGT_PROPOSALSTRATEGY_ID number(19,0),
        primary key (id)
    );

    create table BGT_RESERVEDBUDGET (
        id number(19,0) not null,
        amountReserved number(19,0),
        BUDGETTYPE_BGT_ID number(19,0),
        OBJECTIVE_PLN_OBJECTIVE_ID number(19,0),
        primary key (id)
    );

    create table HRX_ORGANIZATION (
        id number(19,0) not null,
        abbr varchar2(255 char),
        IDX number(10,0),
        name varchar2(255 char),
        PARENT_HRX_ORGANIZATION_ID number(19,0),
        primary key (id)
    );

    create table HRX_PERSON (
        id number(19,0) not null,
        firstName varchar2(255 char),
        lastName varchar2(255 char),
        WORKAT_HRX_ORGANIZATION_ID number(19,0),
        primary key (id)
    );

    create table PLN_JOIN_OBJECTIVENAME_TARGET (
        PLN_OBJECTIVENAME_id number(19,0) not null,
        targets_id number(19,0) not null
    );

    create table PLN_JOIN_OBJECTIVE_TARGET (
        forObjectives_id number(19,0) not null,
        targets_id number(19,0) not null
    );

    create table PLN_JOIN_OBJECTIVE_UNIT (
        PLN_OBJECTIVE_id number(19,0) not null,
        units_id number(19,0) not null
    );

    create table PLN_OBJECTIVE (
        id number(19,0) not null,
        code varchar2(255 char),
        fiscalYear number(10,0),
        IDX number(10,0),
        isLeaf number(1,0),
        lineNumber number(10,0),
        name varchar2(255 char),
        parentLevel number(10,0),
        parentPath varchar2(255 char),
        NAME_PLN_OBJECTIVENAME_ID number(19,0) not null,
        PARENT_PLN_OBJECTIVE_ID number(19,0),
        TYPE_PLN_OBJECTIVETYPE_ID number(19,0) not null,
        primary key (id)
    );

    create table PLN_OBJECTIVENAME (
        id number(19,0) not null,
        code varchar2(255 char),
        fiscalYear number(10,0),
        IDX number(10,0),
        name varchar2(255 char),
        TYPE_PLN_OBJECTIVETYPE_ID number(19,0) not null,
        primary key (id)
    );

    create table PLN_OBJECTIVERELATIONS (
        id number(19,0) not null,
        fiscalYear number(10,0),
        CHILD_OBJECTIVETYPE_ID number(19,0),
        OBJECTIVE_ID number(19,0),
        PARENT_OBJECTIVE_ID number(19,0),
        PARENT_OBJECTIVETYPE_ID number(19,0),
        primary key (id)
    );

    create table PLN_OBJECTIVETARGET (
        id number(19,0) not null,
        fiscalYear number(10,0),
        isSumable number(1,0),
        name varchar2(255 char),
        TARGETUNIT_ID number(19,0),
        primary key (id)
    );

    create table PLN_OBJECTIVETYPE (
        id number(19,0) not null,
        fiscalYear number(10,0),
        isLeaf number(1,0),
        name varchar2(255 char),
        parentPath varchar2(255 char),
        PARENT_PLN_OBJECTIVETYPE_ID number(19,0),
        primary key (id)
    );

    create table PLN_TARGETUNIT (
        id number(19,0) not null,
        name varchar2(255 char),
        primary key (id)
    );

    create table PLN_TARGETVALUE (
        id number(19,0) not null,
        allocatedValue number(19,0),
        requestedValue number(19,0),
        FOROBJECTIVE_ID number(19,0),
        OWNER_ORAGANIZATION_ID number(19,0),
        OBJECTIVETARGET_ID number(19,0),
        primary key (id)
    );

    create table PLN_TARGETVALUEALLOCRECORD (
        id number(19,0) not null,
        amountAllocated number(19,0),
        IDX number(10,0),
        OBJECTIVE_PLN_OBJECTIVE_ID number(19,0),
        OBJECTIVETARGET_ID number(19,0),
        primary key (id)
    );

    create table SEC_USER (
        id number(19,0) not null,
        password varchar2(255 char),
        username varchar2(255 char),
        PERSON_HRX_PERSON_ID number(19,0),
        primary key (id)
    );

    alter table BGT_ALLOCATIONRECORD 
        add constraint FKC9FE6AC1ECC9FC9B 
        foreign key (BUDGETTYPE_BGT_ID) 
        references BGT_BUDGETTYPE;

    alter table BGT_ALLOCATIONRECORD 
        add constraint FKC9FE6AC16410101F 
        foreign key (OBJECTIVE_PLN_OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table BGT_BUDGETPROPOSAL 
        add constraint FK9E0702C7CCCD6CCC 
        foreign key (ORGANIZATION_ID) 
        references HRX_ORGANIZATION;

    alter table BGT_BUDGETPROPOSAL 
        add constraint FK9E0702C7C7B06F7B 
        foreign key (BUDGETTYPE_BGT_BUDGETTYPE_ID) 
        references BGT_BUDGETTYPE;

    alter table BGT_BUDGETPROPOSAL 
        add constraint FK9E0702C7304AFCAC 
        foreign key (OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table BGT_BUDGETSIGNOFF 
        add constraint FKB506AFFDCCCD6CCC 
        foreign key (ORGANIZATION_ID) 
        references HRX_ORGANIZATION;

    alter table BGT_BUDGETSIGNOFFLOG 
        add constraint FK353B1A0711474C34 
        foreign key (USER_ID) 
        references SEC_USER;

    alter table BGT_BUDGETTYPE 
        add constraint FK1C85618F1176B719 
        foreign key (BGT_BUDGETLEVEL_ID) 
        references BGT_BUDGETLEVEL;

    alter table BGT_BUDGETTYPE 
        add constraint FK1C85618FCBE0BFCC 
        foreign key (PLN_UNIT_ID) 
        references PLN_TARGETUNIT;

    alter table BGT_BUDGETTYPE 
        add constraint FK1C85618F62AF6640 
        foreign key (COMMONTYPE_BGT_ID) 
        references BGT_BUDGETCOMMONTYPE;

    alter table BGT_BUDGETTYPE 
        add constraint FK1C85618F467AF66 
        foreign key (PARENT_BGT_BUDGETTYPE_ID) 
        references BGT_BUDGETTYPE;

    alter table BGT_FISCALBUDGETYPE 
        add constraint FK9F03331BC7B06F7B 
        foreign key (BUDGETTYPE_BGT_BUDGETTYPE_ID) 
        references BGT_BUDGETTYPE;

    alter table BGT_FORMULACOLUMN 
        add constraint FK62638C8CB32B5513 
        foreign key (STRATEGY_BGT_STRATEGY_ID) 
        references BGT_FORMULASTRATEGY;

    alter table BGT_FORMULASTRATEGY 
        add constraint FKE76AE3297234B1F6 
        foreign key (TYPE_BGT_BUDGETTYPE_ID) 
        references BGT_BUDGETTYPE;

    alter table BGT_FORMULASTRATEGY 
        add constraint FKE76AE32962AF6640 
        foreign key (COMMONTYPE_BGT_ID) 
        references BGT_BUDGETCOMMONTYPE;

    alter table BGT_FORMULASTRATEGY 
        add constraint FKE76AE32956DF7919 
        foreign key (UNIT_ID) 
        references PLN_TARGETUNIT;

    alter table BGT_OBJBUDGETPROPOSAL 
        add constraint FK25D5123ECCCD6CCC 
        foreign key (ORGANIZATION_ID) 
        references HRX_ORGANIZATION;

    alter table BGT_OBJBUDGETPROPOSAL 
        add constraint FK25D5123EC7B06F7B 
        foreign key (BUDGETTYPE_BGT_BUDGETTYPE_ID) 
        references BGT_BUDGETTYPE;

    alter table BGT_OBJBUDGETPROPOSAL 
        add constraint FK25D5123E304AFCAC 
        foreign key (OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table BGT_OBJECTIVE_BUDGETTYPE 
        add constraint FKC2A5C0755898EDD9 
        foreign key (PLN_OBJECTIVE_id) 
        references PLN_OBJECTIVE;

    alter table BGT_OBJECTIVE_BUDGETTYPE 
        add constraint FKC2A5C0751736E6B6 
        foreign key (budgetTypes_id) 
        references BGT_BUDGETTYPE;

    alter table BGT_PROPOSALSTRATEGY 
        add constraint FKFD46D1F5CBE0BFCC 
        foreign key (PLN_UNIT_ID) 
        references PLN_TARGETUNIT;

    alter table BGT_PROPOSALSTRATEGY 
        add constraint FKFD46D1F546681FAB 
        foreign key (BUDGETPROPOSAL_ID) 
        references BGT_BUDGETPROPOSAL;

    alter table BGT_PROPOSALSTRATEGY 
        add constraint FKFD46D1F5BD677829 
        foreign key (FORMULASTRATEGY_ID) 
        references BGT_FORMULASTRATEGY;

    alter table BGT_REQUESTCOLUMN 
        add constraint FKD0F5EAF51538AD3B 
        foreign key (BGT_PROPOSALSTRATEGY_ID) 
        references BGT_PROPOSALSTRATEGY;

    alter table BGT_REQUESTCOLUMN 
        add constraint FKD0F5EAF54861E7C2 
        foreign key (COLUMN_BGT_FORMULACOLUMN_ID) 
        references BGT_FORMULACOLUMN;

    alter table BGT_RESERVEDBUDGET 
        add constraint FK3C6439FDECC9FC9B 
        foreign key (BUDGETTYPE_BGT_ID) 
        references BGT_BUDGETTYPE;

    alter table BGT_RESERVEDBUDGET 
        add constraint FK3C6439FD6410101F 
        foreign key (OBJECTIVE_PLN_OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table HRX_ORGANIZATION 
        add constraint FK308EFD444335D826 
        foreign key (PARENT_HRX_ORGANIZATION_ID) 
        references HRX_ORGANIZATION;

    alter table HRX_PERSON 
        add constraint FK15E15826732A7180 
        foreign key (WORKAT_HRX_ORGANIZATION_ID) 
        references HRX_ORGANIZATION;

    alter table PLN_JOIN_OBJECTIVENAME_TARGET 
        add constraint FKBBB55AD470F62A99 
        foreign key (PLN_OBJECTIVENAME_id) 
        references PLN_OBJECTIVENAME;

    alter table PLN_JOIN_OBJECTIVENAME_TARGET 
        add constraint FKBBB55AD4586CCDB4 
        foreign key (targets_id) 
        references PLN_OBJECTIVETARGET;

    alter table PLN_JOIN_OBJECTIVE_TARGET 
        add constraint FK23318F3F109D69C2 
        foreign key (forObjectives_id) 
        references PLN_OBJECTIVE;

    alter table PLN_JOIN_OBJECTIVE_TARGET 
        add constraint FK23318F3F586CCDB4 
        foreign key (targets_id) 
        references PLN_OBJECTIVETARGET;

    alter table PLN_JOIN_OBJECTIVE_UNIT 
        add constraint FK1C028EB25898EDD9 
        foreign key (PLN_OBJECTIVE_id) 
        references PLN_OBJECTIVE;

    alter table PLN_JOIN_OBJECTIVE_UNIT 
        add constraint FK1C028EB2568FAF4E 
        foreign key (units_id) 
        references PLN_TARGETUNIT;

    alter table PLN_OBJECTIVE 
        add constraint FK23ED5AECF556C1E 
        foreign key (TYPE_PLN_OBJECTIVETYPE_ID) 
        references PLN_OBJECTIVETYPE;

    alter table PLN_OBJECTIVE 
        add constraint FK23ED5AEC264870CE 
        foreign key (PARENT_PLN_OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table PLN_OBJECTIVE 
        add constraint FK23ED5AEC10F25FCD 
        foreign key (NAME_PLN_OBJECTIVENAME_ID) 
        references PLN_OBJECTIVENAME;

    alter table PLN_OBJECTIVENAME 
        add constraint FK66D27777F556C1E 
        foreign key (TYPE_PLN_OBJECTIVETYPE_ID) 
        references PLN_OBJECTIVETYPE;

    alter table PLN_OBJECTIVERELATIONS 
        add constraint FKA1CF846B24C52881 
        foreign key (PARENT_OBJECTIVETYPE_ID) 
        references PLN_OBJECTIVETYPE;

    alter table PLN_OBJECTIVERELATIONS 
        add constraint FKA1CF846B7B44221 
        foreign key (PARENT_OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table PLN_OBJECTIVERELATIONS 
        add constraint FKA1CF846B304AFCAC 
        foreign key (OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table PLN_OBJECTIVERELATIONS 
        add constraint FKA1CF846BF8386E4F 
        foreign key (CHILD_OBJECTIVETYPE_ID) 
        references PLN_OBJECTIVETYPE;

    alter table PLN_OBJECTIVETARGET 
        add constraint FK651DF7D7CFA5268 
        foreign key (TARGETUNIT_ID) 
        references PLN_TARGETUNIT;

    alter table PLN_OBJECTIVETYPE 
        add constraint FK66D58C266B1838AE 
        foreign key (PARENT_PLN_OBJECTIVETYPE_ID) 
        references PLN_OBJECTIVETYPE;

    alter table PLN_TARGETVALUE 
        add constraint FKAE906F739764B5AC 
        foreign key (OBJECTIVETARGET_ID) 
        references PLN_OBJECTIVETARGET;

    alter table PLN_TARGETVALUE 
        add constraint FKAE906F73FBBD47BD 
        foreign key (OWNER_ORAGANIZATION_ID) 
        references HRX_ORGANIZATION;

    alter table PLN_TARGETVALUE 
        add constraint FKAE906F73233AA3F5 
        foreign key (FOROBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table PLN_TARGETVALUEALLOCRECORD 
        add constraint FKE1B922539764B5AC 
        foreign key (OBJECTIVETARGET_ID) 
        references PLN_OBJECTIVETARGET;

    alter table PLN_TARGETVALUEALLOCRECORD 
        add constraint FKE1B922536410101F 
        foreign key (OBJECTIVE_PLN_OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table SEC_USER 
        add constraint FK67C6D319B3B60151 
        foreign key (PERSON_HRX_PERSON_ID) 
        references HRX_PERSON;

    create sequence BGT_ALLOCATIONRECORD_SEQ;

    create sequence BGT_BUDGETCOMMONTYPE_SEQ;

    create sequence BGT_BUDGETLEVEL_SEQ;

    create sequence BGT_BUDGETPROPOSAL_SEQ;

    create sequence BGT_BUDGETSIGNOFFLOG_SEQ;

    create sequence BGT_BUDGETSIGNOFF_SEQ;

    create sequence BGT_BUDGETTYPE_SEQ;

    create sequence BGT_FISCALBUDGETYPE_SEQ;

    create sequence BGT_FORMULACOLUMN_SEQ;

    create sequence BGT_FORMULASTRATEGY_SEQ;

    create sequence BGT_OBJBUDGETPROPOSAL_SEQ;

    create sequence BGT_PROPOSALSTRATEGY_SEQ;

    create sequence BGT_REQUESTCOLUMN_SEQ;

    create sequence BGT_RESERVEDBUDGET_SEQ;

    create sequence HRX_ORGANIZATION_SEQ;

    create sequence HRX_PERSON_SEQ;

    create sequence PLN_OBJECTIVENAME_SEQ;

    create sequence PLN_OBJECTIVERELATIONS_SEQ;

    create sequence PLN_OBJECTIVETARGET_SEQ;

    create sequence PLN_OBJECTIVETYPE_SEQ;

    create sequence PLN_OBJECTIVE_SEQ;

    create sequence PLN_TARGETUNIT_SEQ;

    create sequence PLN_TARGETVALUEALLOCRECORD_SEQ;

    create sequence PLN_TARGETVALUE_SEQ;

    create sequence SEC_USER_SEQ;

    
-- version 2 
-- Modified Date: JAN 20, 2012
    update app_info set db_version=2;
    
	create table BGT_OBJBGTPROPOSALTARGET (
        id number(19,0) not null,
        targetValue number(19,0),
        BGT_OBJBGTPROPOSAL_ID number(19,0),
        PLN_TARGETUNIT_ID number(19,0),
        primary key (id)
    );
    
    alter table BGT_OBJBGTPROPOSALTARGET 
        add constraint FK86174B0B2675B7F 
        foreign key (BGT_OBJBGTPROPOSAL_ID) 
        references BGT_OBJBUDGETPROPOSAL;
    
    alter table BGT_OBJBGTPROPOSALTARGET 
        add constraint FK86174B0B5E6A86DB 
        foreign key (PLN_TARGETUNIT_ID) 
        references PLN_TARGETUNIT;

    create sequence BGT_OBJBGTPROPOSALTARGET_SEQ;
    
-- version 3
-- Modified Date: Jan 21, 2013
    update app_info set db_version=3;
    alter table BGT_BUDGETSIGNOFF add (
        lock1TimeStamp timestamp,
        lock2TimeStamp timestamp,
	    unlock1TimeStamp timestamp,
        unLock2TimeStamp timestamp,
        HRX_LOCK1PERSON_ID number(19,0),
        HRX_LOCK2PERSON_ID number(19,0),
        HRX_UNLOCK1PERSON_ID number(19,0),
        HRX_UNLOCK2PERSON_ID number(19,0)
    );
    
    alter table BGT_BUDGETSIGNOFF 
        add constraint FKB506AFFDEE824A36 
        foreign key (HRX_LOCK2PERSON_ID) 
        references HRX_PERSON;

    alter table BGT_BUDGETSIGNOFF 
        add constraint FKB506AFFDFA38D917 
        foreign key (HRX_LOCK1PERSON_ID) 
        references HRX_PERSON;

    alter table BGT_BUDGETSIGNOFF 
        add constraint FKB506AFFD89C930CF 
        foreign key (HRX_UNLOCK2PERSON_ID) 
        references HRX_PERSON;

    alter table BGT_BUDGETSIGNOFF 
        add constraint FKB506AFFD957FBFB0 
        foreign key (HRX_UNLOCK1PERSON_ID) 
        references HRX_PERSON;

    
-- version 4
-- Modified Date: Jan 29, 2013
    update app_info set db_version=4;    
    
    create table PLN_OBJECTIVEDETAIL (
        id number(19,0) not null,
        location varchar2(200 char),
        email varchar2(100 char),
        methodology1 varchar2(1000 char),
        methodology2 varchar2(1000 char),
        methodology3 varchar2(1000 char),
        officerInCharge varchar2(100 char),
        outcome varchar2(1000 char),
        output varchar2(1000 char),
        projectObjective varchar2(1000 char),
        phoneNumber varchar2(30 char),
        reason varchar2(1000 char),
        targetArea varchar2(1000 char),
        targetDescription varchar2(1000 char),
        timeframe varchar2(200 char),
        PLN_OBJECTIVE_ID number(19,0),
        HRX_ORGANIZATION_ID number(19,0),
        primary key (id)
    );
    
   	alter table PLN_OBJECTIVEDETAIL 
        add constraint FKEB3D863D67BD3B3B 
        foreign key (HRX_ORGANIZATION_ID) 
        references HRX_ORGANIZATION;

    alter table PLN_OBJECTIVEDETAIL 
        add constraint FKEB3D863D5898EDD9 
        foreign key (PLN_OBJECTIVE_ID) 
        references PLN_OBJECTIVE;
        
   	create sequence PLN_OBJECTIVEDETAIL_SEQ;
   	
-- version 5
-- Modified Date: Feb 19, 2013
    update app_info set db_version=5;    
    
   	alter table hrx_organization add (code varchar2(20));
   	
   	create table PLN_OBJECTIVEOWNERRELATION (
        id number(19,0) not null,
        OBJ_PLN_OBJECTIVE_ID number(19,0) not null,
        primary key (id)
    );
    
	alter table PLN_OBJECTIVEOWNERRELATION 
        add constraint FK8F586623D66F5021 
        foreign key (OBJ_PLN_OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

	create sequence PLN_OBJOWNERRELATION_SEQ;

        
	create table PLN_OBJECTIVE_OWNER_JOIN (
        PLN_OBJECTIVEOWNERRELATION_id number(19,0) not null,
        owners_id number(19,0) not null
    );
    
    alter table PLN_OBJECTIVE_OWNER_JOIN 
        add constraint FK229966897ED7F2BF 
        foreign key (owners_id) 
        references HRX_ORGANIZATION;

    alter table PLN_OBJECTIVE_OWNER_JOIN 
        add constraint FK229966893FFF619B 
        foreign key (PLN_OBJECTIVEOWNERRELATION_id) 
        references PLN_OBJECTIVEOWNERRELATION;
 
    create table PLN_ACTIVITY (
        id number(19,0) not null,
        idx number(10,0),
        name varchar2(255 char),
        remark varchar2(255 char),
        targetValue number(19,0),
        OBJ_PLN_OBJECTIVE_ID number(19,0) not null,
        OWNER_HRX_ORGANIZATION number(19,0) not null,
        UNIT_PLN_TARGETUNIT_ID number(19,0),
        primary key (id)
    );
    
    alter table PLN_ACTIVITY 
        add constraint FKDB204ADC7B0190A7 
        foreign key (OBJ_PLN_OBJECTIVE_ID) 
        references PLN_OBJECTIVE;

    alter table PLN_ACTIVITY 
        add constraint FKDB204ADC2067F255 
        foreign key (OWNER_HRX_ORGANIZATION) 
        references HRX_ORGANIZATION;

    alter table PLN_ACTIVITY 
        add constraint FKDB204ADC67FA70E0 
        foreign key (UNIT_PLN_TARGETUNIT_ID) 
        references PLN_TARGETUNIT;

    create sequence PLN_ACTIVITY_SEQ;

    
    
-- version 6
-- Modified Date: Feb 25, 2013
    update app_info set db_version=6;
    
    alter table PLN_ACTIVITY add (PARENT_PLN_ACTIVITY_ID number(19,0));
    
	create table PLN_ACTIVITYPERFORMANCE (
        id number(19,0) not null,
        budgetAllocated double precision,
        ACTIVITY_PLN_ACTIVITY_ID number(19,0),
        OWNER_HRX_ORGANIZATION_ID number(19,0),
        primary key (id)
    );
    
    
    alter table PLN_ACTIVITYPERFORMANCE 
        add constraint FKF6E37B4C9F5A78B 
        foreign key (ACTIVITY_PLN_ACTIVITY_ID) 
        references PLN_ACTIVITY;
        
    alter table PLN_ACTIVITYPERFORMANCE 
        add constraint FKF6E37B462A663AF 
        foreign key (OWNER_HRX_ORGANIZATION_ID) 
        references HRX_ORGANIZATION;
        
    create sequence PLN_ACTIVITYPERFORMANCE_SEQ;
    
    create table PLN_ACTIVITYTARGET (
        id number(19,0) not null,
        targetValue number(19,0),
        ACTIVITY_PLN_ACTIVITY_ID number(19,0) not null,
        UNIT_PLN_TARGETUNIT_ID number(19,0) not null,
        primary key (id)
    );
    
    
    alter table PLN_ACTIVITYTARGET 
        add constraint FK992D1B6DC9F5A78B 
        foreign key (ACTIVITY_PLN_ACTIVITY_ID) 
        references PLN_ACTIVITY;

    alter table PLN_ACTIVITYTARGET 
        add constraint FK992D1B6D67FA70E0 
        foreign key (UNIT_PLN_TARGETUNIT_ID) 
        references PLN_TARGETUNIT;
        
    create sequence PLN_ACTIVITYTARGET_SEQ;
    

    create table PLN_ACTIVITYTARGETREPORT (
        id number(19,0) not null,
        targetValue number(19,0),
        PERFORMANCE_PLN_ACTPER_ID number(19,0),
        TARGET_PLN_ACTTARGET_ID number(19,0),
        primary key (id)
    );
    
    alter table PLN_ACTIVITYTARGETREPORT 
        add constraint FKA1935EE1CE2DDF80 
        foreign key (TARGET_PLN_ACTTARGET_ID) 
        references PLN_ACTIVITYTARGET;

    alter table PLN_ACTIVITYTARGETREPORT 
        add constraint FKA1935EE135264F66 
        foreign key (PERFORMANCE_PLN_ACTPER_ID) 
        references PLN_ACTIVITYPERFORMANCE;
        
    create sequence PLN_ACTIVITYTARGETREPORT_SEQ;
        
    create table PLN_MONTHLYBGTREPORT (
        id number(19,0) not null,
        budgetPlan number(19,0),
        budgetResult number(19,0),
        fiscalMonth number(10,0),
        remark varchar2(1024 char),
        PERFORMANCE_PLN_ACTPER_ID number(19,0),
        OWNER_HRX_ORGANIZATION_ID number(19,0),
        primary key (id)
    );
    
	alter table PLN_MONTHLYBGTREPORT 
        add constraint FK2CB2142335264F66 
        foreign key (PERFORMANCE_PLN_ACTPER_ID) 
        references PLN_ACTIVITYPERFORMANCE;

    alter table PLN_MONTHLYBGTREPORT 
        add constraint FK2CB2142362A663AF 
        foreign key (OWNER_HRX_ORGANIZATION_ID) 
        references HRX_ORGANIZATION;

    create sequence PLN_MONTHLYBGTREPORT_SEQ;

        
    create table PLN_MONTHLYACTREPORT (
        id number(19,0) not null,
        activityPlan number(19,0),
        activityResult number(19,0),
        fiscalMonth number(10,0),
        remark varchar2(1024 char),
        OWNER_HRX_ORGANIZATION_ID number(19,0),
        REPORT_PLN_ACTTARGETREPORT_ID number(19,0),
        primary key (id)
    );    
    
    alter table PLN_MONTHLYACTREPORT 
        add constraint FKF8E8F1A6AE5B179D 
        foreign key (REPORT_PLN_ACTTARGETREPORT_ID) 
        references PLN_ACTIVITYTARGETREPORT;

    alter table PLN_MONTHLYACTREPORT 
        add constraint FKF8E8F1A662A663AF 
        foreign key (OWNER_HRX_ORGANIZATION_ID) 
        references HRX_ORGANIZATION;
    
    create sequence PLN_MONTHLYACTREPORT_SEQ;
        
-- version 7
-- Modified Date: March 5, 2013
    update app_info set db_version=7;
    
    alter table PLN_ACTIVITYTARGETREPORT 
    	add (OWNER_HRX_ORGANIZATION_ID number(19,0));
    	
    alter table PLN_ACTIVITYTARGETREPORT 
        add constraint FK2CB2142F6246358A 
        foreign key (OWNER_HRX_ORGANIZATION_ID) 
        references HRX_ORGANIZATION;
        
-- version 8
-- Modeified Date: March 10, 2013
	update app_info set db_version=8;

    create table PLN_ACTIVITYTARGETRESULT (
        id number(19,0) not null,
        remark varchar2(1024 char),
        removed number(1,0),
        reportedResultDate date,
        result number(19,0),
        timestamp timestamp,
        REPORTPERSON_HRX_PERSON_ID number(19,0),
        TARGETREPORT_PLN_REPORT_ID number(19,0),
        primary key (id)
    );
    
    alter table PLN_ACTIVITYTARGETRESULT 
        add constraint FKA194D1CAB697B485 
        foreign key (REPORTPERSON_HRX_PERSON_ID) 
        references HRX_PERSON;

    alter table PLN_ACTIVITYTARGETRESULT 
        add constraint FKA194D1CA1D131B41 
        foreign key (TARGETREPORT_PLN_REPORT_ID) 
        references PLN_ACTIVITYTARGETREPORT;
        
  	create sequence PLN_ACTIVITYTARGETSRESULT_SEQ;

-- version 9
-- Modified Date: March 12, 2013
	update app_info set db_version=9;
	
	alter table bgt_proposalstrategy add (
		targetvaluenext1year number(19,0), 
		targetvaluenext2year number(19,0), 
		targetvaluenext3year number(19,0)
	);
	
	alter table BGT_OBJBGTPROPOSALTARGET add(
		targetvaluenext1year number(19,0), 
		targetvaluenext2year number(19,0), 
		targetvaluenext3year number(19,0)	
	);
	
	
-- version 10
-- Modifed Date: May 5, 2013
	update app_info set db_version = 10;
	
	 create table BGT_ALLOCSTDPRICE (
        id number(19,0) not null,
        idx number(10,0),
        standardPrice number(10,0),
        primary key (id)
    );
    
    create sequence BGT_ALLOCSTDPRICE_SEQ;
    
    create table BGT_ALLOCRECORDSTRATEGY (
        id number(19,0) not null,
        totalCalculatedAmount number(19,0),
        ALLOCATIONRECORD_ID number(19,0),
        strategy_id number(19,0),
        primary key (id)
    );
    
    create sequence BGT_ALLOCRECORDSTRATEGY_SEQ;

    
    
   	alter table BGT_ALLOCRECORDSTRATEGY 
        add constraint FKE59589F84B854F 
        foreign key (strategy_id) 
        references BGT_FORMULASTRATEGY;
        
    alter table BGT_ALLOCRECORDSTRATEGY 
        add constraint FKE595899FB0652B 
        foreign key (ALLOCATIONRECORD_ID) 
        references BGT_ALLOCATIONRECORD;

    
    
    create table BGT_ALLOCREC_PROPOSALSTRGY (
        BGT_ALLOCRECORDSTRATEGY_id number(19,0) not null,
        proposalStrategies_id number(19,0) not null,
        unique (proposalStrategies_id)
    );
    
    alter table BGT_ALLOCREC_PROPOSALSTRGY 
        add constraint FK95550C9DCCFE9B26 
        foreign key (BGT_ALLOCRECORDSTRATEGY_id) 
        references BGT_ALLOCRECORDSTRATEGY;

    alter table BGT_ALLOCREC_PROPOSALSTRGY 
        add constraint FK95550C9D2F60B08D 
        foreign key (proposalStrategies_id) 
        references BGT_PROPOSALSTRATEGY ;
    
   
    
    alter table BGT_REQUESTCOLUMN add(
		BGT_ALLOCRECORDSTRATEGY_ID number(19,0)
	);
	
	 alter table BGT_FORMULASTRATEGY add(
		ALLOCATIONSTANDARDPRICE number(19,0)
	);
	
	alter table BGT_REQUESTCOLUMN 
        add constraint FKD0F5EAF5CCFE9B26 
        foreign key (BGT_ALLOCRECORDSTRATEGY_ID) 
        references BGT_ALLOCRECORDSTRATEGY;
        
        
   	create table BGT_FMSTRGY_ALLOCSTDPRICE (
        BGT_FORMULASTRATEGY_id number(19,0) not null,
        allocationStandardPriceMap_id number(19,0) not null,
        primary key (BGT_FORMULASTRATEGY_id, allocationStandardPriceMap_id),
        unique (allocationStandardPriceMap_id)
    );
    
    alter table BGT_FMSTRGY_ALLOCSTDPRICE 
        add constraint FKBB76F2E82C387A2C 
        foreign key (allocationStandardPriceMap_id) 
        references BGT_ALLOCSTDPRICE;

    alter table BGT_FMSTRGY_ALLOCSTDPRICE 
        add constraint FKBB76F2E895B31999 
        foreign key (BGT_FORMULASTRATEGY_id) 
        references BGT_FORMULASTRATEGY;
    
    create table BGT_ALLOCFMCOLVALUE (
        id number(19,0) not null,
        allocatedValue number(19,0),
        idx number(10,0),
        primary key (id)
    );
    
    create sequence BGT_ALLOCFMCOLVALUE_SEQ;
    
    create table BGT_FMCOLUMN_ALLOCVALUE (
        BGT_FORMULACOLUMN_id number(19,0) not null,
        FMCOLUMNVALUE_ID number(19,0) not null,
        primary key (BGT_FORMULACOLUMN_id, FMCOLUMNVALUE_ID),
        unique (FMCOLUMNVALUE_ID)
    );
    
    alter table BGT_FMCOLUMN_ALLOCVALUE 
        add constraint FK4A4A6E6E4E5F0E79 
        foreign key (BGT_FORMULACOLUMN_id) 
        references BGT_FORMULACOLUMN;

    alter table BGT_FMCOLUMN_ALLOCVALUE 
        add constraint FK4A4A6E6E9F54CE91 
        foreign key (FMCOLUMNVALUE_ID) 
        references BGT_ALLOCFMCOLVALUE;

        
-- version 11
-- Modifed Date: June 21, 2013
	update app_info set db_version = 11;
	
	alter table BGT_FMSTRGY_ALLOCSTDPRICE add (IDX number(4));
	
	alter table BGT_FMCOLUMN_ALLOCVALUE add(IDX number(4));
	
	
-- version 12
-- Modifed Date: July 2, 2013
	
	update app_info set db_version = 12;
	
	alter table pln_objectivetype add (codelength number(2)); 
	
	
	
    