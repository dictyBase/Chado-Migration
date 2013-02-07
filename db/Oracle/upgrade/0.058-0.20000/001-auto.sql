CREATE SEQUENCE sq_cvprop_cvprop_id;

CREATE TABLE cvprop (
  cvprop_id number(11) NOT NULL,
  cv_id number(10) NOT NULL,
  type_id number(10) NOT NULL,
  value clob,
  rank number(10) DEFAULT '0' NOT NULL,
  PRIMARY KEY (cvprop_id),
  CONSTRAINT cvprop_c1 UNIQUE (cv_id, type_id, rank)
);

ALTER TABLE cvprop ADD CONSTRAINT cvprop_cv_id_fk FOREIGN KEY (cv_id) REFERENCES cv (cv_id);

ALTER TABLE cvprop ADD CONSTRAINT cvprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id);

CREATE OR REPLACE TRIGGER ai_cvprop_cvprop_id
BEFORE INSERT ON cvprop
FOR EACH ROW WHEN (
 new.cvprop_id IS NULL OR new.cvprop_id = 0
)
BEGIN
 SELECT sq_cvprop_cvprop_id.nextval
 INTO :new.cvprop_id
 FROM dual;
END;
/

CREATE SEQUENCE  "SQ_FEATURE_CVTERM_DBXREF_FEATU"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
 
CREATE OR REPLACE TRIGGER "AI_FEATURE_CVTERM_DBXREF_FEATU" 
BEFORE INSERT ON feature_cvterm_dbxref
FOR EACH ROW   WHEN (
	new.feature_cvterm_dbxref_id IS NULL OR new.feature_cvterm_dbxref_id = 0
) 
BEGIN
	SELECT sq_feature_cvterm_dbxref_featu.nextval
 	INTO :new.feature_cvterm_dbxref_id
 	FROM dual;
END;
/
ALTER TRIGGER "AI_FEATURE_CVTERM_DBXREF_FEATU" ENABLE;

CREATE SEQUENCE  "SQ_FEATURE_CVTERM_PUB_FEATURE_"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE OR REPLACE TRIGGER "AI_FEATURE_CVTERM_PUB_FEATURE_" 
BEFORE INSERT ON feature_cvterm_pub
FOR EACH ROW  WHEN (
	new.feature_cvterm_pub_id IS NULL OR new.feature_cvterm_pub_id = 0
) 
BEGIN
	SELECT sq_feature_cvterm_pub_feature_.nextval
 	INTO :new.feature_cvterm_pub_id
 	FROM dual;
END;
/
ALTER TRIGGER "AI_FEATURE_CVTERM_PUB_FEATURE_" ENABLE;

