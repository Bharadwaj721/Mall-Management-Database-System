-- ===================================
-- Schema for Mall Management System
-- ===================================

-- Table: MALL
-- Stores information about each mall
CREATE TABLE MALL (
    CODE VARCHAR(7) PRIMARY KEY,         -- Unique code for each mall
    NAME VARCHAR(20) NOT NULL,           -- Mall name
    LOCATION VARCHAR(40) NOT NULL,       -- Mall location
    AREA NUMBER(8) NOT NULL,             -- Total area of the mall
    OWNER VARCHAR(20) NOT NULL           -- Owner of the mall
);

-- Table: MALL_MANAGERS
-- Contains details of mall managers
CREATE TABLE MALL_MANAGERS (
    MANAGER_ID VARCHAR(5) PRIMARY KEY,       -- Unique manager ID
    NAME VARCHAR(20) NOT NULL,               -- Manager's name
    SALARY NUMBER(8) NOT NULL,               -- Salary
    START_DATE DATE,                         -- Date of joining
    PHONE_NUMBER VARCHAR(10) NOT NULL,       -- Contact number
    ADDRESS VARCHAR(30) NOT NULL,            -- Address
    MALL_CODE VARCHAR(8) NOT NULL,           -- Associated mall
    FOREIGN KEY(MALL_CODE) REFERENCES MALL(CODE) ON DELETE CASCADE
);

-- Table: TENANT_OFFICERS
-- Officers/tenants operating in the mall
CREATE TABLE TENANT_OFFICERS (
    ID VARCHAR(5) PRIMARY KEY,               -- Unique tenant ID
    NAME VARCHAR(20) NOT NULL,               -- Tenant name
    SALARY NUMBER(10) NOT NULL,              -- Salary
    PHONE_NUMBER VARCHAR(10) NOT NULL        -- Contact number
);

-- Table: MALL_T_OFFICERS
-- Mapping of tenant officers to malls
CREATE TABLE MALL_T_OFFICERS (
    MALL_CODE VARCHAR(8) NOT NULL,
    TENANT_ID VARCHAR(5) NOT NULL,
    FOREIGN KEY(MALL_CODE) REFERENCES MALL(CODE) ON DELETE CASCADE,
    FOREIGN KEY(TENANT_ID) REFERENCES TENANT_OFFICERS(ID) ON DELETE CASCADE
);

-- Table: TIMING
-- Stores operational timings of malls
CREATE TABLE TIMING (
    WEEKDAYS VARCHAR(7),                    -- Days of the week
    OPENING_TIME VARCHAR(8) NOT NULL,       -- Opening time
    CLOSING_TIME VARCHAR(8) NOT NULL,       -- Closing time
    MALL_CODE VARCHAR(8),                   -- Associated mall
    PRIMARY KEY(MALL_CODE, WEEKDAYS),
    FOREIGN KEY(MALL_CODE) REFERENCES MALL(CODE) ON DELETE CASCADE
);

-- Table: STORE_CATEGORIES
-- Defines types of store categories
CREATE TABLE STORE_CATEGORIES (
    ID VARCHAR(5) PRIMARY KEY,             -- Category ID
    CATEGORIES VARCHAR(20)                 -- Name of category
);

-- Table: STORES
-- Stores information about each store
CREATE TABLE STORES (
    STORE_ID VARCHAR(5) PRIMARY KEY,       -- Store ID
    STORE_NAME VARCHAR(20) NOT NULL,       -- Store name
    RENT NUMBER(8) NOT NULL,               -- Rent amount
    TENANT_ID VARCHAR(5) NOT NULL,         -- Linked tenant
    CATEGORY_ID VARCHAR(5) NOT NULL,       -- Store category
    MALL_CODE VARCHAR(8) NOT NULL,         -- Mall location
    FOREIGN KEY(TENANT_ID) REFERENCES TENANT_OFFICERS(ID) ON DELETE CASCADE,
    FOREIGN KEY(CATEGORY_ID) REFERENCES STORE_CATEGORIES(ID) ON DELETE CASCADE,
    FOREIGN KEY(MALL_CODE) REFERENCES MALL(CODE) ON DELETE CASCADE
);

-- Table: FOOD_TYPES
-- Types of food services
CREATE TABLE FOOD_TYPES (
    ID VARCHAR(5) PRIMARY KEY,
    TYPES VARCHAR(20) NOT NULL              -- e.g. Bakery, Cafe, etc.
);

-- Table: FOOD_CORNERS
-- Food outlets present in the mall
CREATE TABLE FOOD_CORNERS (
    CORNER_ID VARCHAR(5) PRIMARY KEY,      -- Food corner ID
    NAME VARCHAR(20) NOT NULL,             -- Name of food corner
    RENT NUMBER(10) NOT NULL,              -- Rent amount
    TENANT_ID VARCHAR(5) NOT NULL,         -- Associated tenant
    TYPE_ID VARCHAR(5) NOT NULL,           -- Food type
    MALL_CODE VARCHAR(8) NOT NULL,         -- Mall location
    FOREIGN KEY(TENANT_ID) REFERENCES TENANT_OFFICERS(ID) ON DELETE CASCADE,
    FOREIGN KEY(TYPE_ID) REFERENCES FOOD_TYPES(ID) ON DELETE CASCADE,
    FOREIGN KEY(MALL_CODE) REFERENCES MALL(CODE) ON DELETE CASCADE
);

-- Table: GAMES
-- Types of games available
CREATE TABLE GAMES (
    ID VARCHAR(5) PRIMARY KEY,              -- Game ID
    GAME_NAME VARCHAR(20) NOT NULL,         -- Name of the game
    NUM_OF_PLAYERS NUMBER(2) NOT NULL,      -- Player capacity
    PRICE NUMBER(5) NOT NULL                -- Price to play
);

-- Table: GAME_ZONE
-- Details of game zones inside the mall
CREATE TABLE GAME_ZONE (
    GAME_ID VARCHAR(5),
    RENT NUMBER(8) NOT NULL,
    TENANT_ID VARCHAR(5) NOT NULL,
    MALL_CODE VARCHAR(8),
    PRIMARY KEY(MALL_CODE, GAME_ID),
    FOREIGN KEY(GAME_ID) REFERENCES GAMES(ID) ON DELETE CASCADE,
    FOREIGN KEY(TENANT_ID) REFERENCES TENANT_OFFICERS(ID) ON DELETE CASCADE,
    FOREIGN KEY(MALL_CODE) REFERENCES MALL(CODE) ON DELETE CASCADE
);

-- Table: MOVIE_THEATRES
-- Movie theatre information
CREATE TABLE MOVIE_THEATRES (
    TH_NAME VARCHAR(10) NOT NULL,               -- Theatre name
    TOTAL_SCREENS NUMBER(2) NOT NULL,           -- Total screens
    NUM_OF_TICKET_COUNTERS NUMBER(2) NOT NULL,  -- Ticket counters
    RENT NUMBER(8) NOT NULL,                    -- Rent amount
    TENANT_ID VARCHAR(5) NOT NULL,              -- Tenant ID
    MALL_CODE VARCHAR(8) PRIMARY KEY,           -- Mall location (one theatre per mall)
    FOREIGN KEY(MALL_CODE) REFERENCES MALL(CODE) ON DELETE CASCADE,
    FOREIGN KEY(TENANT_ID) REFERENCES TENANT_OFFICERS(ID) ON DELETE CASCADE
);

-- Table: CONCESSION_STAND
-- Snack stalls inside movie theatres
CREATE TABLE CONCESSION_STAND (
    STAND_ID VARCHAR(5),
    TYPE_ID VARCHAR(5),
    MALL_CODE VARCHAR(8),
    PRIMARY KEY(STAND_ID, MALL_CODE),
    FOREIGN KEY(TYPE_ID) REFERENCES FOOD_TYPES(ID) ON DELETE CASCADE,
    FOREIGN KEY(MALL_CODE) REFERENCES MOVIE_THEATRES(MALL_CODE) ON DELETE CASCADE
);

-- Table: ATM
-- ATM outlets in the mall
CREATE TABLE ATM (
    BRANCH_NAME VARCHAR(10),
    RENT NUMBER(5) NOT NULL,
    TENANT_ID VARCHAR(5) NOT NULL,
    MALL_CODE VARCHAR(8),
    PRIMARY KEY(BRANCH_NAME, MALL_CODE),
    FOREIGN KEY(TENANT_ID) REFERENCES TENANT_OFFICERS(ID) ON DELETE CASCADE,
    FOREIGN KEY(MALL_CODE) REFERENCES MALL(CODE) ON DELETE CASCADE
);