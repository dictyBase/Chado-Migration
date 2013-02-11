CREATE SEQUENCE sq_feature_cvterm_pub_feature_;

CREATE OR REPLACE TRIGGER ai_feature_cvterm_pub_feature_
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
