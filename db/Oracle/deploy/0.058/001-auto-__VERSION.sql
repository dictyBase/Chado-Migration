-- 
-- Created by SQL::Translator::Producer::Oracle
-- Created on Sat Oct 22 02:19:22 2011
-- 
--
-- Table: chadoprop
--;

CREATE SEQUENCE sq_chadoprop_chadoprop_id;

CREATE TABLE chadoprop (
  chadoprop_id number NOT NULL,
  type_id number NOT NULL,
  value clob,
  rank number DEFAULT '0' NOT NULL,
  PRIMARY KEY (chadoprop_id),
  CONSTRAINT chadoprop_c1 UNIQUE (type_id, rank)
);

CREATE OR REPLACE TRIGGER ai_chadoprop_chadoprop_id
BEFORE INSERT ON chadoprop
FOR EACH ROW WHEN (
 new.chadoprop_id IS NULL OR new.chadoprop_id = 0
)
BEGIN
 SELECT sq_chadoprop_chadoprop_id.nextval
 INTO :new.chadoprop_id
 FROM dual;
END;
/

