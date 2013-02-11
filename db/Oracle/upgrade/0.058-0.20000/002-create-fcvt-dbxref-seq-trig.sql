CREATE SEQUENCE sq_feature_cvterm_dbxref_featu;

CREATE OR REPLACE TRIGGER ai_feature_cvterm_dbxref_featu
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
