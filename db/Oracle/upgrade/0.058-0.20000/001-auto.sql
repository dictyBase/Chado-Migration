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

