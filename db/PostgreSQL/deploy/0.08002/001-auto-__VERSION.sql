-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Mon Oct 17 12:51:02 2011
-- 
;
--
-- Table: chadoprop
--
CREATE TABLE "chadoprop" (
  "chadoprop_id" serial NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("chadoprop_id"),
  CONSTRAINT "chadoprop_c1" UNIQUE ("type_id", "rank")
);

