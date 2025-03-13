-- Active: 1741899269505@@127.0.0.1@5432@postgres@public
CREATE TABLE
    IF NOT EXISTS Bases
(
    id      SERIAL PRIMARY KEY,
    title   TEXT        NOT NULL,
    addres  TEXT        NOT NULL,
    manager TEXT        NOT NULL,
    contact VARCHAR(12) NOT NULL, -- номер телефона
    tg      VARCHAR(64) NOT NULL,
    email   TEXT        NOT NULL
);

-- Весь доступный инструмент/материал типа шуруповертов и саморезов
CREATE TABLE
    IF NOT EXISTS Equipment
(
    id            VARCHAR(5) PRIMARY KEY, -- Ш1 - шуруповерт под номером 1
    eq_type       TEXT NOT NULL,
    eq_set        TEXT NOT NULL DEFAULT 'only',
    base_id       INT  NOT NULL,          -- FK base id
    if_consumable BOOL NOT NULL DEFAULT False
);

-- Статус каждого инструмента
CREATE TABLE
    IF NOT EXISTS Statuses
(
    id    SERIAL PRIMARY KEY,
    eq_id VARCHAR(5) NOT NULL, -- FK equipment id
    stat  INT DEFAULT 0        -- 0 - лежит на base_id, 1 - в пути, 2 - есть бронь, 3 - сломан/кончился/больше не существует
);

CREATE TABLE
    IF NOT EXISTS Users
(
    id       SERIAL PRIMARY KEY,
    name     TEXT        NOT NULL,
    contact  VARCHAR(12) NOT NULL, -- номер телефона
    tg       VARCHAR(64) NOT NULL,
    email    TEXT        NOT NULL,
    position TEXT        NOT NULL  -- check ('TechJun', 'TechSenior', 'ClubTech', 'NotTech')
);

CREATE TABLE
    IF NOT EXISTS "Events"
(
    id           SERIAL PRIMARY KEY,
    title        TEXT        NOT NULL,
    date_start   DATE        NOT NULL,
    date_end     DATE        NOT NULL, -- default date_start?
    lead_name    TEXT        NOT NULL,
    lead_contact VARCHAR(12) NOT NULL, -- номер телефона
    lead_tg      VARCHAR(64) NOT NULL,
    tech_id      INT         NOT NULL  -- FK users
);

CREATE TABLE
    IF NOT EXISTS Organisations
(
    id             SERIAL      NOT NULL PRIMARY KEY,
    title          TEXT        NOT NULL,
    leader_name    TEXT        NOT NULL,
    leader_contact VARCHAR(12) NOT NULL, -- номер телефона
    leader_tg      VARCHAR(64) NOT NULL,
    tech_lead      SERIAL      NOT NULL
);

CREATE TABLE
    IF NOT EXISTS Transfers
(
    id             SERIAL     NOT NULL PRIMARY KEY,
    eq_id          VARCHAR(5) NOT NULL, -- FK equipment
    base_to    INT        NOT NULL, -- FK base
    accountable_id INT,                 -- FK Users
    date_when      DATE       NOT NULL,
    requester      TEXT,
    if_completed   BOOLEAN    NOT NULL default false

);

CREATE TABLE
    IF NOT EXISTS Booking
(
    id         SERIAL      NOT NULL PRIMARY KEY,
    eq_id      VARCHAR(5)  NOT NULL, -- FK equipment
    base_id    INT         NOT NULL, -- FK base
    tech_id    INT,                  -- FK users
    name       TEXT        NOT NULL,
    contact    VARCHAR(12) NOT NULL, -- номер телефона
    tg         VARCHAR(64) NOT NULL,
    date_start DATE        NOT NULL,
    date_end   DATE        NOT NULL,
    mero_id    INT                  -- FK Events
);