-- Equipment
ALTER TABLE Equipment ADD CONSTRAINT fk_eq_base FOREIGN KEY (base_id) REFERENCES Bases(id);

-- Base
ALTER TABLE Bases ADD UNIQUE (title, addres);

-- Events
ALTER TABLE "Events" ADD CONSTRAINT fk_ev_us FOREIGN KEY (tech_id) REFERENCES Users(id);

-- Users
ALTER TABLE Users ADD UNIQUE (contact);
ALTER TABLE Users ADD UNIQUE (tg);
ALTER TABLE Users ADD CONSTRAINT chk_position CHECK (position IN ('TechJunior', 'TechSenior', 'ClubTech', 'NotTech'));


-- Organisations
ALTER TABLE Organisations ADD CONSTRAINT fk_org_us FOREIGN KEY (tech_lead) REFERENCES Users(id);
ALTER TABLE Organisations ADD UNIQUE (title);

-- Booking
ALTER TABLE Booking ADD CONSTRAINT fk_book_eq FOREIGN KEY (eq_id) REFERENCES Equipment(id);
ALTER TABLE Booking ADD CONSTRAINT fk_book_base FOREIGN KEY (base_id) REFERENCES Bases(id);
ALTER TABLE Booking ADD CONSTRAINT fk_book_us FOREIGN KEY (tech_id) REFERENCES Users(id);
ALTER TABLE Booking ADD CONSTRAINT fk_book_ev FOREIGN KEY (mero_id) REFERENCES "Events"(id);

-- Transfer
ALTER TABLE Transfers ADD CONSTRAINT fk_ts_eq FOREIGN KEY (eq_id) REFERENCES Equipment(id);
ALTER TABLE Transfers ADD CONSTRAINT fk_ts_base FOREIGN KEY (base_to) REFERENCES Bases(id);
ALTER TABLE Transfers ADD CONSTRAINT fk_ts_us FOREIGN KEY (accountable_id) REFERENCES Users(id);

-- Statuses
ALTER TABLE Statuses ADD CONSTRAINT fk_st_eq FOREIGN KEY (eq_id) REFERENCES Equipment(id);
