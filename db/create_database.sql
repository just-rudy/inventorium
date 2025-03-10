
-- inventorium
--TODO autogen - needs profreadind

CREATE TABLE Bases
(
   id     serial NOT NULL,
  title   text   NOT NULL,
  addres  text   NOT NULL,
  manager text   NOT NULL,
  contact text   NOT NULL,
  tg      text   NOT NULL,
  email   text  ,
  PRIMARY KEY ( id)
);

COMMENT ON TABLE Bases IS 'storage places';

COMMENT ON COLUMN Bases.manager IS 'managers name';

COMMENT ON COLUMN Bases.contact IS 'phone number';

COMMENT ON COLUMN Bases.tg IS 'telegram username';

COMMENT ON COLUMN Bases.email IS 'e-mail';

CREATE TABLE Booking
(
  id             serial  NOT NULL,
  eq_id          varchar NOT NULL,
  base_id       serial  NOT NULL,
  tech_id        serial  NOT NULL,
  requester_name text    NOT NULL,
  contact        text    NOT NULL,
  tg             text    NOT NULL,
  email          text   ,
  date_start     date    NOT NULL,
  date_end       date    NOT NULL DEFAULT date_start,
  PRIMARY KEY (id)
);

COMMENT ON TABLE Booking IS 'tools that are requested for a date';

COMMENT ON COLUMN Booking.eq_id IS 'letter + number';

COMMENT ON COLUMN Booking.contact IS 'phone number';

COMMENT ON COLUMN Booking.tg IS '@ne_pridumal_nic';

CREATE TABLE Equipment
(
  id      varchar NOT NULL,
  eq_type text    NOT NULL,
  eq_set  text    NOT NULL DEFAULT ONLY,
  base_id serial  NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON TABLE Equipment IS 'all of tools to store';

COMMENT ON COLUMN Equipment.id IS 'letter + number';

COMMENT ON COLUMN Equipment.eq_set IS 'ONLY - just eq_type';

CREATE TABLE Events
(
  id           serial NOT NULL,
  title        text   NOT NULL,
  date_start   date   NOT NULL,
  date_end     date   NOT NULL,
  lead_name    text   NOT NULL,
  lead_contact text   NOT NULL,
  lead_tg      text   NOT NULL,
  tech_id      serial NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN Events.lead_name IS 'lead organisator';

COMMENT ON COLUMN Events.lead_contact IS 'phone_number';

COMMENT ON COLUMN Events.tech_id IS 'accountable tech person';

CREATE TABLE Organisations
(
  id             serial NOT NULL,
  title          text   NOT NULL,
  leader_name    text   NOT NULL,
  leader_contact text   NOT NULL,
  leader_tg      text   NOT NULL,
  tech_lead      serial NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON TABLE Organisations IS 'Stud clubs and faculties';

COMMENT ON COLUMN Organisations.leader_tg IS '@ne_pridumal_nic';

CREATE TABLE Statuses
(
  id     serial  NOT NULL,
  eq_id  varchar NOT NULL,
  status integer NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

COMMENT ON TABLE Statuses IS 'what the status of each tool';

COMMENT ON COLUMN Statuses.eq_id IS 'letter + number';

COMMENT ON COLUMN Statuses.status IS '0 1 2';

CREATE TABLE Transfer
(
  id           serial  NOT NULL,
  eq_id        varchar NOT NULL,
   base_to     serial  NOT NULL,
  accountable  serial  NOT NULL,
  requester    text    NOT NULL,
  date_when    date    NOT NULL,
  if_completed bool    NOT NULL DEFAULT False,
  PRIMARY KEY (id)
);

COMMENT ON TABLE Transfer IS 'all requests for moving inventory base to base';

COMMENT ON COLUMN Transfer.eq_id IS 'letter + number';

COMMENT ON COLUMN Transfer.requester IS 'the one requesting';

COMMENT ON COLUMN Transfer.date_when IS 'when inventory piece is needed';

COMMENT ON COLUMN Transfer.if_completed IS 'if request is satisfied';

CREATE TABLE Users
(
  id       serial NOT NULL,
  contact  text   NOT NULL,
  tg       text   NOT NULL,
  email    text  ,
  position text   NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON TABLE Users IS 'responsible tech ppl';

COMMENT ON COLUMN Users.contact IS 'phone number';

COMMENT ON COLUMN Users.tg IS 'telegram';

COMMENT ON COLUMN Users.position IS 'tech/org.tech и тд';

ALTER TABLE Statuses
  ADD CONSTRAINT FK_Equipment_TO_Statuses
    FOREIGN KEY (eq_id)
    REFERENCES Equipment (id);

ALTER TABLE Equipment
  ADD CONSTRAINT FK_Bases_TO_Equipment
    FOREIGN KEY (base_id)
    REFERENCES Bases ( id);

ALTER TABLE Booking
  ADD CONSTRAINT FK_Bases_TO_Booking
    FOREIGN KEY ( base_id)
    REFERENCES Bases ( id);

ALTER TABLE Booking
  ADD CONSTRAINT FK_Equipment_TO_Booking
    FOREIGN KEY (eq_id)
    REFERENCES Equipment (id);

ALTER TABLE Booking
  ADD CONSTRAINT FK_Users_TO_Booking
    FOREIGN KEY (tech_id)
    REFERENCES Users (id);

ALTER TABLE Transfer
  ADD CONSTRAINT FK_Users_TO_Transfer
    FOREIGN KEY (accountable)
    REFERENCES Users (id);

ALTER TABLE Transfer
  ADD CONSTRAINT FK_Bases_TO_Transfer
    FOREIGN KEY ( base_to)
    REFERENCES Bases ( id);

ALTER TABLE Transfer
  ADD CONSTRAINT FK_Equipment_TO_Transfer
    FOREIGN KEY (eq_id)
    REFERENCES Equipment (id);

ALTER TABLE Events
  ADD CONSTRAINT FK_Users_TO_Events
    FOREIGN KEY (tech_id)
    REFERENCES Users (id);

ALTER TABLE Booking
  ADD CONSTRAINT FK_Events_TO_Booking
    FOREIGN KEY (id)
    REFERENCES Events (id);

ALTER TABLE Organisations
  ADD CONSTRAINT FK_Users_TO_Organisations
    FOREIGN KEY (tech_lead)
    REFERENCES Users (id);