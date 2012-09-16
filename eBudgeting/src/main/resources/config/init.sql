    alter table ALLOCATIONRECORD 
        drop constraint FK991C7531545066B0

    alter table BUDGETPROPOSAL 
        drop constraint FK3504E937F3B5B111

    alter table BUDGETPROPOSAL 
        drop constraint FK3504E9373D9A687

    alter table BUDGETPROPOSAL 
        drop constraint FK3504E9378EFC2CB0

    alter table BUDGETTYPE 
        drop constraint FKF3D7FFFFDCB9CFE5

    alter table OBJECTIVE 
        drop constraint FK4D4EC919551295F0

    alter table OBJECTIVE 
        drop constraint FK4D4EC919D35E9E7

    alter table OBJECTIVETYPE 
        drop constraint FK84A1BD32AD68084

    alter table ORGANIZATION 
        drop constraint FKD063D5336B9D122E

    drop table ALLOCATIONRECORD if exists

    drop table BUDGETPROPOSAL if exists

    drop table BUDGETTYPE if exists

    drop table OBJECTIVE if exists

    drop table OBJECTIVETYPE if exists

    drop table ORGANIZATION if exists

    drop sequence ALLOCATIONRECORD_SEQ

    drop sequence BUDGETPROPOSAL_SEQ

    drop sequence BUDGETTYPE_SEQ

    drop sequence OBJECTIVETYPE_SEQ

    drop sequence OBJECTIVE_SEQ

    drop sequence ORGANIZATION_SEQ

    create table ALLOCATIONRECORD (
        id bigint not null,
        amountAllocated bigint,
        BUDGETPROPOSAL_ID bigint,
        primary key (id)
    )

    create table BUDGETPROPOSAL (
        id bigint not null,
        amountRequest bigint,
        name varchar(255),
        BUDGETTYPE_ID bigint,
        OBJECTIVE_ID bigint,
        ORGANIZATION_ID bigint,
        primary key (id)
    )

    create table BUDGETTYPE (
        id bigint not null,
        code varchar(255),
        fiscalYear integer,
        index integer,
        name varchar(255),
        BUDGETTYPE_PARENT_ID bigint,
        primary key (id)
    )

    create table OBJECTIVE (
        id bigint not null,
        code varchar(255),
        fiscalYear integer,
        index integer,
        name varchar(255),
        OBJECTIVE_PARENT_ID bigint,
        OBJECTIVETYPE_ID bigint not null,
        primary key (id)
    )

    create table OBJECTIVETYPE (
        id bigint not null,
        fiscalYear integer,
        name varchar(255),
        OBJECTIVETYPE_PARENT_ID bigint,
        primary key (id)
    )

    create table ORGANIZATION (
        id bigint not null,
        abbr varchar(255),
        index integer,
        name varchar(255),
        ORGANIZATION_PARENT_ID bigint,
        primary key (id)
    )

    alter table ALLOCATIONRECORD 
        add constraint FK991C7531545066B0 
        foreign key (BUDGETPROPOSAL_ID) 
        references BUDGETPROPOSAL

    alter table BUDGETPROPOSAL 
        add constraint FK3504E937F3B5B111 
        foreign key (ORGANIZATION_ID) 
        references ORGANIZATION

    alter table BUDGETPROPOSAL 
        add constraint FK3504E9373D9A687 
        foreign key (OBJECTIVE_ID) 
        references OBJECTIVE

    alter table BUDGETPROPOSAL 
        add constraint FK3504E9378EFC2CB0 
        foreign key (BUDGETTYPE_ID) 
        references BUDGETTYPE

    alter table BUDGETTYPE 
        add constraint FKF3D7FFFFDCB9CFE5 
        foreign key (BUDGETTYPE_PARENT_ID) 
        references BUDGETTYPE

    alter table OBJECTIVE 
        add constraint FK4D4EC919551295F0 
        foreign key (OBJECTIVE_PARENT_ID) 
        references OBJECTIVE

    alter table OBJECTIVE 
        add constraint FK4D4EC919D35E9E7 
        foreign key (OBJECTIVETYPE_ID) 
        references OBJECTIVETYPE

    alter table OBJECTIVETYPE 
        add constraint FK84A1BD32AD68084 
        foreign key (OBJECTIVETYPE_PARENT_ID) 
        references OBJECTIVETYPE

    alter table ORGANIZATION 
        add constraint FKD063D5336B9D122E 
        foreign key (ORGANIZATION_PARENT_ID) 
        references ORGANIZATION

    create sequence ALLOCATIONRECORD_SEQ

    create sequence BUDGETPROPOSAL_SEQ

    create sequence BUDGETTYPE_SEQ

    create sequence OBJECTIVETYPE_SEQ

    create sequence OBJECTIVE_SEQ

    create sequence ORGANIZATION_SEQ
