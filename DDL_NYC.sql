/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      DATA MODEL
 *
 * Date Created : Monday, February 13, 2023 23:16:36
 * Target DBMS : Microsoft SQL Server 2019
 */

/* 
 * TABLE: dim_action 
 */

CREATE TABLE dim_action(
    ACTION_SK    int              IDENTITY(1,1),
    Action       nvarchar(200)    NULL,
    CONSTRAINT PK13 PRIMARY KEY NONCLUSTERED (ACTION_SK)
)

go


IF OBJECT_ID('dim_action') IS NOT NULL
    PRINT '<<< CREATED TABLE dim_action >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dim_action >>>'
go

/* 
 * TABLE: dim_board 
 */

CREATE TABLE dim_board(
    board_sk           int               IDENTITY(1,1),
    community_board    int               NULL,
    census_tract       int               NULL,
    BIN                numeric(10, 0)    NULL,
    BBL                numeric(10, 0)    NULL,
    NTA                nvarchar(10)      NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (board_sk)
)

go


IF OBJECT_ID('dim_board') IS NOT NULL
    PRINT '<<< CREATED TABLE dim_board >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dim_board >>>'
go

/* 
 * TABLE: dim_cuisine 
 */

CREATE TABLE dim_cuisine(
    cuisine_sk             int             IDENTITY(1,1),
    cuisine_description    nvarchar(50)    NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (cuisine_sk)
)

go


IF OBJECT_ID('dim_cuisine') IS NOT NULL
    PRINT '<<< CREATED TABLE dim_cuisine >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dim_cuisine >>>'
go

/* 
 * TABLE: dim_date 
 */

CREATE TABLE dim_date(
    DateSK              int            NOT NULL,
    FullDateAK          date           NOT NULL,
    DayNumberOfWeek     int            NOT NULL,
    DayNameOfWeek       varchar(10)    NOT NULL,
    DayNumberOfMonth    int            NOT NULL,
    MonthName           varchar(10)    NOT NULL,
    CalendarYear        smallint       NOT NULL,
    CONSTRAINT PRIMARY PRIMARY KEY NONCLUSTERED (DateSK)
)

go


IF OBJECT_ID('dim_date') IS NOT NULL
    PRINT '<<< CREATED TABLE dim_date >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dim_date >>>'
go

/* 
 * TABLE: dim_geography 
 */

CREATE TABLE dim_geography(
    AddressSK           int             IDENTITY(1,1),
    BORO                nvarchar(10)    NOT NULL,
    Building            char(10)        NULL,
    Street              char(10)        NULL,
    ZipCode             char(10)        NULL,
    [council district]  int             NULL,
    Latitude            char(10)        NULL,
    Longitude           char(10)        NULL,
    Location_point      bit             NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (AddressSK)
)

go


IF OBJECT_ID('dim_geography') IS NOT NULL
    PRINT '<<< CREATED TABLE dim_geography >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dim_geography >>>'
go

/* 
 * TABLE: dim_inspectionType 
 */

CREATE TABLE dim_inspectionType(
    InspectionType_sk    int              IDENTITY(1,1),
    Inspection_Type      nvarchar(100)    NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (InspectionType_sk)
)

go


IF OBJECT_ID('dim_inspectionType') IS NOT NULL
    PRINT '<<< CREATED TABLE dim_inspectionType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dim_inspectionType >>>'
go

/* 
 * TABLE: dim_restaurant 
 */

CREATE TABLE dim_restaurant(
    Restaurant_sk    int               IDENTITY(1,1),
    CAMIS            numeric(10, 0)    NULL,
    DBA              nvarchar(50)      NULL,
    cuisine_sk       int               NOT NULL,
    Phone            int               NULL,
    AddressGeoSK     int               NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (Restaurant_sk)
)

go


IF OBJECT_ID('dim_restaurant') IS NOT NULL
    PRINT '<<< CREATED TABLE dim_restaurant >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dim_restaurant >>>'
go

/* 
 * TABLE: dim_violation 
 */

CREATE TABLE dim_violation(
    violation_sk             int             IDENTITY(1,1),
    critical_flag            nvarchar(20)    NOT NULL,
    Violation_code           char(4)         NOT NULL,
    violation_description    text            NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY NONCLUSTERED (violation_sk)
)

go


IF OBJECT_ID('dim_violation') IS NOT NULL
    PRINT '<<< CREATED TABLE dim_violation >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dim_violation >>>'
go

/* 
 * TABLE: Fact_Inspection 
 */

CREATE TABLE Fact_Inspection(
    Inspection_SK        int         IDENTITY(1,1),
    GradeDate            datetime    NULL,
    RecordDate           datetime    NULL,
    InspectionDate       datetime    NULL,
    Grade                char(1)     NULL,
    Score                int         NULL,
    Restaurant_sk        int         NOT NULL,
    InspectionType_sk    int         NOT NULL,
    violation_sk         int         NOT NULL,
    InspectionDate_SK    int         NOT NULL,
    GradeDate_SK         int         NOT NULL,
    RecordDate_SK        int         NOT NULL,
    ACTION_SK            int         NOT NULL,
    board_sk             int         NOT NULL,
    CONSTRAINT PK11 PRIMARY KEY NONCLUSTERED (Inspection_SK)
)

go


IF OBJECT_ID('Fact_Inspection') IS NOT NULL
    PRINT '<<< CREATED TABLE Fact_Inspection >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fact_Inspection >>>'
go

/* 
 * TABLE: dim_restaurant 
 */

ALTER TABLE dim_restaurant ADD CONSTRAINT Refdim_geography7 
    FOREIGN KEY (AddressGeoSK)
    REFERENCES dim_geography(AddressSK)
go

ALTER TABLE dim_restaurant ADD CONSTRAINT Refdim_cuisine8 
    FOREIGN KEY (cuisine_sk)
    REFERENCES dim_cuisine(cuisine_sk)
go


/* 
 * TABLE: Fact_Inspection 
 */

ALTER TABLE Fact_Inspection ADD CONSTRAINT Refdim_violation1 
    FOREIGN KEY (violation_sk)
    REFERENCES dim_violation(violation_sk)
go

ALTER TABLE Fact_Inspection ADD CONSTRAINT Refdim_date2 
    FOREIGN KEY (InspectionDate_SK)
    REFERENCES dim_date(DateSK)
go

ALTER TABLE Fact_Inspection ADD CONSTRAINT Refdim_date3 
    FOREIGN KEY (GradeDate_SK)
    REFERENCES dim_date(DateSK)
go

ALTER TABLE Fact_Inspection ADD CONSTRAINT Refdim_date4 
    FOREIGN KEY (RecordDate_SK)
    REFERENCES dim_date(DateSK)
go

ALTER TABLE Fact_Inspection ADD CONSTRAINT Refdim_restaurant5 
    FOREIGN KEY (Restaurant_sk)
    REFERENCES dim_restaurant(Restaurant_sk)
go

ALTER TABLE Fact_Inspection ADD CONSTRAINT Refdim_action6 
    FOREIGN KEY (ACTION_SK)
    REFERENCES dim_action(ACTION_SK)
go

ALTER TABLE Fact_Inspection ADD CONSTRAINT Refdim_inspectionType9 
    FOREIGN KEY (InspectionType_sk)
    REFERENCES dim_inspectionType(InspectionType_sk)
go

ALTER TABLE Fact_Inspection ADD CONSTRAINT Refdim_board10 
    FOREIGN KEY (board_sk)
    REFERENCES dim_board(board_sk)
go


