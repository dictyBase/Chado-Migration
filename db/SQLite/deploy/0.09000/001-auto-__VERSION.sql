-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Mon Oct 17 10:33:43 2011
-- 

;
BEGIN TRANSACTION;
--
-- Table: chadoprop
--
CREATE TABLE chadoprop (
  chadoprop_id INTEGER PRIMARY KEY NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX chadoprop_c1 ON chadoprop (type_id, rank);
COMMIT