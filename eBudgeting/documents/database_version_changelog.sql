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