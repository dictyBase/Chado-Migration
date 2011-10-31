-- 
-- Created by SQL::Translator::Producer::Oracle
-- Created on Fri Oct 21 16:05:02 2011
-- 
--
-- Table: acquisition
--;

CREATE SEQUENCE sq_acquisition_acquisition_id;

CREATE SEQUENCE sq_acquisition_acquisitiondate;

CREATE TABLE acquisition (
  acquisition_id number(11,0) NOT NULL,
  assay_id number(10,0) NOT NULL,
  protocol_id number(10,0) DEFAULT NULL,
  channel_id number(10,0) DEFAULT NULL,
  acquisitiondate date DEFAULT current_timestamp,
  name varchar2(4000) DEFAULT NULL,
  uri clob DEFAULT NULL,
  PRIMARY KEY (acquisition_id),
  CONSTRAINT u_acquisition_u_acquisition UNIQUE (name)
);

--
-- Table: acquisition_relationship
--;

CREATE SEQUENCE sq_acquisition_relationship_ac;

CREATE TABLE acquisition_relationship (
  acquisition_relationship_id number(11,0) NOT NULL,
  subject_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  object_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (acquisition_relationship_id),
  CONSTRAINT u_acquisition_relationship_u_a UNIQUE (subject_id, object_id, type_id, rank)
);

--
-- Table: acquisitionprop
--;

CREATE SEQUENCE sq_acquisitionprop_acquisition;

CREATE TABLE acquisitionprop (
  acquisitionprop_id number(11,0) NOT NULL,
  acquisition_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (acquisitionprop_id),
  CONSTRAINT u_acquisitionprop_u_acquisitio UNIQUE (acquisition_id, type_id, rank)
);

--
-- Table: analysis
--;

CREATE SEQUENCE sq_analysis_analysis_id;

CREATE SEQUENCE sq_analysis_timeexecuted;

CREATE TABLE analysis (
  analysis_id number(11,0) NOT NULL,
  name varchar2(255),
  description clob,
  program varchar2(255) NOT NULL,
  programversion varchar2(255) NOT NULL,
  algorithm varchar2(255),
  sourcename varchar2(255),
  sourceversion varchar2(255),
  sourceuri clob,
  timeexecuted date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY (analysis_id),
  CONSTRAINT u_analysis_u_analysis UNIQUE (program, programversion, sourcename)
);

--
-- Table: analysisfeature
--;

CREATE SEQUENCE sq_analysisfeature_analysisfea;

CREATE TABLE analysisfeature (
  analysisfeature_id number(11,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  analysis_id number(10,0) NOT NULL,
  rawscore number(38),
  normscore number(38),
  significance number(38),
  identity number(38),
  PRIMARY KEY (analysisfeature_id),
  CONSTRAINT u_analysisfeature_u_analysisfe UNIQUE (feature_id, analysis_id)
);

--
-- Table: analysisprop
--;

CREATE SEQUENCE sq_analysisprop_analysisprop_i;

CREATE TABLE analysisprop (
  analysisprop_id number(11,0) NOT NULL,
  analysis_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value varchar2(4000),
  PRIMARY KEY (analysisprop_id),
  CONSTRAINT u_analysisprop_u_analysisprop UNIQUE (analysis_id, type_id, value)
);

--
-- Table: arraydesign
--;

CREATE SEQUENCE sq_arraydesign_arraydesign_id;

CREATE TABLE arraydesign (
  arraydesign_id number(11,0) NOT NULL,
  manufacturer_id number(10,0) NOT NULL,
  platformtype_id number(10,0) NOT NULL,
  substratetype_id number(10,0) DEFAULT NULL,
  protocol_id number(10,0) DEFAULT NULL,
  dbxref_id number(10,0) DEFAULT NULL,
  name varchar2(4000) NOT NULL,
  version clob DEFAULT NULL,
  description clob DEFAULT NULL,
  array_dimensions clob DEFAULT NULL,
  element_dimensions clob DEFAULT NULL,
  num_of_elements number(10,0) DEFAULT NULL,
  num_array_columns number(10,0) DEFAULT NULL,
  num_array_rows number(10,0) DEFAULT NULL,
  num_grid_columns number(10,0) DEFAULT NULL,
  num_grid_rows number(10,0) DEFAULT NULL,
  num_sub_columns number(10,0) DEFAULT NULL,
  num_sub_rows number(10,0) DEFAULT NULL,
  PRIMARY KEY (arraydesign_id),
  CONSTRAINT u_arraydesign_u_arraydesign UNIQUE (name)
);

--
-- Table: arraydesignprop
--;

CREATE SEQUENCE sq_arraydesignprop_arraydesign;

CREATE TABLE arraydesignprop (
  arraydesignprop_id number(11,0) NOT NULL,
  arraydesign_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (arraydesignprop_id),
  CONSTRAINT u_arraydesignprop_u_arraydesig UNIQUE (arraydesign_id, type_id, rank)
);

--
-- Table: assay
--;

CREATE SEQUENCE sq_assay_assay_id;

CREATE SEQUENCE sq_assay_assaydate;

CREATE TABLE assay (
  assay_id number(11,0) NOT NULL,
  arraydesign_id number(10,0) NOT NULL,
  protocol_id number(10,0) DEFAULT NULL,
  assaydate date DEFAULT current_timestamp,
  arrayidentifier clob DEFAULT NULL,
  arraybatchidentifier clob DEFAULT NULL,
  operator_id number(10,0) NOT NULL,
  dbxref_id number(10,0) DEFAULT NULL,
  name varchar2(4000) DEFAULT NULL,
  description clob DEFAULT NULL,
  PRIMARY KEY (assay_id),
  CONSTRAINT u_assay_u_assay UNIQUE (name)
);

--
-- Table: assay_biomaterial
--;

CREATE SEQUENCE sq_assay_biomaterial_assay_bio;

CREATE TABLE assay_biomaterial (
  assay_biomaterial_id number(11,0) NOT NULL,
  assay_id number(10,0) NOT NULL,
  biomaterial_id number(10,0) NOT NULL,
  channel_id number(10,0) DEFAULT NULL,
  PRIMARY KEY (assay_biomaterial_id),
  CONSTRAINT u_assay_biomaterial_u_assay_bi UNIQUE (assay_id, biomaterial_id, channel_id)
);

--
-- Table: assay_project
--;

CREATE SEQUENCE sq_assay_project_assay_project;

CREATE TABLE assay_project (
  assay_project_id number(11,0) NOT NULL,
  assay_id number(10,0) NOT NULL,
  project_id number(10,0) NOT NULL,
  PRIMARY KEY (assay_project_id),
  CONSTRAINT u_assay_project_u_assay_projec UNIQUE (assay_id, project_id)
);

--
-- Table: assayprop
--;

CREATE SEQUENCE sq_assayprop_assayprop_id;

CREATE TABLE assayprop (
  assayprop_id number(11,0) NOT NULL,
  assay_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (assayprop_id),
  CONSTRAINT u_assayprop_u_assayprop UNIQUE (assay_id, type_id, rank)
);

--
-- Table: author
--;

CREATE SEQUENCE sq_author_author_id;

CREATE TABLE author (
  author_id number(11,0) NOT NULL,
  contact_id number(10,0) DEFAULT NULL,
  surname varchar2(100) NOT NULL,
  givennames varchar2(100),
  suffix varchar2(100),
  PRIMARY KEY (author_id),
  CONSTRAINT u_author_u_author UNIQUE (surname, givennames, suffix)
);

--
-- Table: biomaterial
--;

CREATE SEQUENCE sq_biomaterial_biomaterial_id;

CREATE TABLE biomaterial (
  biomaterial_id number(11,0) NOT NULL,
  taxon_id number(10,0) DEFAULT NULL,
  biosourceprovider_id number(10,0) DEFAULT NULL,
  dbxref_id number(10,0) DEFAULT NULL,
  name varchar2(4000) DEFAULT NULL,
  description clob DEFAULT NULL,
  PRIMARY KEY (biomaterial_id),
  CONSTRAINT u_biomaterial_u_biomaterial UNIQUE (name)
);

--
-- Table: biomaterial_relationship
--;

CREATE SEQUENCE sq_biomaterial_relationship_bi;

CREATE TABLE biomaterial_relationship (
  biomaterial_relationship_id number(11,0) NOT NULL,
  subject_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  object_id number(10,0) NOT NULL,
  PRIMARY KEY (biomaterial_relationship_id),
  CONSTRAINT u_biomaterial_relationship_u_b UNIQUE (subject_id, object_id, type_id)
);

--
-- Table: biomaterial_treatment
--;

CREATE SEQUENCE sq_biomaterial_treatment_bioma;

CREATE TABLE biomaterial_treatment (
  biomaterial_treatment_id number(11,0) NOT NULL,
  biomaterial_id number(10,0) NOT NULL,
  treatment_id number(10,0) NOT NULL,
  unittype_id number(10,0) DEFAULT NULL,
  value number(15,0) DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (biomaterial_treatment_id),
  CONSTRAINT u_biomaterial_treatment_u_biom UNIQUE (biomaterial_id, treatment_id)
);

--
-- Table: biomaterialprop
--;

CREATE SEQUENCE sq_biomaterialprop_biomaterial;

CREATE TABLE biomaterialprop (
  biomaterialprop_id number(11,0) NOT NULL,
  biomaterial_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) NOT NULL,
  PRIMARY KEY (biomaterialprop_id),
  CONSTRAINT u_biomaterialprop_u_biomateria UNIQUE (biomaterial_id, type_id, rank)
);

--
-- Table: channel
--;

CREATE SEQUENCE sq_channel_channel_id;

CREATE TABLE channel (
  channel_id number(11,0) NOT NULL,
  name varchar2(4000) NOT NULL,
  definition clob NOT NULL,
  PRIMARY KEY (channel_id),
  CONSTRAINT u_channel_u_channel UNIQUE (name)
);

--
-- Table: contact
--;

CREATE SEQUENCE sq_contact_contact_id;

CREATE TABLE contact (
  contact_id number(11,0) NOT NULL,
  name varchar2(30) NOT NULL,
  description varchar2(255) DEFAULT NULL,
  PRIMARY KEY (contact_id),
  CONSTRAINT u_contact_u_contact UNIQUE (name)
);

--
-- Table: control
--;

CREATE SEQUENCE sq_control_control_id;

CREATE TABLE control (
  control_id number(11,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  assay_id number(10,0) NOT NULL,
  tableinfo_id number(10,0) NOT NULL,
  row_id number(10,0) NOT NULL,
  name clob DEFAULT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (control_id)
);

--
-- Table: curator
--;

CREATE SEQUENCE sq_curator_curator_id;

CREATE TABLE curator (
  curator_id number(38) NOT NULL,
  name varchar2(255) NOT NULL,
  initials varchar2(255),
  password varchar2(32) NOT NULL,
  PRIMARY KEY (curator_id),
  CONSTRAINT u_curator_u_curator UNIQUE (name)
);

--
-- Table: curator_feature_genotype
--;

CREATE SEQUENCE sq_curator_feature_genotype_cu;

CREATE TABLE curator_feature_genotype (
  curator_feature_genotype_id number(38) NOT NULL,
  curator_id number(38) NOT NULL,
  feature_genotype_id number(38) NOT NULL,
  timecreated date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY (curator_feature_genotype_id),
  CONSTRAINT u_curator_feature_genotype_u_c UNIQUE (curator_id, feature_genotype_id)
);

--
-- Table: curator_feature_pubprop
--;

CREATE SEQUENCE sq_curator_feature_pubprop_cur;

CREATE TABLE curator_feature_pubprop (
  curator_feature_pubprop_id number(38) NOT NULL,
  curator_id number(38) NOT NULL,
  feature_pubprop_id number(38) NOT NULL,
  timecreated date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY (curator_feature_pubprop_id),
  CONSTRAINT u_curator_feature_pubprop_u_cu UNIQUE (curator_id, feature_pubprop_id)
);

--
-- Table: cv
--;

CREATE SEQUENCE sq_cv_cv_id;

CREATE TABLE cv (
  cv_id number(11,0) NOT NULL,
  name varchar2(255) NOT NULL,
  definition clob,
  PRIMARY KEY (cv_id),
  CONSTRAINT u_cv_u_cv UNIQUE (name)
);

--
-- Table: cvterm
--;

CREATE SEQUENCE sq_cvterm_cvterm_id;

CREATE TABLE cvterm (
  cvterm_id number(11,0) NOT NULL,
  cv_id number(10,0) NOT NULL,
  name varchar2(1024) NOT NULL,
  definition clob,
  dbxref_id number(10,0),
  is_obsolete number DEFAULT '0' NOT NULL,
  is_relationshiptype number DEFAULT '0' NOT NULL,
  PRIMARY KEY (cvterm_id),
  CONSTRAINT u_cvterm_u_cvterm_dbxref_id UNIQUE (dbxref_id)
);

--
-- Table: cvterm_dbxref
--;

CREATE SEQUENCE sq_cvterm_dbxref_cvterm_dbxref;

CREATE TABLE cvterm_dbxref (
  cvterm_dbxref_id number(11,0) NOT NULL,
  cvterm_id number(10,0) NOT NULL,
  dbxref_id number(10,0) NOT NULL,
  is_for_definition number DEFAULT '0' NOT NULL,
  PRIMARY KEY (cvterm_dbxref_id),
  CONSTRAINT u_cvterm_dbxref_u_cvterm_dbxre UNIQUE (cvterm_id, dbxref_id)
);

--
-- Table: cvterm_relationship
--;

CREATE SEQUENCE sq_cvterm_relationship_cvterm_;

CREATE TABLE cvterm_relationship (
  cvterm_relationship_id number(11,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  subject_id number(10,0) NOT NULL,
  object_id number(10,0) NOT NULL,
  PRIMARY KEY (cvterm_relationship_id),
  CONSTRAINT u_cvterm_relationship_u_cvterm UNIQUE (subject_id, object_id, type_id)
);

--
-- Table: cvtermpath
--;

CREATE SEQUENCE sq_cvtermpath_cvtermpath_id;

CREATE TABLE cvtermpath (
  cvtermpath_id number(11,0) NOT NULL,
  type_id number(10,0),
  subject_id number(10,0) NOT NULL,
  object_id number(10,0) NOT NULL,
  cv_id number(10,0) NOT NULL,
  pathdistance number(10,0),
  PRIMARY KEY (cvtermpath_id),
  CONSTRAINT u_cvtermpath_u_cvtermpath UNIQUE (subject_id, object_id, type_id, pathdistance)
);

--
-- Table: cvtermprop
--;

CREATE SEQUENCE sq_cvtermprop_cvtermprop_id;

CREATE TABLE cvtermprop (
  cvtermprop_id number NOT NULL,
  cvterm_id number NOT NULL,
  type_id number NOT NULL,
  value varchar2(1024) NOT NULL,
  rank number DEFAULT '0' NOT NULL,
  PRIMARY KEY (cvtermprop_id),
  CONSTRAINT u_cvtermprop_u_cvterm_id UNIQUE (cvterm_id, type_id, value, rank)
);

--
-- Table: cvtermsynonym
--;

CREATE SEQUENCE sq_cvtermsynonym_cvtermsynonym;

CREATE TABLE cvtermsynonym (
  cvtermsynonym_id number(11,0) NOT NULL,
  cvterm_id number(10,0) NOT NULL,
  synonym_ varchar2(1024) NOT NULL,
  type_id number,
  PRIMARY KEY (cvtermsynonym_id),
  CONSTRAINT u_cvtermsynonym_u_cvtermsynony UNIQUE (cvterm_id, synonym_)
);

--
-- Table: db
--;

CREATE SEQUENCE sq_db_db_id;

CREATE TABLE db (
  db_id number(11,0) NOT NULL,
  name varchar2(255) NOT NULL,
  contact_id number(10,0),
  description varchar2(255) DEFAULT NULL,
  urlprefix varchar2(255) DEFAULT NULL,
  url varchar2(255) DEFAULT NULL,
  PRIMARY KEY (db_id),
  CONSTRAINT u_db_u_db UNIQUE (name)
);

--
-- Table: dbxref
--;

CREATE SEQUENCE sq_dbxref_dbxref_id;

CREATE TABLE dbxref (
  dbxref_id number(11,0) NOT NULL,
  db_id number(10,0) NOT NULL,
  accession varchar2(255) NOT NULL,
  version varchar2(255) DEFAULT ' ' NOT NULL,
  description clob,
  PRIMARY KEY (dbxref_id),
  CONSTRAINT u_dbxref_u_dbxref UNIQUE (db_id, accession, version)
);

--
-- Table: dbxrefprop
--;

CREATE SEQUENCE sq_dbxrefprop_dbxrefprop_id;

CREATE TABLE dbxrefprop (
  dbxrefprop_id number(11,0) NOT NULL,
  dbxref_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (dbxrefprop_id),
  CONSTRAINT u_dbxrefprop_u_dbxrefprop UNIQUE (dbxref_id, type_id, rank)
);

--
-- Table: eimage
--;

CREATE SEQUENCE sq_eimage_eimage_id;

CREATE TABLE eimage (
  eimage_id number(11,0) NOT NULL,
  eimage_data clob,
  eimage_type varchar2(255) NOT NULL,
  image_uri varchar2(255),
  PRIMARY KEY (eimage_id)
);

--
-- Table: element
--;

CREATE SEQUENCE sq_element_element_id;

CREATE TABLE element (
  element_id number(11,0) NOT NULL,
  feature_id number(10,0) DEFAULT NULL,
  arraydesign_id number(10,0) NOT NULL,
  type_id number(10,0) DEFAULT NULL,
  dbxref_id number(10,0) DEFAULT NULL,
  subclass_view varchar2(27) NOT NULL,
  tinyint1 number(10,0) DEFAULT NULL,
  smallint1 number(10,0) DEFAULT NULL,
  char1 varchar2(5) DEFAULT NULL,
  char2 varchar2(5) DEFAULT NULL,
  char3 varchar2(5) DEFAULT NULL,
  char4 varchar2(5) DEFAULT NULL,
  char5 varchar2(5) DEFAULT NULL,
  char6 varchar2(5) DEFAULT NULL,
  char7 varchar2(5) DEFAULT NULL,
  tinystring1 varchar2(50) DEFAULT NULL,
  tinystring2 varchar2(50) DEFAULT NULL,
  smallstring1 varchar2(100) DEFAULT NULL,
  smallstring2 varchar2(100) DEFAULT NULL,
  string1 varchar2(500) DEFAULT NULL,
  string2 varchar2(500) DEFAULT NULL,
  PRIMARY KEY (element_id),
  CONSTRAINT u_element_u_element UNIQUE (feature_id, arraydesign_id)
);

--
-- Table: elementresult
--;

CREATE SEQUENCE sq_elementresult_elementresult;

CREATE TABLE elementresult (
  elementresult_id number(11,0) NOT NULL,
  element_id number(10,0) NOT NULL,
  quantification_id number(10,0) NOT NULL,
  subclass_view varchar2(27) NOT NULL,
  foreground number(15,0) DEFAULT NULL,
  background number(15,0) DEFAULT NULL,
  foreground_sd number(15,0) DEFAULT NULL,
  background_sd number(15,0) DEFAULT NULL,
  float1 number(15,0) DEFAULT NULL,
  float2 number(15,0) DEFAULT NULL,
  float3 number(15,0) DEFAULT NULL,
  float4 number(15,0) DEFAULT NULL,
  float5 number(15,0) DEFAULT NULL,
  float6 number(15,0) DEFAULT NULL,
  float7 number(15,0) DEFAULT NULL,
  float8 number(15,0) DEFAULT NULL,
  float9 number(15,0) DEFAULT NULL,
  float10 number(15,0) DEFAULT NULL,
  int1 number(10,0) DEFAULT NULL,
  int2 number(10,0) DEFAULT NULL,
  int3 number(10,0) DEFAULT NULL,
  int4 number(10,0) DEFAULT NULL,
  int5 number(10,0) DEFAULT NULL,
  int6 number(10,0) DEFAULT NULL,
  tinyint1 number(10,0) DEFAULT NULL,
  tinyint2 number(10,0) DEFAULT NULL,
  tinyint3 number(10,0) DEFAULT NULL,
  smallint1 number(10,0) DEFAULT NULL,
  smallint2 number(10,0) DEFAULT NULL,
  char1 varchar2(5) DEFAULT NULL,
  char2 varchar2(5) DEFAULT NULL,
  char3 varchar2(5) DEFAULT NULL,
  char4 varchar2(5) DEFAULT NULL,
  char5 varchar2(5) DEFAULT NULL,
  char6 varchar2(5) DEFAULT NULL,
  tinystring1 varchar2(50) DEFAULT NULL,
  tinystring2 varchar2(50) DEFAULT NULL,
  tinystring3 varchar2(50) DEFAULT NULL,
  smallstring1 varchar2(100) DEFAULT NULL,
  smallstring2 varchar2(100) DEFAULT NULL,
  string1 varchar2(500) DEFAULT NULL,
  string2 varchar2(500) DEFAULT NULL,
  PRIMARY KEY (elementresult_id),
  CONSTRAINT u_elementresult_u_elementresul UNIQUE (element_id, quantification_id, subclass_view)
);

--
-- Table: elementresult_relationship
--;

CREATE SEQUENCE sq_elementresult_relationship_;

CREATE TABLE elementresult_relationship (
  elementresult_relationship_id number(11,0) NOT NULL,
  subject_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  object_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (elementresult_relationship_id),
  CONSTRAINT u_elementresult_relationship_u UNIQUE (subject_id, object_id, type_id, rank)
);

--
-- Table: environment
--;

CREATE SEQUENCE sq_environment_environment_id;

CREATE TABLE environment (
  environment_id number(11,0) NOT NULL,
  uniquename varchar2(4000) NOT NULL,
  description clob,
  PRIMARY KEY (environment_id),
  CONSTRAINT u_environment_u_environment UNIQUE (uniquename)
);

--
-- Table: environment_cvterm
--;

CREATE SEQUENCE sq_environment_cvterm_environm;

CREATE TABLE environment_cvterm (
  environment_cvterm_id number(11,0) NOT NULL,
  environment_id number(10,0) NOT NULL,
  cvterm_id number(10,0) NOT NULL,
  PRIMARY KEY (environment_cvterm_id),
  CONSTRAINT u_environment_cvterm_u_environ UNIQUE (environment_id, cvterm_id)
);

--
-- Table: expression
--;

CREATE SEQUENCE sq_expression_expression_id;

CREATE TABLE expression (
  expression_id number(11,0) NOT NULL,
  description clob,
  PRIMARY KEY (expression_id)
);

--
-- Table: expression_cvterm
--;

CREATE SEQUENCE sq_expression_cvterm_expressio;

CREATE TABLE expression_cvterm (
  expression_cvterm_id number(11,0) NOT NULL,
  expression_id number(10,0) NOT NULL,
  cvterm_id number(10,0) NOT NULL,
  rank number(10,0) NOT NULL,
  cvterm_type varchar2(255),
  PRIMARY KEY (expression_cvterm_id),
  CONSTRAINT u_expression_cvterm_u_expressi UNIQUE (expression_id, cvterm_id)
);

--
-- Table: expression_image
--;

CREATE SEQUENCE sq_expression_image_expression;

CREATE TABLE expression_image (
  expression_image_id number(11,0) NOT NULL,
  expression_id number(10,0) NOT NULL,
  eimage_id number(10,0) NOT NULL,
  PRIMARY KEY (expression_image_id),
  CONSTRAINT u_expression_image_u_expressio UNIQUE (expression_id, eimage_id)
);

--
-- Table: expression_pub
--;

CREATE SEQUENCE sq_expression_pub_expression_p;

CREATE TABLE expression_pub (
  expression_pub_id number(11,0) NOT NULL,
  expression_id number(10,0) NOT NULL,
  pub_id number(10,0) NOT NULL,
  PRIMARY KEY (expression_pub_id),
  CONSTRAINT u_expression_pub_u_expression_ UNIQUE (expression_id, pub_id)
);

--
-- Table: feature
--;

CREATE SEQUENCE sq_feature_feature_id;

CREATE SEQUENCE sq_feature_timeaccessioned;

CREATE SEQUENCE sq_feature_timelastmodified;

CREATE TABLE feature (
  feature_id number(11,0) NOT NULL,
  dbxref_id number(10,0),
  organism_id number(10,0) NOT NULL,
  name varchar2(255),
  uniquename varchar2(4000) NOT NULL,
  residues clob,
  seqlen number(10,0),
  md5checksum char(32),
  type_id number(10,0) NOT NULL,
  is_analysis number(38) DEFAULT '0' NOT NULL,
  timeaccessioned date DEFAULT current_timestamp NOT NULL,
  timelastmodified date DEFAULT current_timestamp NOT NULL,
  created_by varchar2(20) DEFAULT USER NOT NULL,
  modified_by varchar2(20) DEFAULT USER NOT NULL,
  is_deleted number(38) DEFAULT '0',
  is_obsolete number(38) DEFAULT '0' NOT NULL,
  PRIMARY KEY (feature_id),
  CONSTRAINT u_feature_u_feature UNIQUE (organism_id, uniquename, type_id)
);

--
-- Table: feature_cvterm
--;

CREATE SEQUENCE sq_feature_cvterm_feature_cvte;

CREATE TABLE feature_cvterm (
  feature_cvterm_id number(11,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  cvterm_id number(10,0) NOT NULL,
  pub_id number(10,0) NOT NULL,
  is_not number DEFAULT '0' NOT NULL,
  timecreated date DEFAULT current_timestamp,
  timelastmodified date DEFAULT current_timestamp,
  created_by varchar2(20) DEFAULT USER,
  modified_by varchar2(20) DEFAULT USER,
  rank number(38) DEFAULT '0' NOT NULL,
  PRIMARY KEY (feature_cvterm_id),
  CONSTRAINT feature_cvterm_c1 UNIQUE (feature_id, cvterm_id, pub_id, rank)
);

--
-- Table: feature_cvterm_dbxref
--;

CREATE TABLE feature_cvterm_dbxref (
  feature_cvterm_dbxref_id number NOT NULL,
  feature_cvterm_id number NOT NULL,
  dbxref_id number NOT NULL,
  PRIMARY KEY (feature_cvterm_dbxref_id),
  CONSTRAINT u_feature_cvterm_dbxref_u_feat UNIQUE (feature_cvterm_id, dbxref_id)
);

--
-- Table: feature_cvterm_pub
--;

CREATE TABLE feature_cvterm_pub (
  feature_cvterm_pub_id number NOT NULL,
  feature_cvterm_id number NOT NULL,
  pub_id number NOT NULL,
  PRIMARY KEY (feature_cvterm_pub_id),
  CONSTRAINT u_feature_cvterm_pub_u_feature UNIQUE (feature_cvterm_id, pub_id)
);

--
-- Table: feature_cvtermprop
--;

CREATE SEQUENCE sq_feature_cvtermprop_feature_;

CREATE TABLE feature_cvtermprop (
  feature_cvtermprop_id number(11,0) NOT NULL,
  feature_cvterm_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (feature_cvtermprop_id),
  CONSTRAINT u_feature_cvtermprop_u_feature UNIQUE (feature_cvterm_id, type_id, rank)
);

--
-- Table: feature_dbxref
--;

CREATE SEQUENCE sq_feature_dbxref_feature_dbxr;

CREATE TABLE feature_dbxref (
  feature_dbxref_id number(11,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  dbxref_id number(10,0) NOT NULL,
  is_current number(38) DEFAULT '1' NOT NULL,
  PRIMARY KEY (feature_dbxref_id),
  CONSTRAINT u_feature_dbxref_u_feature_dbx UNIQUE (feature_id, dbxref_id)
);

--
-- Table: feature_expression
--;

CREATE SEQUENCE sq_feature_expression_feature_;

CREATE TABLE feature_expression (
  feature_expression_id number(11,0) NOT NULL,
  expression_id number(10,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  PRIMARY KEY (feature_expression_id),
  CONSTRAINT u_feature_expression_u_feature UNIQUE (expression_id, feature_id)
);

--
-- Table: feature_genotype
--;

CREATE SEQUENCE sq_feature_genotype_feature_ge;

CREATE TABLE feature_genotype (
  feature_genotype_id number(11,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  genotype_id number(10,0) NOT NULL,
  chromosome_id number(10,0),
  rank number(10,0),
  cgroup number(10,0),
  cvterm_id number(10,0),
  PRIMARY KEY (feature_genotype_id),
  CONSTRAINT u_feature_genotype_u_feature_g UNIQUE (feature_id, genotype_id, cvterm_id)
);

--
-- Table: feature_phenotype
--;

CREATE SEQUENCE sq_feature_phenotype_feature_p;

CREATE TABLE feature_phenotype (
  feature_phenotype_id number(11,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  phenotype_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  timecreated date DEFAULT current_timestamp,
  timelastmodified date DEFAULT current_timestamp,
  created_by varchar2(20) DEFAULT USER,
  modified_by varchar2(20) DEFAULT USER,
  PRIMARY KEY (feature_phenotype_id),
  CONSTRAINT u_feature_phenotype_u_feature_ UNIQUE (feature_id, phenotype_id, type_id)
);

--
-- Table: feature_pub
--;

CREATE SEQUENCE sq_feature_pub_feature_pub_id;

CREATE TABLE feature_pub (
  feature_pub_id number(38) NOT NULL,
  feature_id number(38) NOT NULL,
  pub_id number(38) NOT NULL,
  PRIMARY KEY (feature_pub_id),
  CONSTRAINT feature_pub_c1 UNIQUE (feature_id, pub_id)
);

--
-- Table: feature_pubprop
--;

CREATE SEQUENCE sq_feature_pubprop_feature_pub;

CREATE TABLE feature_pubprop (
  feature_pubprop_id number(38) NOT NULL,
  feature_pub_id number(38) NOT NULL,
  type_id number(38) NOT NULL,
  value clob,
  rank number(38) DEFAULT '0' NOT NULL,
  PRIMARY KEY (feature_pubprop_id),
  CONSTRAINT feature_pubprop_c1 UNIQUE (feature_pub_id, type_id, rank)
);

--
-- Table: feature_relationship
--;

CREATE SEQUENCE sq_feature_relationship_featur;

CREATE TABLE feature_relationship (
  feature_relationship_id number(11,0) NOT NULL,
  subject_id number(10,0) NOT NULL,
  object_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (feature_relationship_id),
  CONSTRAINT u_feature_relationship_u_featu UNIQUE (subject_id, object_id, type_id, rank)
);

--
-- Table: feature_relationship_pub
--;

CREATE SEQUENCE sq_feature_relationship_pub_fe;

CREATE TABLE feature_relationship_pub (
  feature_relationship_pub_id number(38) NOT NULL,
  feature_relationship_id number(38) NOT NULL,
  pub_id number(38) NOT NULL,
  PRIMARY KEY (feature_relationship_pub_id),
  CONSTRAINT feature_relationship_pub_c1 UNIQUE (feature_relationship_id, pub_id)
);

--
-- Table: feature_relationshipprop
--;

CREATE SEQUENCE sq_feature_relationshipprop_fe;

CREATE TABLE feature_relationshipprop (
  feature_relationshipprop_id number(11,0) NOT NULL,
  feature_relationship_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (feature_relationshipprop_id),
  CONSTRAINT u_feature_relationshipprop_u_f UNIQUE (feature_relationship_id, type_id, rank)
);

--
-- Table: feature_relationshipprop_pub
--;

CREATE SEQUENCE sq_feature_relationshipprop_pu;

CREATE TABLE feature_relationshipprop_pub (
  feature_relationshipprop_pub_i number(38) NOT NULL,
  feature_relationshipprop_id number(38) NOT NULL,
  pub_id number(38) NOT NULL,
  PRIMARY KEY (feature_relationshipprop_pub_i),
  CONSTRAINT u_feature_relationshipprop_pub UNIQUE (feature_relationshipprop_id, pub_id)
);

--
-- Table: feature_synonym
--;

CREATE SEQUENCE sq_feature_synonym_feature_syn;

CREATE TABLE feature_synonym (
  feature_synonym_id number(11,0) NOT NULL,
  synonym_id number(10,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  pub_id number(10,0) NOT NULL,
  is_current number(38) DEFAULT '1' NOT NULL,
  is_internal number(38) DEFAULT '0' NOT NULL,
  PRIMARY KEY (feature_synonym_id),
  CONSTRAINT u_feature_synonym_u_feature_sy UNIQUE (synonym_id, feature_id, pub_id)
);

--
-- Table: featureloc
--;

CREATE SEQUENCE sq_featureloc_featureloc_id;

CREATE SEQUENCE sq_featureloc_timelastmodified;

CREATE TABLE featureloc (
  featureloc_id number(11,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  srcfeature_id number(10,0),
  fmin number(10,0),
  is_fmin_partial number(38) DEFAULT '0' NOT NULL,
  fmax number(10,0),
  is_fmax_partial number(38) DEFAULT '0' NOT NULL,
  strand number(5,0),
  phase number(10,0),
  residue_info clob,
  locgroup number(10,0) DEFAULT '0' NOT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  timecreated date DEFAULT current_timestamp NOT NULL,
  timelastmodified date DEFAULT current_timestamp NOT NULL,
  created_by varchar2(20) DEFAULT USER NOT NULL,
  modified_by varchar2(20) DEFAULT USER NOT NULL,
  PRIMARY KEY (featureloc_id),
  CONSTRAINT u_featureloc_u_featureloc UNIQUE (feature_id, locgroup, rank)
);

--
-- Table: featuremap
--;

CREATE SEQUENCE sq_featuremap_featuremap_id;

CREATE TABLE featuremap (
  featuremap_id number(11,0) NOT NULL,
  name varchar2(255),
  description clob,
  unittype_id number(10,0) DEFAULT NULL,
  PRIMARY KEY (featuremap_id),
  CONSTRAINT u_featuremap_u_featuremap UNIQUE (name)
);

--
-- Table: featuremap_pub
--;

CREATE SEQUENCE sq_featuremap_pub_featuremap_p;

CREATE TABLE featuremap_pub (
  featuremap_pub_id number(11,0) NOT NULL,
  featuremap_id number(10,0) NOT NULL,
  pub_id number(10,0) NOT NULL,
  PRIMARY KEY (featuremap_pub_id)
);

--
-- Table: featurepos
--;

CREATE SEQUENCE sq_featurepos_featurepos_id;

CREATE SEQUENCE sq_featurepos_featuremap_id;

CREATE TABLE featurepos (
  featurepos_id number(11,0) NOT NULL,
  featuremap_id number(11,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  map_feature_id number(10,0) NOT NULL,
  mappos number(20,0) NOT NULL,
  PRIMARY KEY (featurepos_id)
);

--
-- Table: featureprop
--;

CREATE SEQUENCE sq_featureprop_featureprop_id;

CREATE SEQUENCE sq_featureprop_timelastmodifie;

CREATE TABLE featureprop (
  featureprop_id number(11,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  timecreated date DEFAULT current_timestamp NOT NULL,
  timelastmodified date DEFAULT current_timestamp NOT NULL,
  created_by varchar2(20) DEFAULT USER NOT NULL,
  modified_by varchar2(20) DEFAULT USER NOT NULL,
  PRIMARY KEY (featureprop_id),
  CONSTRAINT u_featureprop_u_featureprop UNIQUE (feature_id, type_id, rank)
);

--
-- Table: featureprop_pub
--;

CREATE SEQUENCE sq_featureprop_pub_featureprop;

CREATE TABLE featureprop_pub (
  featureprop_pub_id number(11,0) NOT NULL,
  featureprop_id number(10,0) NOT NULL,
  pub_id number(10,0) NOT NULL,
  PRIMARY KEY (featureprop_pub_id),
  CONSTRAINT u_featureprop_pub_u_featurepro UNIQUE (featureprop_id, pub_id)
);

--
-- Table: featurerange
--;

CREATE SEQUENCE sq_featurerange_featurerange_i;

CREATE TABLE featurerange (
  featurerange_id number(11,0) NOT NULL,
  featuremap_id number(10,0) NOT NULL,
  feature_id number(10,0) NOT NULL,
  leftstartf_id number(10,0) NOT NULL,
  leftendf_id number(10,0),
  rightstartf_id number(10,0),
  rightendf_id number(10,0) NOT NULL,
  rangestr varchar2(255),
  PRIMARY KEY (featurerange_id)
);

--
-- Table: genotype
--;

CREATE SEQUENCE sq_genotype_genotype_id;

CREATE TABLE genotype (
  genotype_id number(11,0) NOT NULL,
  uniquename varchar2(4000) NOT NULL,
  description varchar2(255),
  PRIMARY KEY (genotype_id),
  CONSTRAINT u_genotype_u_genotype UNIQUE (uniquename)
);

--
-- Table: magedocumentation
--;

CREATE SEQUENCE sq_magedocumentation_magedocum;

CREATE TABLE magedocumentation (
  magedocumentation_id number(11,0) NOT NULL,
  mageml_id number(10,0) NOT NULL,
  tableinfo_id number(10,0) NOT NULL,
  row_id number(10,0) NOT NULL,
  mageidentifier clob NOT NULL,
  PRIMARY KEY (magedocumentation_id)
);

--
-- Table: mageml
--;

CREATE SEQUENCE sq_mageml_mageml_id;

CREATE TABLE mageml (
  mageml_id number(11,0) NOT NULL,
  mage_package clob NOT NULL,
  mage_ml clob NOT NULL,
  PRIMARY KEY (mageml_id)
);

--
-- Table: organism
--;

CREATE SEQUENCE sq_organism_organism_id;

CREATE TABLE organism (
  organism_id number(11,0) NOT NULL,
  abbreviation varchar2(255) DEFAULT NULL,
  genus varchar2(255) NOT NULL,
  species varchar2(255) NOT NULL,
  common_name varchar2(255) DEFAULT NULL,
  comment_ clob DEFAULT NULL,
  PRIMARY KEY (organism_id),
  CONSTRAINT u_organism_u_organism UNIQUE (genus, species)
);

--
-- Table: organism_dbxref
--;

CREATE SEQUENCE sq_organism_dbxref_organism_db;

CREATE TABLE organism_dbxref (
  organism_dbxref_id number(11,0) NOT NULL,
  organism_id number(10,0) NOT NULL,
  dbxref_id number(10,0) NOT NULL,
  PRIMARY KEY (organism_dbxref_id),
  CONSTRAINT u_organism_dbxref_u_organism_d UNIQUE (organism_id, dbxref_id)
);

--
-- Table: organismprop
--;

CREATE SEQUENCE sq_organismprop_organismprop_i;

CREATE TABLE organismprop (
  organismprop_id number(11,0) NOT NULL,
  organism_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (organismprop_id),
  CONSTRAINT u_organismprop_u_organismprop UNIQUE (organism_id, type_id, rank)
);

--
-- Table: phendesc
--;

CREATE SEQUENCE sq_phendesc_phendesc_id;

CREATE TABLE phendesc (
  phendesc_id number(11,0) NOT NULL,
  genotype_id number(10,0) NOT NULL,
  environment_id number(10,0) NOT NULL,
  description clob NOT NULL,
  pub_id number(10,0) NOT NULL,
  PRIMARY KEY (phendesc_id),
  CONSTRAINT u_phendesc_u_phendesc UNIQUE (genotype_id, environment_id, pub_id)
);

--
-- Table: phenotype
--;

CREATE SEQUENCE sq_phenotype_phenotype_id;

CREATE SEQUENCE sq_phenotype_created_by;

CREATE TABLE phenotype (
  phenotype_id number(11,0) NOT NULL,
  uniquename varchar2(4000),
  observable_id number(10,0),
  attr_id number(10,0),
  value clob,
  cvalue_id number(10,0),
  assay_id number(10,0),
  timecreated date DEFAULT current_timestamp,
  timelastmodified date DEFAULT current_timestamp,
  created_by varchar2(20) DEFAULT USER,
  modified_by varchar2(20) DEFAULT USER,
  PRIMARY KEY (phenotype_id),
  CONSTRAINT u_phenotype_u_phenotype UNIQUE (uniquename)
);

--
-- Table: phenotype_comparison
--;

CREATE SEQUENCE sq_phenotype_comparison_phenot;

CREATE TABLE phenotype_comparison (
  phenotype_comparison_id number(11,0) NOT NULL,
  genotype1_id number(10,0) NOT NULL,
  environment1_id number(10,0) NOT NULL,
  genotype2_id number(10,0) NOT NULL,
  environment2_id number(10,0) NOT NULL,
  phenotype1_id number(10,0) NOT NULL,
  phenotype2_id number(10,0),
  type_id number(10,0) NOT NULL,
  pub_id number(10,0) NOT NULL,
  PRIMARY KEY (phenotype_comparison_id),
  CONSTRAINT u_phenotype_comparison_u_pheno UNIQUE (genotype1_id, environment1_id, genotype2_id, environment2_id, phenotype1_id, type_id, pub_id)
);

--
-- Table: phenotype_cvterm
--;

CREATE SEQUENCE sq_phenotype_cvterm_phenotype_;

CREATE TABLE phenotype_cvterm (
  phenotype_cvterm_id number(11,0) NOT NULL,
  phenotype_id number(10,0) NOT NULL,
  cvterm_id number(10,0) NOT NULL,
  PRIMARY KEY (phenotype_cvterm_id),
  CONSTRAINT u_phenotype_cvterm_u_phenotype UNIQUE (phenotype_id, cvterm_id)
);

--
-- Table: phenstatement
--;

CREATE SEQUENCE sq_phenstatement_phenstatement;

CREATE TABLE phenstatement (
  phenstatement_id number(11,0) NOT NULL,
  genotype_id number(10,0) NOT NULL,
  environment_id number(10,0),
  phenotype_id number(10,0) NOT NULL,
  type_id number(10,0),
  pub_id number(10,0),
  PRIMARY KEY (phenstatement_id),
  CONSTRAINT u_phenstatement_u_phenstatemen UNIQUE (genotype_id, phenotype_id, environment_id, type_id, pub_id)
);

--
-- Table: project
--;

CREATE SEQUENCE sq_project_project_id;

CREATE TABLE project (
  project_id number(11,0) NOT NULL,
  name varchar2(255) NOT NULL,
  description varchar2(255) NOT NULL,
  PRIMARY KEY (project_id),
  CONSTRAINT u_project_u_project UNIQUE (name)
);

--
-- Table: protocol
--;

CREATE SEQUENCE sq_protocol_protocol_id;

CREATE TABLE protocol (
  protocol_id number(11,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  pub_id number(10,0) DEFAULT NULL,
  dbxref_id number(10,0) DEFAULT NULL,
  name varchar2(4000) NOT NULL,
  uri clob DEFAULT NULL,
  protocoldescription clob DEFAULT NULL,
  hardwaredescription clob DEFAULT NULL,
  softwaredescription clob DEFAULT NULL,
  PRIMARY KEY (protocol_id),
  CONSTRAINT u_protocol_u_protocol UNIQUE (name)
);

--
-- Table: protocolparam
--;

CREATE SEQUENCE sq_protocolparam_protocolparam;

CREATE TABLE protocolparam (
  protocolparam_id number(11,0) NOT NULL,
  protocol_id number(10,0) NOT NULL,
  name clob NOT NULL,
  datatype_id number(10,0) DEFAULT NULL,
  unittype_id number(10,0) DEFAULT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (protocolparam_id)
);

--
-- Table: pub
--;

CREATE SEQUENCE sq_pub_pub_id;

CREATE TABLE pub (
  pub_id number(38) NOT NULL,
  title clob,
  volumetitle clob,
  volume varchar2(255),
  series_name varchar2(255),
  issue varchar2(255),
  pyear varchar2(255),
  pages varchar2(255),
  miniref varchar2(255),
  uniquename varchar2(4000) NOT NULL,
  type_id number(38) NOT NULL,
  is_obsolete number(38) DEFAULT '0',
  publisher varchar2(255),
  pubplace varchar2(255),
  PRIMARY KEY (pub_id),
  CONSTRAINT pub_c1 UNIQUE (uniquename)
);

--
-- Table: pub_dbxref
--;

CREATE SEQUENCE sq_pub_dbxref_pub_dbxref_id;

CREATE TABLE pub_dbxref (
  pub_dbxref_id number(38) NOT NULL,
  pub_id number(38) NOT NULL,
  dbxref_id number(38) NOT NULL,
  is_current number(38) DEFAULT '1' NOT NULL,
  PRIMARY KEY (pub_dbxref_id),
  CONSTRAINT pub_dbxref_c1 UNIQUE (pub_id, dbxref_id)
);

--
-- Table: pub_relationship
--;

CREATE SEQUENCE sq_pub_relationship_pub_relati;

CREATE TABLE pub_relationship (
  pub_relationship_id number(38) NOT NULL,
  subject_id number(38) NOT NULL,
  object_id number(38) NOT NULL,
  type_id number(38) NOT NULL,
  PRIMARY KEY (pub_relationship_id),
  CONSTRAINT pub_relationship_c1 UNIQUE (subject_id, object_id, type_id)
);

--
-- Table: pubauthor
--;

CREATE SEQUENCE sq_pubauthor_pubauthor_id;

CREATE TABLE pubauthor (
  pubauthor_id number(38) NOT NULL,
  pub_id number(38) NOT NULL,
  rank number(38) NOT NULL,
  editor number(38) DEFAULT '0',
  surname varchar2(100) NOT NULL,
  givennames varchar2(100),
  suffix varchar2(100),
  PRIMARY KEY (pubauthor_id),
  CONSTRAINT pubauthor_c1 UNIQUE (pub_id, rank)
);

--
-- Table: pubprop
--;

CREATE SEQUENCE sq_pubprop_pubprop_id;

CREATE TABLE pubprop (
  pubprop_id number(38) NOT NULL,
  pub_id number(38) NOT NULL,
  type_id number(38) NOT NULL,
  value clob NOT NULL,
  rank number(38),
  PRIMARY KEY (pubprop_id),
  CONSTRAINT pubprop_c1 UNIQUE (pub_id, type_id, rank)
);

--
-- Table: quantification
--;

CREATE SEQUENCE sq_quantification_quantificati;

CREATE SEQUENCE sq_quantification_quantifica01;

CREATE TABLE quantification (
  quantification_id number(11,0) NOT NULL,
  acquisition_id number(10,0) NOT NULL,
  operator_id number(10,0) DEFAULT NULL,
  protocol_id number(10,0) DEFAULT NULL,
  analysis_id number(10,0) NOT NULL,
  quantificationdate date DEFAULT current_timestamp,
  name varchar2(4000) DEFAULT NULL,
  uri clob DEFAULT NULL,
  PRIMARY KEY (quantification_id),
  CONSTRAINT u_quantification_u_quantificat UNIQUE (name, analysis_id)
);

--
-- Table: quantification_relationship
--;

CREATE SEQUENCE sq_quantification_relationship;

CREATE TABLE quantification_relationship (
  quantification_relationship_id number(11,0) NOT NULL,
  subject_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  object_id number(10,0) NOT NULL,
  PRIMARY KEY (quantification_relationship_id),
  CONSTRAINT u_quantification_relationship_ UNIQUE (subject_id, object_id, type_id)
);

--
-- Table: quantificationprop
--;

CREATE SEQUENCE sq_quantificationprop_quantifi;

CREATE TABLE quantificationprop (
  quantificationprop_id number(11,0) NOT NULL,
  quantification_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (quantificationprop_id),
  CONSTRAINT u_quantificationprop_u_quantif UNIQUE (quantification_id, type_id, rank)
);

--
-- Table: study
--;

CREATE SEQUENCE sq_study_study_id;

CREATE TABLE study (
  study_id number(11,0) NOT NULL,
  contact_id number(10,0) NOT NULL,
  pub_id number(10,0) DEFAULT NULL,
  dbxref_id number(10,0) DEFAULT NULL,
  name varchar2(4000) NOT NULL,
  description clob DEFAULT NULL,
  PRIMARY KEY (study_id),
  CONSTRAINT u_study_u_study UNIQUE (name)
);

--
-- Table: study_assay
--;

CREATE SEQUENCE sq_study_assay_study_assay_id;

CREATE TABLE study_assay (
  study_assay_id number(11,0) NOT NULL,
  study_id number(10,0) NOT NULL,
  assay_id number(10,0) NOT NULL,
  PRIMARY KEY (study_assay_id),
  CONSTRAINT u_study_assay_u_study_assay UNIQUE (study_id, assay_id)
);

--
-- Table: studydesign
--;

CREATE SEQUENCE sq_studydesign_studydesign_id;

CREATE TABLE studydesign (
  studydesign_id number(11,0) NOT NULL,
  study_id number(10,0) NOT NULL,
  description clob DEFAULT NULL,
  PRIMARY KEY (studydesign_id)
);

--
-- Table: studydesignprop
--;

CREATE SEQUENCE sq_studydesignprop_studydesign;

CREATE TABLE studydesignprop (
  studydesignprop_id number(11,0) NOT NULL,
  studydesign_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  value clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (studydesignprop_id),
  CONSTRAINT u_studydesignprop_u_studydesig UNIQUE (studydesign_id, type_id, rank)
);

--
-- Table: studyfactor
--;

CREATE SEQUENCE sq_studyfactor_studyfactor_id;

CREATE TABLE studyfactor (
  studyfactor_id number(11,0) NOT NULL,
  studydesign_id number(10,0) NOT NULL,
  type_id number(10,0) DEFAULT NULL,
  name clob NOT NULL,
  description clob DEFAULT NULL,
  PRIMARY KEY (studyfactor_id)
);

--
-- Table: studyfactorvalue
--;

CREATE SEQUENCE sq_studyfactorvalue_studyfacto;

CREATE TABLE studyfactorvalue (
  studyfactorvalue_id number(11,0) NOT NULL,
  studyfactor_id number(10,0) NOT NULL,
  assay_id number(10,0) NOT NULL,
  factorvalue clob DEFAULT NULL,
  name clob DEFAULT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  PRIMARY KEY (studyfactorvalue_id)
);

--
-- Table: synonym_
--;

CREATE SEQUENCE sq_synonym__synonym_id;

CREATE TABLE synonym_ (
  synonym_id number(11,0) NOT NULL,
  name varchar2(255) NOT NULL,
  type_id number(10,0) NOT NULL,
  synonym_sgml varchar2(255) NOT NULL,
  PRIMARY KEY (synonym_id),
  CONSTRAINT u_synonym__u_synonym UNIQUE (name, type_id)
);

--
-- Table: tableinfo
--;

CREATE SEQUENCE sq_tableinfo_tableinfo_id;

CREATE TABLE tableinfo (
  tableinfo_id number(11,0) NOT NULL,
  name varchar2(30) NOT NULL,
  primary_key_column varchar2(30) DEFAULT NULL,
  is_view number(10,0) DEFAULT '0' NOT NULL,
  view_on_table_id number(10,0) DEFAULT NULL,
  superclass_table_id number(10,0) DEFAULT NULL,
  is_updateable number(10,0) DEFAULT '1' NOT NULL,
  modification_date date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY (tableinfo_id),
  CONSTRAINT u_tableinfo_u_tableinfo UNIQUE (name)
);

--
-- Table: treatment
--;

CREATE SEQUENCE sq_treatment_treatment_id;

CREATE TABLE treatment (
  treatment_id number(11,0) NOT NULL,
  rank number(10,0) DEFAULT '0' NOT NULL,
  biomaterial_id number(10,0) NOT NULL,
  type_id number(10,0) NOT NULL,
  protocol_id number(10,0) DEFAULT NULL,
  name clob DEFAULT NULL,
  PRIMARY KEY (treatment_id)
);

ALTER TABLE acquisition ADD CONSTRAINT acquisition_assay_id_fk FOREIGN KEY (assay_id) REFERENCES assay (assay_id) ON DELETE CASCADE;

ALTER TABLE acquisition ADD CONSTRAINT acquisition_channel_id_fk FOREIGN KEY (channel_id) REFERENCES channel (channel_id) ON DELETE CASCADE;

ALTER TABLE acquisition ADD CONSTRAINT acquisition_protocol_id_fk FOREIGN KEY (protocol_id) REFERENCES protocol (protocol_id) ON DELETE CASCADE;

ALTER TABLE acquisition_relationship ADD CONSTRAINT acquisition_relationship_objec FOREIGN KEY (object_id) REFERENCES acquisition (acquisition_id) ON DELETE CASCADE;

ALTER TABLE acquisition_relationship ADD CONSTRAINT acquisition_relationship_subje FOREIGN KEY (subject_id) REFERENCES acquisition (acquisition_id) ON DELETE CASCADE;

ALTER TABLE acquisition_relationship ADD CONSTRAINT acquisition_relationship_type_ FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE acquisitionprop ADD CONSTRAINT acquisitionprop_acquisition_id FOREIGN KEY (acquisition_id) REFERENCES acquisition (acquisition_id) ON DELETE CASCADE;

ALTER TABLE acquisitionprop ADD CONSTRAINT acquisitionprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE analysisfeature ADD CONSTRAINT analysisfeature_analysis_id_fk FOREIGN KEY (analysis_id) REFERENCES analysis (analysis_id) ON DELETE CASCADE;

ALTER TABLE analysisfeature ADD CONSTRAINT analysisfeature_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE analysisprop ADD CONSTRAINT analysisprop_analysis_id_fk FOREIGN KEY (analysis_id) REFERENCES analysis (analysis_id) ON DELETE CASCADE;

ALTER TABLE analysisprop ADD CONSTRAINT analysisprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE arraydesign ADD CONSTRAINT arraydesign_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE arraydesign ADD CONSTRAINT arraydesign_manufacturer_id_fk FOREIGN KEY (manufacturer_id) REFERENCES contact (contact_id) ON DELETE CASCADE;

ALTER TABLE arraydesign ADD CONSTRAINT arraydesign_platformtype_id_fk FOREIGN KEY (platformtype_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE arraydesign ADD CONSTRAINT arraydesign_protocol_id_fk FOREIGN KEY (protocol_id) REFERENCES protocol (protocol_id) ON DELETE CASCADE;

ALTER TABLE arraydesign ADD CONSTRAINT arraydesign_substratetype_id_f FOREIGN KEY (substratetype_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE arraydesignprop ADD CONSTRAINT arraydesignprop_arraydesign_id FOREIGN KEY (arraydesign_id) REFERENCES arraydesign (arraydesign_id) ON DELETE CASCADE;

ALTER TABLE arraydesignprop ADD CONSTRAINT arraydesignprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE assay ADD CONSTRAINT assay_arraydesign_id_fk FOREIGN KEY (arraydesign_id) REFERENCES arraydesign (arraydesign_id) ON DELETE CASCADE;

ALTER TABLE assay ADD CONSTRAINT assay_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE assay ADD CONSTRAINT assay_operator_id_fk FOREIGN KEY (operator_id) REFERENCES contact (contact_id) ON DELETE CASCADE;

ALTER TABLE assay ADD CONSTRAINT assay_protocol_id_fk FOREIGN KEY (protocol_id) REFERENCES protocol (protocol_id) ON DELETE CASCADE;

ALTER TABLE assay_biomaterial ADD CONSTRAINT assay_biomaterial_assay_id_fk FOREIGN KEY (assay_id) REFERENCES assay (assay_id) ON DELETE CASCADE;

ALTER TABLE assay_biomaterial ADD CONSTRAINT assay_biomaterial_biomaterial_ FOREIGN KEY (biomaterial_id) REFERENCES biomaterial (biomaterial_id) ON DELETE CASCADE;

ALTER TABLE assay_biomaterial ADD CONSTRAINT assay_biomaterial_channel_id_f FOREIGN KEY (channel_id) REFERENCES channel (channel_id) ON DELETE CASCADE;

ALTER TABLE assay_project ADD CONSTRAINT assay_project_assay_id_fk FOREIGN KEY (assay_id) REFERENCES assay (assay_id) ON DELETE CASCADE;

ALTER TABLE assay_project ADD CONSTRAINT assay_project_project_id_fk FOREIGN KEY (project_id) REFERENCES project (project_id) ON DELETE CASCADE;

ALTER TABLE assayprop ADD CONSTRAINT assayprop_assay_id_fk FOREIGN KEY (assay_id) REFERENCES assay (assay_id) ON DELETE CASCADE;

ALTER TABLE assayprop ADD CONSTRAINT assayprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE author ADD CONSTRAINT author_contact_id_fk FOREIGN KEY (contact_id) REFERENCES contact (contact_id) ON DELETE CASCADE;

ALTER TABLE biomaterial ADD CONSTRAINT biomaterial_biosourceprovider_ FOREIGN KEY (biosourceprovider_id) REFERENCES contact (contact_id) ON DELETE CASCADE;

ALTER TABLE biomaterial ADD CONSTRAINT biomaterial_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE biomaterial ADD CONSTRAINT biomaterial_taxon_id_fk FOREIGN KEY (taxon_id) REFERENCES organism (organism_id) ON DELETE CASCADE;

ALTER TABLE biomaterial_relationship ADD CONSTRAINT biomaterial_relationship_objec FOREIGN KEY (object_id) REFERENCES biomaterial (biomaterial_id) ON DELETE CASCADE;

ALTER TABLE biomaterial_relationship ADD CONSTRAINT biomaterial_relationship_subje FOREIGN KEY (subject_id) REFERENCES biomaterial (biomaterial_id) ON DELETE CASCADE;

ALTER TABLE biomaterial_relationship ADD CONSTRAINT biomaterial_relationship_type_ FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE biomaterial_treatment ADD CONSTRAINT biomaterial_treatment_biomater FOREIGN KEY (biomaterial_id) REFERENCES biomaterial (biomaterial_id) ON DELETE CASCADE;

ALTER TABLE biomaterial_treatment ADD CONSTRAINT biomaterial_treatment_treatmen FOREIGN KEY (treatment_id) REFERENCES treatment (treatment_id) ON DELETE CASCADE;

ALTER TABLE biomaterial_treatment ADD CONSTRAINT biomaterial_treatment_unittype FOREIGN KEY (unittype_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE biomaterialprop ADD CONSTRAINT biomaterialprop_biomaterial_id FOREIGN KEY (biomaterial_id) REFERENCES biomaterial (biomaterial_id) ON DELETE CASCADE;

ALTER TABLE biomaterialprop ADD CONSTRAINT biomaterialprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE control ADD CONSTRAINT control_assay_id_fk FOREIGN KEY (assay_id) REFERENCES assay (assay_id) ON DELETE CASCADE;

ALTER TABLE control ADD CONSTRAINT control_tableinfo_id_fk FOREIGN KEY (tableinfo_id) REFERENCES tableinfo (tableinfo_id) ON DELETE CASCADE;

ALTER TABLE control ADD CONSTRAINT control_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE curator_feature_genotype ADD CONSTRAINT curator_feature_genotype_curat FOREIGN KEY (curator_id) REFERENCES curator (curator_id) ON DELETE CASCADE;

ALTER TABLE curator_feature_genotype ADD CONSTRAINT curator_feature_genotype_featu FOREIGN KEY (feature_genotype_id) REFERENCES feature_genotype (feature_genotype_id) ON DELETE CASCADE;

ALTER TABLE curator_feature_pubprop ADD CONSTRAINT curator_feature_pubprop_curato FOREIGN KEY (curator_id) REFERENCES curator (curator_id) ON DELETE CASCADE;

ALTER TABLE curator_feature_pubprop ADD CONSTRAINT curator_feature_pubprop_featur FOREIGN KEY (feature_pubprop_id) REFERENCES feature_pubprop (feature_pubprop_id) ON DELETE CASCADE;

ALTER TABLE cvterm ADD CONSTRAINT cvterm_cv_id_fk FOREIGN KEY (cv_id) REFERENCES cv (cv_id) ON DELETE CASCADE;

ALTER TABLE cvterm ADD CONSTRAINT cvterm_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE cvterm_dbxref ADD CONSTRAINT cvterm_dbxref_cvterm_id_fk FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvterm_dbxref ADD CONSTRAINT cvterm_dbxref_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE cvterm_relationship ADD CONSTRAINT cvterm_relationship_object_id_ FOREIGN KEY (object_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvterm_relationship ADD CONSTRAINT cvterm_relationship_subject_id FOREIGN KEY (subject_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvterm_relationship ADD CONSTRAINT cvterm_relationship_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvtermpath ADD CONSTRAINT cvtermpath_cv_id_fk FOREIGN KEY (cv_id) REFERENCES cv (cv_id) ON DELETE CASCADE;

ALTER TABLE cvtermpath ADD CONSTRAINT cvtermpath_object_id_fk FOREIGN KEY (object_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvtermpath ADD CONSTRAINT cvtermpath_subject_id_fk FOREIGN KEY (subject_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvtermpath ADD CONSTRAINT cvtermpath_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvtermprop ADD CONSTRAINT cvtermprop_cvterm_id_fk FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvtermprop ADD CONSTRAINT cvtermprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvtermsynonym ADD CONSTRAINT cvtermsynonym_cvterm_id_fk FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE cvtermsynonym ADD CONSTRAINT cvtermsynonym_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE dbxref ADD CONSTRAINT dbxref_db_id_fk FOREIGN KEY (db_id) REFERENCES db (db_id) ON DELETE CASCADE;

ALTER TABLE dbxrefprop ADD CONSTRAINT dbxrefprop_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE dbxrefprop ADD CONSTRAINT dbxrefprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE element ADD CONSTRAINT element_arraydesign_id_fk FOREIGN KEY (arraydesign_id) REFERENCES arraydesign (arraydesign_id) ON DELETE CASCADE;

ALTER TABLE element ADD CONSTRAINT element_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE element ADD CONSTRAINT element_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE element ADD CONSTRAINT element_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE elementresult ADD CONSTRAINT elementresult_element_id_fk FOREIGN KEY (element_id) REFERENCES element (element_id) ON DELETE CASCADE;

ALTER TABLE elementresult ADD CONSTRAINT elementresult_quantification_i FOREIGN KEY (quantification_id) REFERENCES quantification (quantification_id) ON DELETE CASCADE;

ALTER TABLE elementresult_relationship ADD CONSTRAINT elementresult_relationship_obj FOREIGN KEY (object_id) REFERENCES elementresult (elementresult_id) ON DELETE CASCADE;

ALTER TABLE elementresult_relationship ADD CONSTRAINT elementresult_relationship_sub FOREIGN KEY (subject_id) REFERENCES elementresult (elementresult_id) ON DELETE CASCADE;

ALTER TABLE elementresult_relationship ADD CONSTRAINT elementresult_relationship_typ FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE environment_cvterm ADD CONSTRAINT environment_cvterm_cvterm_id_f FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE environment_cvterm ADD CONSTRAINT environment_cvterm_environment FOREIGN KEY (environment_id) REFERENCES environment (environment_id) ON DELETE CASCADE;

ALTER TABLE expression_cvterm ADD CONSTRAINT expression_cvterm_cvterm_id_fk FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE expression_cvterm ADD CONSTRAINT expression_cvterm_expression_i FOREIGN KEY (expression_id) REFERENCES expression (expression_id) ON DELETE CASCADE;

ALTER TABLE expression_image ADD CONSTRAINT expression_image_eimage_id_fk FOREIGN KEY (eimage_id) REFERENCES eimage (eimage_id) ON DELETE CASCADE;

ALTER TABLE expression_image ADD CONSTRAINT expression_image_expression_id FOREIGN KEY (expression_id) REFERENCES expression (expression_id) ON DELETE CASCADE;

ALTER TABLE expression_pub ADD CONSTRAINT expression_pub_expression_id_f FOREIGN KEY (expression_id) REFERENCES expression (expression_id) ON DELETE CASCADE;

ALTER TABLE feature ADD CONSTRAINT feature_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE feature ADD CONSTRAINT feature_organism_id_fk FOREIGN KEY (organism_id) REFERENCES organism (organism_id) ON DELETE CASCADE;

ALTER TABLE feature ADD CONSTRAINT feature_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_cvterm ADD CONSTRAINT feature_cvterm_cvterm_id_fk FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_cvterm ADD CONSTRAINT feature_cvterm_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_cvterm ADD CONSTRAINT feature_cvterm_pub_id_fk FOREIGN KEY (pub_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE feature_cvterm_dbxref ADD CONSTRAINT feature_cvterm_dbxref_dbxref_i FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE feature_cvterm_dbxref ADD CONSTRAINT feature_cvterm_dbxref_feature_ FOREIGN KEY (feature_cvterm_id) REFERENCES feature_cvterm (feature_cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_cvterm_pub ADD CONSTRAINT feature_cvterm_pub_feature_cvt FOREIGN KEY (feature_cvterm_id) REFERENCES feature_cvterm (feature_cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_cvterm_pub ADD CONSTRAINT feature_cvterm_pub_pub_id_fk FOREIGN KEY (pub_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE feature_cvtermprop ADD CONSTRAINT feature_cvtermprop_feature_cvt FOREIGN KEY (feature_cvterm_id) REFERENCES feature_cvterm (feature_cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_cvtermprop ADD CONSTRAINT feature_cvtermprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_dbxref ADD CONSTRAINT feature_dbxref_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE feature_dbxref ADD CONSTRAINT feature_dbxref_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_expression ADD CONSTRAINT feature_expression_expression_ FOREIGN KEY (expression_id) REFERENCES expression (expression_id) ON DELETE CASCADE;

ALTER TABLE feature_expression ADD CONSTRAINT feature_expression_feature_id_ FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_genotype ADD CONSTRAINT feature_genotype_chromosome_id FOREIGN KEY (chromosome_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_genotype ADD CONSTRAINT feature_genotype_cvterm_id_fk FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_genotype ADD CONSTRAINT feature_genotype_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_genotype ADD CONSTRAINT feature_genotype_genotype_id_f FOREIGN KEY (genotype_id) REFERENCES genotype (genotype_id) ON DELETE CASCADE;

ALTER TABLE feature_phenotype ADD CONSTRAINT feature_phenotype_feature_id_f FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_phenotype ADD CONSTRAINT feature_phenotype_phenotype_id FOREIGN KEY (phenotype_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE;

ALTER TABLE feature_phenotype ADD CONSTRAINT feature_phenotype_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_pub ADD CONSTRAINT feature_pub_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_pub ADD CONSTRAINT feature_pub_pub_id_fk FOREIGN KEY (pub_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE feature_pubprop ADD CONSTRAINT feature_pubprop_feature_pub_id FOREIGN KEY (feature_pub_id) REFERENCES feature_pub (feature_pub_id) ON DELETE CASCADE;

ALTER TABLE feature_pubprop ADD CONSTRAINT feature_pubprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_relationship ADD CONSTRAINT feature_relationship_object_id FOREIGN KEY (object_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_relationship ADD CONSTRAINT feature_relationship_subject_i FOREIGN KEY (subject_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_relationship ADD CONSTRAINT feature_relationship_type_id_f FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_relationship_pub ADD CONSTRAINT feature_relationship_pub_featu FOREIGN KEY (feature_relationship_id) REFERENCES feature_relationship (feature_relationship_id) ON DELETE CASCADE;

ALTER TABLE feature_relationship_pub ADD CONSTRAINT feature_relationship_pub_pub_i FOREIGN KEY (pub_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE feature_relationshipprop ADD CONSTRAINT feature_relationshipprop_featu FOREIGN KEY (feature_relationship_id) REFERENCES feature_relationship (feature_relationship_id) ON DELETE CASCADE;

ALTER TABLE feature_relationshipprop ADD CONSTRAINT feature_relationshipprop_type_ FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE feature_relationshipprop_pub ADD CONSTRAINT feature_relationshipprop_pub_f FOREIGN KEY (feature_relationshipprop_id) REFERENCES feature_relationshipprop (feature_relationshipprop_id) ON DELETE CASCADE;

ALTER TABLE feature_relationshipprop_pub ADD CONSTRAINT feature_relationshipprop_pub_p FOREIGN KEY (pub_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE feature_synonym ADD CONSTRAINT feature_synonym_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE feature_synonym ADD CONSTRAINT feature_synonym_synonym_id_fk FOREIGN KEY (synonym_id) REFERENCES synonym_ (synonym_id) ON DELETE CASCADE;

ALTER TABLE featureloc ADD CONSTRAINT featureloc_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featureloc ADD CONSTRAINT featureloc_srcfeature_id_fk FOREIGN KEY (srcfeature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featuremap ADD CONSTRAINT featuremap_unittype_id_fk FOREIGN KEY (unittype_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE featuremap_pub ADD CONSTRAINT featuremap_pub_featuremap_id_f FOREIGN KEY (featuremap_id) REFERENCES featuremap (featuremap_id) ON DELETE CASCADE;

ALTER TABLE featurepos ADD CONSTRAINT featurepos_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featurepos ADD CONSTRAINT featurepos_featuremap_id_fk FOREIGN KEY (featuremap_id) REFERENCES featuremap (featuremap_id) ON DELETE CASCADE;

ALTER TABLE featurepos ADD CONSTRAINT featurepos_map_feature_id_fk FOREIGN KEY (map_feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featureprop ADD CONSTRAINT featureprop_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featureprop ADD CONSTRAINT featureprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE featureprop_pub ADD CONSTRAINT featureprop_pub_featureprop_id FOREIGN KEY (featureprop_id) REFERENCES featureprop (featureprop_id) ON DELETE CASCADE;

ALTER TABLE featurerange ADD CONSTRAINT featurerange_feature_id_fk FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featurerange ADD CONSTRAINT featurerange_featuremap_id_fk FOREIGN KEY (featuremap_id) REFERENCES featuremap (featuremap_id) ON DELETE CASCADE;

ALTER TABLE featurerange ADD CONSTRAINT featurerange_leftendf_id_fk FOREIGN KEY (leftendf_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featurerange ADD CONSTRAINT featurerange_leftstartf_id_fk FOREIGN KEY (leftstartf_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featurerange ADD CONSTRAINT featurerange_rightendf_id_fk FOREIGN KEY (rightendf_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE featurerange ADD CONSTRAINT featurerange_rightstartf_id_fk FOREIGN KEY (rightstartf_id) REFERENCES feature (feature_id) ON DELETE CASCADE;

ALTER TABLE magedocumentation ADD CONSTRAINT magedocumentation_mageml_id_fk FOREIGN KEY (mageml_id) REFERENCES mageml (mageml_id) ON DELETE CASCADE;

ALTER TABLE magedocumentation ADD CONSTRAINT magedocumentation_tableinfo_id FOREIGN KEY (tableinfo_id) REFERENCES tableinfo (tableinfo_id) ON DELETE CASCADE;

ALTER TABLE organism_dbxref ADD CONSTRAINT organism_dbxref_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE organism_dbxref ADD CONSTRAINT organism_dbxref_organism_id_fk FOREIGN KEY (organism_id) REFERENCES organism (organism_id) ON DELETE CASCADE;

ALTER TABLE organismprop ADD CONSTRAINT organismprop_organism_id_fk FOREIGN KEY (organism_id) REFERENCES organism (organism_id) ON DELETE CASCADE;

ALTER TABLE organismprop ADD CONSTRAINT organismprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE phendesc ADD CONSTRAINT phendesc_environment_id_fk FOREIGN KEY (environment_id) REFERENCES environment (environment_id) ON DELETE CASCADE;

ALTER TABLE phendesc ADD CONSTRAINT phendesc_genotype_id_fk FOREIGN KEY (genotype_id) REFERENCES genotype (genotype_id) ON DELETE CASCADE;

ALTER TABLE phenotype ADD CONSTRAINT phenotype_assay_id_fk FOREIGN KEY (assay_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE phenotype ADD CONSTRAINT phenotype_attr_id_fk FOREIGN KEY (attr_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE phenotype ADD CONSTRAINT phenotype_cvalue_id_fk FOREIGN KEY (cvalue_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE phenotype ADD CONSTRAINT phenotype_observable_id_fk FOREIGN KEY (observable_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE phenotype_comparison ADD CONSTRAINT phenotype_comparison_environme FOREIGN KEY (environment1_id) REFERENCES environment (environment_id) ON DELETE CASCADE;

ALTER TABLE phenotype_comparison ADD CONSTRAINT phenotype_comparison_environ01 FOREIGN KEY (environment2_id) REFERENCES environment (environment_id) ON DELETE CASCADE;

ALTER TABLE phenotype_comparison ADD CONSTRAINT phenotype_comparison_genotype1 FOREIGN KEY (genotype1_id) REFERENCES genotype (genotype_id) ON DELETE CASCADE;

ALTER TABLE phenotype_comparison ADD CONSTRAINT phenotype_comparison_genotype2 FOREIGN KEY (genotype2_id) REFERENCES genotype (genotype_id) ON DELETE CASCADE;

ALTER TABLE phenotype_comparison ADD CONSTRAINT phenotype_comparison_phenotype FOREIGN KEY (phenotype1_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE;

ALTER TABLE phenotype_comparison ADD CONSTRAINT phenotype_comparison_phenoty01 FOREIGN KEY (phenotype2_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE;

ALTER TABLE phenotype_comparison ADD CONSTRAINT phenotype_comparison_type_id_f FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE phenotype_cvterm ADD CONSTRAINT phenotype_cvterm_cvterm_id_fk FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE phenotype_cvterm ADD CONSTRAINT phenotype_cvterm_phenotype_id_ FOREIGN KEY (phenotype_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE;

ALTER TABLE phenstatement ADD CONSTRAINT phenstatement_environment_id_f FOREIGN KEY (environment_id) REFERENCES environment (environment_id) ON DELETE CASCADE;

ALTER TABLE phenstatement ADD CONSTRAINT phenstatement_genotype_id_fk FOREIGN KEY (genotype_id) REFERENCES genotype (genotype_id) ON DELETE CASCADE;

ALTER TABLE phenstatement ADD CONSTRAINT phenstatement_phenotype_id_fk FOREIGN KEY (phenotype_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE;

ALTER TABLE phenstatement ADD CONSTRAINT phenstatement_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE protocol ADD CONSTRAINT protocol_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE protocol ADD CONSTRAINT protocol_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE protocolparam ADD CONSTRAINT protocolparam_datatype_id_fk FOREIGN KEY (datatype_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE protocolparam ADD CONSTRAINT protocolparam_protocol_id_fk FOREIGN KEY (protocol_id) REFERENCES protocol (protocol_id) ON DELETE CASCADE;

ALTER TABLE protocolparam ADD CONSTRAINT protocolparam_unittype_id_fk FOREIGN KEY (unittype_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE pub ADD CONSTRAINT pub_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE pub_dbxref ADD CONSTRAINT pub_dbxref_pub_id_fk FOREIGN KEY (pub_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE pub_relationship ADD CONSTRAINT pub_relationship_object_id_fk FOREIGN KEY (object_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE pub_relationship ADD CONSTRAINT pub_relationship_subject_id_fk FOREIGN KEY (subject_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE pubauthor ADD CONSTRAINT pubauthor_pub_id_fk FOREIGN KEY (pub_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE pubprop ADD CONSTRAINT pubprop_pub_id_fk FOREIGN KEY (pub_id) REFERENCES pub (pub_id) ON DELETE CASCADE;

ALTER TABLE quantification ADD CONSTRAINT quantification_acquisition_id_ FOREIGN KEY (acquisition_id) REFERENCES acquisition (acquisition_id) ON DELETE CASCADE;

ALTER TABLE quantification ADD CONSTRAINT quantification_analysis_id_fk FOREIGN KEY (analysis_id) REFERENCES analysis (analysis_id) ON DELETE CASCADE;

ALTER TABLE quantification ADD CONSTRAINT quantification_operator_id_fk FOREIGN KEY (operator_id) REFERENCES contact (contact_id) ON DELETE CASCADE;

ALTER TABLE quantification ADD CONSTRAINT quantification_protocol_id_fk FOREIGN KEY (protocol_id) REFERENCES protocol (protocol_id) ON DELETE CASCADE;

ALTER TABLE quantification_relationship ADD CONSTRAINT quantification_relationship_ob FOREIGN KEY (object_id) REFERENCES quantification (quantification_id) ON DELETE CASCADE;

ALTER TABLE quantification_relationship ADD CONSTRAINT quantification_relationship_su FOREIGN KEY (subject_id) REFERENCES quantification (quantification_id) ON DELETE CASCADE;

ALTER TABLE quantification_relationship ADD CONSTRAINT quantification_relationship_ty FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE quantificationprop ADD CONSTRAINT quantificationprop_quantificat FOREIGN KEY (quantification_id) REFERENCES quantification (quantification_id) ON DELETE CASCADE;

ALTER TABLE quantificationprop ADD CONSTRAINT quantificationprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE study ADD CONSTRAINT study_contact_id_fk FOREIGN KEY (contact_id) REFERENCES contact (contact_id) ON DELETE CASCADE;

ALTER TABLE study ADD CONSTRAINT study_dbxref_id_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref (dbxref_id) ON DELETE CASCADE;

ALTER TABLE study_assay ADD CONSTRAINT study_assay_assay_id_fk FOREIGN KEY (assay_id) REFERENCES assay (assay_id) ON DELETE CASCADE;

ALTER TABLE study_assay ADD CONSTRAINT study_assay_study_id_fk FOREIGN KEY (study_id) REFERENCES study (study_id) ON DELETE CASCADE;

ALTER TABLE studydesign ADD CONSTRAINT studydesign_study_id_fk FOREIGN KEY (study_id) REFERENCES study (study_id) ON DELETE CASCADE;

ALTER TABLE studydesignprop ADD CONSTRAINT studydesignprop_studydesign_id FOREIGN KEY (studydesign_id) REFERENCES studydesign (studydesign_id) ON DELETE CASCADE;

ALTER TABLE studydesignprop ADD CONSTRAINT studydesignprop_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE studyfactor ADD CONSTRAINT studyfactor_studydesign_id_fk FOREIGN KEY (studydesign_id) REFERENCES studydesign (studydesign_id) ON DELETE CASCADE;

ALTER TABLE studyfactor ADD CONSTRAINT studyfactor_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE studyfactorvalue ADD CONSTRAINT studyfactorvalue_assay_id_fk FOREIGN KEY (assay_id) REFERENCES assay (assay_id) ON DELETE CASCADE;

ALTER TABLE studyfactorvalue ADD CONSTRAINT studyfactorvalue_studyfactor_i FOREIGN KEY (studyfactor_id) REFERENCES studyfactor (studyfactor_id) ON DELETE CASCADE;

ALTER TABLE synonym_ ADD CONSTRAINT synonym__type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

ALTER TABLE treatment ADD CONSTRAINT treatment_biomaterial_id_fk FOREIGN KEY (biomaterial_id) REFERENCES biomaterial (biomaterial_id) ON DELETE CASCADE;

ALTER TABLE treatment ADD CONSTRAINT treatment_protocol_id_fk FOREIGN KEY (protocol_id) REFERENCES protocol (protocol_id) ON DELETE CASCADE;

ALTER TABLE treatment ADD CONSTRAINT treatment_type_id_fk FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE;

CREATE INDEX acquisition_idx_assay_id on acquisition (assay_id);

CREATE INDEX acquisition_idx_channel_id on acquisition (channel_id);

CREATE INDEX acquisition_idx_protocol_id on acquisition (protocol_id);

CREATE INDEX acquisition_relationship_idx_o on acquisition_relationship (object_id);

CREATE INDEX acquisition_relationship_idx_s on acquisition_relationship (subject_id);

CREATE INDEX acquisition_relationship_idx_t on acquisition_relationship (type_id);

CREATE INDEX acquisitionprop_idx_acquisitio on acquisitionprop (acquisition_id);

CREATE INDEX acquisitionprop_idx_type_id on acquisitionprop (type_id);

CREATE INDEX analysisfeature_idx_analysis_i on analysisfeature (analysis_id);

CREATE INDEX analysisfeature_idx_feature_id on analysisfeature (feature_id);

CREATE INDEX analysisprop_idx_analysis_id on analysisprop (analysis_id);

CREATE INDEX analysisprop_idx_type_id on analysisprop (type_id);

CREATE INDEX arraydesign_idx_dbxref_id on arraydesign (dbxref_id);

CREATE INDEX arraydesign_idx_manufacturer_i on arraydesign (manufacturer_id);

CREATE INDEX arraydesign_idx_platformtype_i on arraydesign (platformtype_id);

CREATE INDEX arraydesign_idx_protocol_id on arraydesign (protocol_id);

CREATE INDEX arraydesign_idx_substratetype_ on arraydesign (substratetype_id);

CREATE INDEX arraydesignprop_idx_arraydesig on arraydesignprop (arraydesign_id);

CREATE INDEX arraydesignprop_idx_type_id on arraydesignprop (type_id);

CREATE INDEX assay_idx_arraydesign_id on assay (arraydesign_id);

CREATE INDEX assay_idx_dbxref_id on assay (dbxref_id);

CREATE INDEX assay_idx_operator_id on assay (operator_id);

CREATE INDEX assay_idx_protocol_id on assay (protocol_id);

CREATE INDEX assay_biomaterial_idx_assay_id on assay_biomaterial (assay_id);

CREATE INDEX assay_biomaterial_idx_biomater on assay_biomaterial (biomaterial_id);

CREATE INDEX assay_biomaterial_idx_channel_ on assay_biomaterial (channel_id);

CREATE INDEX assay_project_idx_assay_id on assay_project (assay_id);

CREATE INDEX assay_project_idx_project_id on assay_project (project_id);

CREATE INDEX assayprop_idx_assay_id on assayprop (assay_id);

CREATE INDEX assayprop_idx_type_id on assayprop (type_id);

CREATE INDEX author_idx_contact_id on author (contact_id);

CREATE INDEX biomaterial_idx_biosourceprovi on biomaterial (biosourceprovider_id);

CREATE INDEX biomaterial_idx_dbxref_id on biomaterial (dbxref_id);

CREATE INDEX biomaterial_idx_taxon_id on biomaterial (taxon_id);

CREATE INDEX biomaterial_relationship_idx_o on biomaterial_relationship (object_id);

CREATE INDEX biomaterial_relationship_idx_s on biomaterial_relationship (subject_id);

CREATE INDEX biomaterial_relationship_idx_t on biomaterial_relationship (type_id);

CREATE INDEX biomaterial_treatment_idx_biom on biomaterial_treatment (biomaterial_id);

CREATE INDEX biomaterial_treatment_idx_trea on biomaterial_treatment (treatment_id);

CREATE INDEX biomaterial_treatment_idx_unit on biomaterial_treatment (unittype_id);

CREATE INDEX biomaterialprop_idx_biomateria on biomaterialprop (biomaterial_id);

CREATE INDEX biomaterialprop_idx_type_id on biomaterialprop (type_id);

CREATE INDEX control_idx_assay_id on control (assay_id);

CREATE INDEX control_idx_tableinfo_id on control (tableinfo_id);

CREATE INDEX control_idx_type_id on control (type_id);

CREATE INDEX curator_feature_genotype_idx_c on curator_feature_genotype (curator_id);

CREATE INDEX curator_feature_genotype_idx_f on curator_feature_genotype (feature_genotype_id);

CREATE INDEX curator_feature_pubprop_idx_cu on curator_feature_pubprop (curator_id);

CREATE INDEX curator_feature_pubprop_idx_fe on curator_feature_pubprop (feature_pubprop_id);

CREATE INDEX cvterm_idx_cv_id on cvterm (cv_id);

CREATE INDEX cvterm_idx_dbxref_id on cvterm (dbxref_id);

CREATE INDEX cvterm_dbxref_idx_cvterm_id on cvterm_dbxref (cvterm_id);

CREATE INDEX cvterm_dbxref_idx_dbxref_id on cvterm_dbxref (dbxref_id);

CREATE INDEX cvterm_relationship_idx_object on cvterm_relationship (object_id);

CREATE INDEX cvterm_relationship_idx_subjec on cvterm_relationship (subject_id);

CREATE INDEX cvterm_relationship_idx_type_i on cvterm_relationship (type_id);

CREATE INDEX cvtermpath_idx_cv_id on cvtermpath (cv_id);

CREATE INDEX cvtermpath_idx_object_id on cvtermpath (object_id);

CREATE INDEX cvtermpath_idx_subject_id on cvtermpath (subject_id);

CREATE INDEX cvtermpath_idx_type_id on cvtermpath (type_id);

CREATE INDEX cvtermprop_idx_cvterm_id on cvtermprop (cvterm_id);

CREATE INDEX cvtermprop_idx_type_id on cvtermprop (type_id);

CREATE INDEX cvtermsynonym_idx_cvterm_id on cvtermsynonym (cvterm_id);

CREATE INDEX cvtermsynonym_idx_type_id on cvtermsynonym (type_id);

CREATE INDEX dbxref_idx_db_id on dbxref (db_id);

CREATE INDEX dbxrefprop_idx_dbxref_id on dbxrefprop (dbxref_id);

CREATE INDEX dbxrefprop_idx_type_id on dbxrefprop (type_id);

CREATE INDEX element_idx_arraydesign_id on element (arraydesign_id);

CREATE INDEX element_idx_dbxref_id on element (dbxref_id);

CREATE INDEX element_idx_feature_id on element (feature_id);

CREATE INDEX element_idx_type_id on element (type_id);

CREATE INDEX elementresult_idx_element_id on elementresult (element_id);

CREATE INDEX elementresult_idx_quantificati on elementresult (quantification_id);

CREATE INDEX elementresult_relationship_idx on elementresult_relationship (object_id);

CREATE INDEX elementresult_relationship_i01 on elementresult_relationship (subject_id);

CREATE INDEX elementresult_relationship_i02 on elementresult_relationship (type_id);

CREATE INDEX environment_cvterm_idx_cvterm_ on environment_cvterm (cvterm_id);

CREATE INDEX environment_cvterm_idx_environ on environment_cvterm (environment_id);

CREATE INDEX expression_cvterm_idx_cvterm_i on expression_cvterm (cvterm_id);

CREATE INDEX expression_cvterm_idx_expressi on expression_cvterm (expression_id);

CREATE INDEX expression_image_idx_eimage_id on expression_image (eimage_id);

CREATE INDEX expression_image_idx_expressio on expression_image (expression_id);

CREATE INDEX expression_pub_idx_expression_ on expression_pub (expression_id);

CREATE INDEX feature_idx_dbxref_id on feature (dbxref_id);

CREATE INDEX feature_idx_organism_id on feature (organism_id);

CREATE INDEX feature_idx_type_id on feature (type_id);

CREATE INDEX feature_cvterm_idx_cvterm_id on feature_cvterm (cvterm_id);

CREATE INDEX feature_cvterm_idx_feature_id on feature_cvterm (feature_id);

CREATE INDEX feature_cvterm_idx_pub_id on feature_cvterm (pub_id);

CREATE INDEX feature_cvterm_dbxref_idx_dbxr on feature_cvterm_dbxref (dbxref_id);

CREATE INDEX feature_cvterm_dbxref_idx_feat on feature_cvterm_dbxref (feature_cvterm_id);

CREATE INDEX feature_cvterm_pub_idx_feature on feature_cvterm_pub (feature_cvterm_id);

CREATE INDEX feature_cvterm_pub_idx_pub_id on feature_cvterm_pub (pub_id);

CREATE INDEX feature_cvtermprop_idx_feature on feature_cvtermprop (feature_cvterm_id);

CREATE INDEX feature_cvtermprop_idx_type_id on feature_cvtermprop (type_id);

CREATE INDEX feature_dbxref_idx_dbxref_id on feature_dbxref (dbxref_id);

CREATE INDEX feature_dbxref_idx_feature_id on feature_dbxref (feature_id);

CREATE INDEX feature_expression_idx_express on feature_expression (expression_id);

CREATE INDEX feature_expression_idx_feature on feature_expression (feature_id);

CREATE INDEX feature_genotype_idx_chromosom on feature_genotype (chromosome_id);

CREATE INDEX feature_genotype_idx_cvterm_id on feature_genotype (cvterm_id);

CREATE INDEX feature_genotype_idx_feature_i on feature_genotype (feature_id);

CREATE INDEX feature_genotype_idx_genotype_ on feature_genotype (genotype_id);

CREATE INDEX feature_phenotype_idx_feature_ on feature_phenotype (feature_id);

CREATE INDEX feature_phenotype_idx_phenotyp on feature_phenotype (phenotype_id);

CREATE INDEX feature_phenotype_idx_type_id on feature_phenotype (type_id);

CREATE INDEX feature_pub_idx_feature_id on feature_pub (feature_id);

CREATE INDEX feature_pub_idx_pub_id on feature_pub (pub_id);

CREATE INDEX feature_pubprop_idx_feature_pu on feature_pubprop (feature_pub_id);

CREATE INDEX feature_pubprop_idx_type_id on feature_pubprop (type_id);

CREATE INDEX feature_relationship_idx_objec on feature_relationship (object_id);

CREATE INDEX feature_relationship_idx_subje on feature_relationship (subject_id);

CREATE INDEX feature_relationship_idx_type_ on feature_relationship (type_id);

CREATE INDEX feature_relationship_pub_idx_f on feature_relationship_pub (feature_relationship_id);

CREATE INDEX feature_relationship_pub_idx_p on feature_relationship_pub (pub_id);

CREATE INDEX feature_relationshipprop_idx_f on feature_relationshipprop (feature_relationship_id);

CREATE INDEX feature_relationshipprop_idx_t on feature_relationshipprop (type_id);

CREATE INDEX feature_relationshipprop_pub_i on feature_relationshipprop_pub (feature_relationshipprop_id);

CREATE INDEX feature_relationshipprop_pub01 on feature_relationshipprop_pub (pub_id);

CREATE INDEX feature_synonym_idx_feature_id on feature_synonym (feature_id);

CREATE INDEX feature_synonym_idx_synonym_id on feature_synonym (synonym_id);

CREATE INDEX featureloc_idx_feature_id on featureloc (feature_id);

CREATE INDEX featureloc_idx_srcfeature_id on featureloc (srcfeature_id);

CREATE INDEX featuremap_idx_unittype_id on featuremap (unittype_id);

CREATE INDEX featuremap_pub_idx_featuremap_ on featuremap_pub (featuremap_id);

CREATE INDEX featurepos_idx_feature_id on featurepos (feature_id);

CREATE INDEX featurepos_idx_featuremap_id on featurepos (featuremap_id);

CREATE INDEX featurepos_idx_map_feature_id on featurepos (map_feature_id);

CREATE INDEX featureprop_idx_feature_id on featureprop (feature_id);

CREATE INDEX featureprop_idx_type_id on featureprop (type_id);

CREATE INDEX featureprop_pub_idx_featurepro on featureprop_pub (featureprop_id);

CREATE INDEX featurerange_idx_feature_id on featurerange (feature_id);

CREATE INDEX featurerange_idx_featuremap_id on featurerange (featuremap_id);

CREATE INDEX featurerange_idx_leftendf_id on featurerange (leftendf_id);

CREATE INDEX featurerange_idx_leftstartf_id on featurerange (leftstartf_id);

CREATE INDEX featurerange_idx_rightendf_id on featurerange (rightendf_id);

CREATE INDEX featurerange_idx_rightstartf_i on featurerange (rightstartf_id);

CREATE INDEX magedocumentation_idx_mageml_i on magedocumentation (mageml_id);

CREATE INDEX magedocumentation_idx_tableinf on magedocumentation (tableinfo_id);

CREATE INDEX organism_dbxref_idx_dbxref_id on organism_dbxref (dbxref_id);

CREATE INDEX organism_dbxref_idx_organism_i on organism_dbxref (organism_id);

CREATE INDEX organismprop_idx_organism_id on organismprop (organism_id);

CREATE INDEX organismprop_idx_type_id on organismprop (type_id);

CREATE INDEX phendesc_idx_environment_id on phendesc (environment_id);

CREATE INDEX phendesc_idx_genotype_id on phendesc (genotype_id);

CREATE INDEX phenotype_idx_assay_id on phenotype (assay_id);

CREATE INDEX phenotype_idx_attr_id on phenotype (attr_id);

CREATE INDEX phenotype_idx_cvalue_id on phenotype (cvalue_id);

CREATE INDEX phenotype_idx_observable_id on phenotype (observable_id);

CREATE INDEX phenotype_comparison_idx_envir on phenotype_comparison (environment1_id);

CREATE INDEX phenotype_comparison_idx_env01 on phenotype_comparison (environment2_id);

CREATE INDEX phenotype_comparison_idx_genot on phenotype_comparison (genotype1_id);

CREATE INDEX phenotype_comparison_idx_gen01 on phenotype_comparison (genotype2_id);

CREATE INDEX phenotype_comparison_idx_pheno on phenotype_comparison (phenotype1_id);

CREATE INDEX phenotype_comparison_idx_phe01 on phenotype_comparison (phenotype2_id);

CREATE INDEX phenotype_comparison_idx_type_ on phenotype_comparison (type_id);

CREATE INDEX phenotype_cvterm_idx_cvterm_id on phenotype_cvterm (cvterm_id);

CREATE INDEX phenotype_cvterm_idx_phenotype on phenotype_cvterm (phenotype_id);

CREATE INDEX phenstatement_idx_environment_ on phenstatement (environment_id);

CREATE INDEX phenstatement_idx_genotype_id on phenstatement (genotype_id);

CREATE INDEX phenstatement_idx_phenotype_id on phenstatement (phenotype_id);

CREATE INDEX phenstatement_idx_type_id on phenstatement (type_id);

CREATE INDEX protocol_idx_dbxref_id on protocol (dbxref_id);

CREATE INDEX protocol_idx_type_id on protocol (type_id);

CREATE INDEX protocolparam_idx_datatype_id on protocolparam (datatype_id);

CREATE INDEX protocolparam_idx_protocol_id on protocolparam (protocol_id);

CREATE INDEX protocolparam_idx_unittype_id on protocolparam (unittype_id);

CREATE INDEX pub_idx_type_id on pub (type_id);

CREATE INDEX pub_dbxref_idx_pub_id on pub_dbxref (pub_id);

CREATE INDEX pub_relationship_idx_object_id on pub_relationship (object_id);

CREATE INDEX pub_relationship_idx_subject_i on pub_relationship (subject_id);

CREATE INDEX pubauthor_idx_pub_id on pubauthor (pub_id);

CREATE INDEX pubprop_idx_pub_id on pubprop (pub_id);

CREATE INDEX quantification_idx_acquisition on quantification (acquisition_id);

CREATE INDEX quantification_idx_analysis_id on quantification (analysis_id);

CREATE INDEX quantification_idx_operator_id on quantification (operator_id);

CREATE INDEX quantification_idx_protocol_id on quantification (protocol_id);

CREATE INDEX quantification_relationship_id on quantification_relationship (object_id);

CREATE INDEX quantification_relationship_01 on quantification_relationship (subject_id);

CREATE INDEX quantification_relationship_02 on quantification_relationship (type_id);

CREATE INDEX quantificationprop_idx_quantif on quantificationprop (quantification_id);

CREATE INDEX quantificationprop_idx_type_id on quantificationprop (type_id);

CREATE INDEX study_idx_contact_id on study (contact_id);

CREATE INDEX study_idx_dbxref_id on study (dbxref_id);

CREATE INDEX study_assay_idx_assay_id on study_assay (assay_id);

CREATE INDEX study_assay_idx_study_id on study_assay (study_id);

CREATE INDEX studydesign_idx_study_id on studydesign (study_id);

CREATE INDEX studydesignprop_idx_studydesig on studydesignprop (studydesign_id);

CREATE INDEX studydesignprop_idx_type_id on studydesignprop (type_id);

CREATE INDEX studyfactor_idx_studydesign_id on studyfactor (studydesign_id);

CREATE INDEX studyfactor_idx_type_id on studyfactor (type_id);

CREATE INDEX studyfactorvalue_idx_assay_id on studyfactorvalue (assay_id);

CREATE INDEX studyfactorvalue_idx_studyfact on studyfactorvalue (studyfactor_id);

CREATE INDEX synonym__idx_type_id on synonym_ (type_id);

CREATE INDEX treatment_idx_biomaterial_id on treatment (biomaterial_id);

CREATE INDEX treatment_idx_protocol_id on treatment (protocol_id);

CREATE INDEX treatment_idx_type_id on treatment (type_id);

CREATE OR REPLACE TRIGGER ai_acquisition_acquisition_id
BEFORE INSERT ON acquisition
FOR EACH ROW WHEN (
 new.acquisition_id IS NULL OR new.acquisition_id = 0
)
BEGIN
 SELECT sq_acquisition_acquisition_id.nextval
 INTO :new.acquisition_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_acquisition_acquisitiondate
BEFORE INSERT ON acquisition
FOR EACH ROW WHEN (
 new.acquisitiondate IS NULL OR new.acquisitiondate = 0
)
BEGIN
 SELECT sq_acquisition_acquisitiondate.nextval
 INTO :new.acquisitiondate
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_acquisition_relationship_ac
BEFORE INSERT ON acquisition_relationship
FOR EACH ROW WHEN (
 new.acquisition_relationship_id IS NULL OR new.acquisition_relationship_id = 0
)
BEGIN
 SELECT sq_acquisition_relationship_ac.nextval
 INTO :new.acquisition_relationship_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_acquisitionprop_acquisition
BEFORE INSERT ON acquisitionprop
FOR EACH ROW WHEN (
 new.acquisitionprop_id IS NULL OR new.acquisitionprop_id = 0
)
BEGIN
 SELECT sq_acquisitionprop_acquisition.nextval
 INTO :new.acquisitionprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_analysis_analysis_id
BEFORE INSERT ON analysis
FOR EACH ROW WHEN (
 new.analysis_id IS NULL OR new.analysis_id = 0
)
BEGIN
 SELECT sq_analysis_analysis_id.nextval
 INTO :new.analysis_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_analysis_timeexecuted
BEFORE INSERT ON analysis
FOR EACH ROW WHEN (
 new.timeexecuted IS NULL OR new.timeexecuted = 0
)
BEGIN
 SELECT sq_analysis_timeexecuted.nextval
 INTO :new.timeexecuted
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_analysisfeature_analysisfea
BEFORE INSERT ON analysisfeature
FOR EACH ROW WHEN (
 new.analysisfeature_id IS NULL OR new.analysisfeature_id = 0
)
BEGIN
 SELECT sq_analysisfeature_analysisfea.nextval
 INTO :new.analysisfeature_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_analysisprop_analysisprop_i
BEFORE INSERT ON analysisprop
FOR EACH ROW WHEN (
 new.analysisprop_id IS NULL OR new.analysisprop_id = 0
)
BEGIN
 SELECT sq_analysisprop_analysisprop_i.nextval
 INTO :new.analysisprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_arraydesign_arraydesign_id
BEFORE INSERT ON arraydesign
FOR EACH ROW WHEN (
 new.arraydesign_id IS NULL OR new.arraydesign_id = 0
)
BEGIN
 SELECT sq_arraydesign_arraydesign_id.nextval
 INTO :new.arraydesign_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_arraydesignprop_arraydesign
BEFORE INSERT ON arraydesignprop
FOR EACH ROW WHEN (
 new.arraydesignprop_id IS NULL OR new.arraydesignprop_id = 0
)
BEGIN
 SELECT sq_arraydesignprop_arraydesign.nextval
 INTO :new.arraydesignprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_assay_assay_id
BEFORE INSERT ON assay
FOR EACH ROW WHEN (
 new.assay_id IS NULL OR new.assay_id = 0
)
BEGIN
 SELECT sq_assay_assay_id.nextval
 INTO :new.assay_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_assay_assaydate
BEFORE INSERT ON assay
FOR EACH ROW WHEN (
 new.assaydate IS NULL OR new.assaydate = 0
)
BEGIN
 SELECT sq_assay_assaydate.nextval
 INTO :new.assaydate
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_assay_biomaterial_assay_bio
BEFORE INSERT ON assay_biomaterial
FOR EACH ROW WHEN (
 new.assay_biomaterial_id IS NULL OR new.assay_biomaterial_id = 0
)
BEGIN
 SELECT sq_assay_biomaterial_assay_bio.nextval
 INTO :new.assay_biomaterial_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_assay_project_assay_project
BEFORE INSERT ON assay_project
FOR EACH ROW WHEN (
 new.assay_project_id IS NULL OR new.assay_project_id = 0
)
BEGIN
 SELECT sq_assay_project_assay_project.nextval
 INTO :new.assay_project_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_assayprop_assayprop_id
BEFORE INSERT ON assayprop
FOR EACH ROW WHEN (
 new.assayprop_id IS NULL OR new.assayprop_id = 0
)
BEGIN
 SELECT sq_assayprop_assayprop_id.nextval
 INTO :new.assayprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_author_author_id
BEFORE INSERT ON author
FOR EACH ROW WHEN (
 new.author_id IS NULL OR new.author_id = 0
)
BEGIN
 SELECT sq_author_author_id.nextval
 INTO :new.author_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_biomaterial_biomaterial_id
BEFORE INSERT ON biomaterial
FOR EACH ROW WHEN (
 new.biomaterial_id IS NULL OR new.biomaterial_id = 0
)
BEGIN
 SELECT sq_biomaterial_biomaterial_id.nextval
 INTO :new.biomaterial_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_biomaterial_relationship_bi
BEFORE INSERT ON biomaterial_relationship
FOR EACH ROW WHEN (
 new.biomaterial_relationship_id IS NULL OR new.biomaterial_relationship_id = 0
)
BEGIN
 SELECT sq_biomaterial_relationship_bi.nextval
 INTO :new.biomaterial_relationship_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_biomaterial_treatment_bioma
BEFORE INSERT ON biomaterial_treatment
FOR EACH ROW WHEN (
 new.biomaterial_treatment_id IS NULL OR new.biomaterial_treatment_id = 0
)
BEGIN
 SELECT sq_biomaterial_treatment_bioma.nextval
 INTO :new.biomaterial_treatment_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_biomaterialprop_biomaterial
BEFORE INSERT ON biomaterialprop
FOR EACH ROW WHEN (
 new.biomaterialprop_id IS NULL OR new.biomaterialprop_id = 0
)
BEGIN
 SELECT sq_biomaterialprop_biomaterial.nextval
 INTO :new.biomaterialprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_channel_channel_id
BEFORE INSERT ON channel
FOR EACH ROW WHEN (
 new.channel_id IS NULL OR new.channel_id = 0
)
BEGIN
 SELECT sq_channel_channel_id.nextval
 INTO :new.channel_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_contact_contact_id
BEFORE INSERT ON contact
FOR EACH ROW WHEN (
 new.contact_id IS NULL OR new.contact_id = 0
)
BEGIN
 SELECT sq_contact_contact_id.nextval
 INTO :new.contact_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_control_control_id
BEFORE INSERT ON control
FOR EACH ROW WHEN (
 new.control_id IS NULL OR new.control_id = 0
)
BEGIN
 SELECT sq_control_control_id.nextval
 INTO :new.control_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_curator_curator_id
BEFORE INSERT ON curator
FOR EACH ROW WHEN (
 new.curator_id IS NULL OR new.curator_id = 0
)
BEGIN
 SELECT sq_curator_curator_id.nextval
 INTO :new.curator_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_curator_feature_genotype_cu
BEFORE INSERT ON curator_feature_genotype
FOR EACH ROW WHEN (
 new.curator_feature_genotype_id IS NULL OR new.curator_feature_genotype_id = 0
)
BEGIN
 SELECT sq_curator_feature_genotype_cu.nextval
 INTO :new.curator_feature_genotype_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_curator_feature_pubprop_cur
BEFORE INSERT ON curator_feature_pubprop
FOR EACH ROW WHEN (
 new.curator_feature_pubprop_id IS NULL OR new.curator_feature_pubprop_id = 0
)
BEGIN
 SELECT sq_curator_feature_pubprop_cur.nextval
 INTO :new.curator_feature_pubprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_cv_cv_id
BEFORE INSERT ON cv
FOR EACH ROW WHEN (
 new.cv_id IS NULL OR new.cv_id = 0
)
BEGIN
 SELECT sq_cv_cv_id.nextval
 INTO :new.cv_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_cvterm_cvterm_id
BEFORE INSERT ON cvterm
FOR EACH ROW WHEN (
 new.cvterm_id IS NULL OR new.cvterm_id = 0
)
BEGIN
 SELECT sq_cvterm_cvterm_id.nextval
 INTO :new.cvterm_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_cvterm_dbxref_cvterm_dbxref
BEFORE INSERT ON cvterm_dbxref
FOR EACH ROW WHEN (
 new.cvterm_dbxref_id IS NULL OR new.cvterm_dbxref_id = 0
)
BEGIN
 SELECT sq_cvterm_dbxref_cvterm_dbxref.nextval
 INTO :new.cvterm_dbxref_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_cvterm_relationship_cvterm_
BEFORE INSERT ON cvterm_relationship
FOR EACH ROW WHEN (
 new.cvterm_relationship_id IS NULL OR new.cvterm_relationship_id = 0
)
BEGIN
 SELECT sq_cvterm_relationship_cvterm_.nextval
 INTO :new.cvterm_relationship_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_cvtermpath_cvtermpath_id
BEFORE INSERT ON cvtermpath
FOR EACH ROW WHEN (
 new.cvtermpath_id IS NULL OR new.cvtermpath_id = 0
)
BEGIN
 SELECT sq_cvtermpath_cvtermpath_id.nextval
 INTO :new.cvtermpath_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_cvtermprop_cvtermprop_id
BEFORE INSERT ON cvtermprop
FOR EACH ROW WHEN (
 new.cvtermprop_id IS NULL OR new.cvtermprop_id = 0
)
BEGIN
 SELECT sq_cvtermprop_cvtermprop_id.nextval
 INTO :new.cvtermprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_cvtermsynonym_cvtermsynonym
BEFORE INSERT ON cvtermsynonym
FOR EACH ROW WHEN (
 new.cvtermsynonym_id IS NULL OR new.cvtermsynonym_id = 0
)
BEGIN
 SELECT sq_cvtermsynonym_cvtermsynonym.nextval
 INTO :new.cvtermsynonym_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_db_db_id
BEFORE INSERT ON db
FOR EACH ROW WHEN (
 new.db_id IS NULL OR new.db_id = 0
)
BEGIN
 SELECT sq_db_db_id.nextval
 INTO :new.db_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_dbxref_dbxref_id
BEFORE INSERT ON dbxref
FOR EACH ROW WHEN (
 new.dbxref_id IS NULL OR new.dbxref_id = 0
)
BEGIN
 SELECT sq_dbxref_dbxref_id.nextval
 INTO :new.dbxref_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_dbxrefprop_dbxrefprop_id
BEFORE INSERT ON dbxrefprop
FOR EACH ROW WHEN (
 new.dbxrefprop_id IS NULL OR new.dbxrefprop_id = 0
)
BEGIN
 SELECT sq_dbxrefprop_dbxrefprop_id.nextval
 INTO :new.dbxrefprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_eimage_eimage_id
BEFORE INSERT ON eimage
FOR EACH ROW WHEN (
 new.eimage_id IS NULL OR new.eimage_id = 0
)
BEGIN
 SELECT sq_eimage_eimage_id.nextval
 INTO :new.eimage_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_element_element_id
BEFORE INSERT ON element
FOR EACH ROW WHEN (
 new.element_id IS NULL OR new.element_id = 0
)
BEGIN
 SELECT sq_element_element_id.nextval
 INTO :new.element_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_elementresult_elementresult
BEFORE INSERT ON elementresult
FOR EACH ROW WHEN (
 new.elementresult_id IS NULL OR new.elementresult_id = 0
)
BEGIN
 SELECT sq_elementresult_elementresult.nextval
 INTO :new.elementresult_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_elementresult_relationship_
BEFORE INSERT ON elementresult_relationship
FOR EACH ROW WHEN (
 new.elementresult_relationship_id IS NULL OR new.elementresult_relationship_id = 0
)
BEGIN
 SELECT sq_elementresult_relationship_.nextval
 INTO :new.elementresult_relationship_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_environment_environment_id
BEFORE INSERT ON environment
FOR EACH ROW WHEN (
 new.environment_id IS NULL OR new.environment_id = 0
)
BEGIN
 SELECT sq_environment_environment_id.nextval
 INTO :new.environment_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_environment_cvterm_environm
BEFORE INSERT ON environment_cvterm
FOR EACH ROW WHEN (
 new.environment_cvterm_id IS NULL OR new.environment_cvterm_id = 0
)
BEGIN
 SELECT sq_environment_cvterm_environm.nextval
 INTO :new.environment_cvterm_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_expression_expression_id
BEFORE INSERT ON expression
FOR EACH ROW WHEN (
 new.expression_id IS NULL OR new.expression_id = 0
)
BEGIN
 SELECT sq_expression_expression_id.nextval
 INTO :new.expression_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_expression_cvterm_expressio
BEFORE INSERT ON expression_cvterm
FOR EACH ROW WHEN (
 new.expression_cvterm_id IS NULL OR new.expression_cvterm_id = 0
)
BEGIN
 SELECT sq_expression_cvterm_expressio.nextval
 INTO :new.expression_cvterm_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_expression_image_expression
BEFORE INSERT ON expression_image
FOR EACH ROW WHEN (
 new.expression_image_id IS NULL OR new.expression_image_id = 0
)
BEGIN
 SELECT sq_expression_image_expression.nextval
 INTO :new.expression_image_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_expression_pub_expression_p
BEFORE INSERT ON expression_pub
FOR EACH ROW WHEN (
 new.expression_pub_id IS NULL OR new.expression_pub_id = 0
)
BEGIN
 SELECT sq_expression_pub_expression_p.nextval
 INTO :new.expression_pub_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_feature_id
BEFORE INSERT ON feature
FOR EACH ROW WHEN (
 new.feature_id IS NULL OR new.feature_id = 0
)
BEGIN
 SELECT sq_feature_feature_id.nextval
 INTO :new.feature_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_timeaccessioned
BEFORE INSERT ON feature
FOR EACH ROW WHEN (
 new.timeaccessioned IS NULL OR new.timeaccessioned = 0
)
BEGIN
 SELECT sq_feature_timeaccessioned.nextval
 INTO :new.timeaccessioned
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_timelastmodified
BEFORE INSERT ON feature
FOR EACH ROW WHEN (
 new.timelastmodified IS NULL OR new.timelastmodified = 0
)
BEGIN
 SELECT sq_feature_timelastmodified.nextval
 INTO :new.timelastmodified
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_cvterm_feature_cvte
BEFORE INSERT ON feature_cvterm
FOR EACH ROW WHEN (
 new.feature_cvterm_id IS NULL OR new.feature_cvterm_id = 0
)
BEGIN
 SELECT sq_feature_cvterm_feature_cvte.nextval
 INTO :new.feature_cvterm_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_cvtermprop_feature_
BEFORE INSERT ON feature_cvtermprop
FOR EACH ROW WHEN (
 new.feature_cvtermprop_id IS NULL OR new.feature_cvtermprop_id = 0
)
BEGIN
 SELECT sq_feature_cvtermprop_feature_.nextval
 INTO :new.feature_cvtermprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_dbxref_feature_dbxr
BEFORE INSERT ON feature_dbxref
FOR EACH ROW WHEN (
 new.feature_dbxref_id IS NULL OR new.feature_dbxref_id = 0
)
BEGIN
 SELECT sq_feature_dbxref_feature_dbxr.nextval
 INTO :new.feature_dbxref_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_expression_feature_
BEFORE INSERT ON feature_expression
FOR EACH ROW WHEN (
 new.feature_expression_id IS NULL OR new.feature_expression_id = 0
)
BEGIN
 SELECT sq_feature_expression_feature_.nextval
 INTO :new.feature_expression_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_genotype_feature_ge
BEFORE INSERT ON feature_genotype
FOR EACH ROW WHEN (
 new.feature_genotype_id IS NULL OR new.feature_genotype_id = 0
)
BEGIN
 SELECT sq_feature_genotype_feature_ge.nextval
 INTO :new.feature_genotype_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_phenotype_feature_p
BEFORE INSERT ON feature_phenotype
FOR EACH ROW WHEN (
 new.feature_phenotype_id IS NULL OR new.feature_phenotype_id = 0
)
BEGIN
 SELECT sq_feature_phenotype_feature_p.nextval
 INTO :new.feature_phenotype_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_pub_feature_pub_id
BEFORE INSERT ON feature_pub
FOR EACH ROW WHEN (
 new.feature_pub_id IS NULL OR new.feature_pub_id = 0
)
BEGIN
 SELECT sq_feature_pub_feature_pub_id.nextval
 INTO :new.feature_pub_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_pubprop_feature_pub
BEFORE INSERT ON feature_pubprop
FOR EACH ROW WHEN (
 new.feature_pubprop_id IS NULL OR new.feature_pubprop_id = 0
)
BEGIN
 SELECT sq_feature_pubprop_feature_pub.nextval
 INTO :new.feature_pubprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_relationship_featur
BEFORE INSERT ON feature_relationship
FOR EACH ROW WHEN (
 new.feature_relationship_id IS NULL OR new.feature_relationship_id = 0
)
BEGIN
 SELECT sq_feature_relationship_featur.nextval
 INTO :new.feature_relationship_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_relationship_pub_fe
BEFORE INSERT ON feature_relationship_pub
FOR EACH ROW WHEN (
 new.feature_relationship_pub_id IS NULL OR new.feature_relationship_pub_id = 0
)
BEGIN
 SELECT sq_feature_relationship_pub_fe.nextval
 INTO :new.feature_relationship_pub_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_relationshipprop_fe
BEFORE INSERT ON feature_relationshipprop
FOR EACH ROW WHEN (
 new.feature_relationshipprop_id IS NULL OR new.feature_relationshipprop_id = 0
)
BEGIN
 SELECT sq_feature_relationshipprop_fe.nextval
 INTO :new.feature_relationshipprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_relationshipprop_pu
BEFORE INSERT ON feature_relationshipprop_pub
FOR EACH ROW WHEN (
 new.feature_relationshipprop_pub_i IS NULL OR new.feature_relationshipprop_pub_i = 0
)
BEGIN
 SELECT sq_feature_relationshipprop_pu.nextval
 INTO :new.feature_relationshipprop_pub_i
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_feature_synonym_feature_syn
BEFORE INSERT ON feature_synonym
FOR EACH ROW WHEN (
 new.feature_synonym_id IS NULL OR new.feature_synonym_id = 0
)
BEGIN
 SELECT sq_feature_synonym_feature_syn.nextval
 INTO :new.feature_synonym_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featureloc_featureloc_id
BEFORE INSERT ON featureloc
FOR EACH ROW WHEN (
 new.featureloc_id IS NULL OR new.featureloc_id = 0
)
BEGIN
 SELECT sq_featureloc_featureloc_id.nextval
 INTO :new.featureloc_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featureloc_timelastmodified
BEFORE INSERT ON featureloc
FOR EACH ROW WHEN (
 new.timelastmodified IS NULL OR new.timelastmodified = 0
)
BEGIN
 SELECT sq_featureloc_timelastmodified.nextval
 INTO :new.timelastmodified
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featuremap_featuremap_id
BEFORE INSERT ON featuremap
FOR EACH ROW WHEN (
 new.featuremap_id IS NULL OR new.featuremap_id = 0
)
BEGIN
 SELECT sq_featuremap_featuremap_id.nextval
 INTO :new.featuremap_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featuremap_pub_featuremap_p
BEFORE INSERT ON featuremap_pub
FOR EACH ROW WHEN (
 new.featuremap_pub_id IS NULL OR new.featuremap_pub_id = 0
)
BEGIN
 SELECT sq_featuremap_pub_featuremap_p.nextval
 INTO :new.featuremap_pub_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featurepos_featurepos_id
BEFORE INSERT ON featurepos
FOR EACH ROW WHEN (
 new.featurepos_id IS NULL OR new.featurepos_id = 0
)
BEGIN
 SELECT sq_featurepos_featurepos_id.nextval
 INTO :new.featurepos_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featurepos_featuremap_id
BEFORE INSERT ON featurepos
FOR EACH ROW WHEN (
 new.featuremap_id IS NULL OR new.featuremap_id = 0
)
BEGIN
 SELECT sq_featurepos_featuremap_id.nextval
 INTO :new.featuremap_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featureprop_featureprop_id
BEFORE INSERT ON featureprop
FOR EACH ROW WHEN (
 new.featureprop_id IS NULL OR new.featureprop_id = 0
)
BEGIN
 SELECT sq_featureprop_featureprop_id.nextval
 INTO :new.featureprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featureprop_timelastmodifie
BEFORE INSERT ON featureprop
FOR EACH ROW WHEN (
 new.timelastmodified IS NULL OR new.timelastmodified = 0
)
BEGIN
 SELECT sq_featureprop_timelastmodifie.nextval
 INTO :new.timelastmodified
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featureprop_pub_featureprop
BEFORE INSERT ON featureprop_pub
FOR EACH ROW WHEN (
 new.featureprop_pub_id IS NULL OR new.featureprop_pub_id = 0
)
BEGIN
 SELECT sq_featureprop_pub_featureprop.nextval
 INTO :new.featureprop_pub_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_featurerange_featurerange_i
BEFORE INSERT ON featurerange
FOR EACH ROW WHEN (
 new.featurerange_id IS NULL OR new.featurerange_id = 0
)
BEGIN
 SELECT sq_featurerange_featurerange_i.nextval
 INTO :new.featurerange_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_genotype_genotype_id
BEFORE INSERT ON genotype
FOR EACH ROW WHEN (
 new.genotype_id IS NULL OR new.genotype_id = 0
)
BEGIN
 SELECT sq_genotype_genotype_id.nextval
 INTO :new.genotype_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_magedocumentation_magedocum
BEFORE INSERT ON magedocumentation
FOR EACH ROW WHEN (
 new.magedocumentation_id IS NULL OR new.magedocumentation_id = 0
)
BEGIN
 SELECT sq_magedocumentation_magedocum.nextval
 INTO :new.magedocumentation_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_mageml_mageml_id
BEFORE INSERT ON mageml
FOR EACH ROW WHEN (
 new.mageml_id IS NULL OR new.mageml_id = 0
)
BEGIN
 SELECT sq_mageml_mageml_id.nextval
 INTO :new.mageml_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_organism_organism_id
BEFORE INSERT ON organism
FOR EACH ROW WHEN (
 new.organism_id IS NULL OR new.organism_id = 0
)
BEGIN
 SELECT sq_organism_organism_id.nextval
 INTO :new.organism_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_organism_dbxref_organism_db
BEFORE INSERT ON organism_dbxref
FOR EACH ROW WHEN (
 new.organism_dbxref_id IS NULL OR new.organism_dbxref_id = 0
)
BEGIN
 SELECT sq_organism_dbxref_organism_db.nextval
 INTO :new.organism_dbxref_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_organismprop_organismprop_i
BEFORE INSERT ON organismprop
FOR EACH ROW WHEN (
 new.organismprop_id IS NULL OR new.organismprop_id = 0
)
BEGIN
 SELECT sq_organismprop_organismprop_i.nextval
 INTO :new.organismprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_phendesc_phendesc_id
BEFORE INSERT ON phendesc
FOR EACH ROW WHEN (
 new.phendesc_id IS NULL OR new.phendesc_id = 0
)
BEGIN
 SELECT sq_phendesc_phendesc_id.nextval
 INTO :new.phendesc_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_phenotype_phenotype_id
BEFORE INSERT ON phenotype
FOR EACH ROW WHEN (
 new.phenotype_id IS NULL OR new.phenotype_id = 0
)
BEGIN
 SELECT sq_phenotype_phenotype_id.nextval
 INTO :new.phenotype_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_phenotype_created_by
BEFORE INSERT ON phenotype
FOR EACH ROW WHEN (
 new.created_by IS NULL OR new.created_by = 0
)
BEGIN
 SELECT sq_phenotype_created_by.nextval
 INTO :new.created_by
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_phenotype_comparison_phenot
BEFORE INSERT ON phenotype_comparison
FOR EACH ROW WHEN (
 new.phenotype_comparison_id IS NULL OR new.phenotype_comparison_id = 0
)
BEGIN
 SELECT sq_phenotype_comparison_phenot.nextval
 INTO :new.phenotype_comparison_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_phenotype_cvterm_phenotype_
BEFORE INSERT ON phenotype_cvterm
FOR EACH ROW WHEN (
 new.phenotype_cvterm_id IS NULL OR new.phenotype_cvterm_id = 0
)
BEGIN
 SELECT sq_phenotype_cvterm_phenotype_.nextval
 INTO :new.phenotype_cvterm_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_phenstatement_phenstatement
BEFORE INSERT ON phenstatement
FOR EACH ROW WHEN (
 new.phenstatement_id IS NULL OR new.phenstatement_id = 0
)
BEGIN
 SELECT sq_phenstatement_phenstatement.nextval
 INTO :new.phenstatement_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_project_project_id
BEFORE INSERT ON project
FOR EACH ROW WHEN (
 new.project_id IS NULL OR new.project_id = 0
)
BEGIN
 SELECT sq_project_project_id.nextval
 INTO :new.project_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_protocol_protocol_id
BEFORE INSERT ON protocol
FOR EACH ROW WHEN (
 new.protocol_id IS NULL OR new.protocol_id = 0
)
BEGIN
 SELECT sq_protocol_protocol_id.nextval
 INTO :new.protocol_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_protocolparam_protocolparam
BEFORE INSERT ON protocolparam
FOR EACH ROW WHEN (
 new.protocolparam_id IS NULL OR new.protocolparam_id = 0
)
BEGIN
 SELECT sq_protocolparam_protocolparam.nextval
 INTO :new.protocolparam_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_pub_pub_id
BEFORE INSERT ON pub
FOR EACH ROW WHEN (
 new.pub_id IS NULL OR new.pub_id = 0
)
BEGIN
 SELECT sq_pub_pub_id.nextval
 INTO :new.pub_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_pub_dbxref_pub_dbxref_id
BEFORE INSERT ON pub_dbxref
FOR EACH ROW WHEN (
 new.pub_dbxref_id IS NULL OR new.pub_dbxref_id = 0
)
BEGIN
 SELECT sq_pub_dbxref_pub_dbxref_id.nextval
 INTO :new.pub_dbxref_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_pub_relationship_pub_relati
BEFORE INSERT ON pub_relationship
FOR EACH ROW WHEN (
 new.pub_relationship_id IS NULL OR new.pub_relationship_id = 0
)
BEGIN
 SELECT sq_pub_relationship_pub_relati.nextval
 INTO :new.pub_relationship_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_pubauthor_pubauthor_id
BEFORE INSERT ON pubauthor
FOR EACH ROW WHEN (
 new.pubauthor_id IS NULL OR new.pubauthor_id = 0
)
BEGIN
 SELECT sq_pubauthor_pubauthor_id.nextval
 INTO :new.pubauthor_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_pubprop_pubprop_id
BEFORE INSERT ON pubprop
FOR EACH ROW WHEN (
 new.pubprop_id IS NULL OR new.pubprop_id = 0
)
BEGIN
 SELECT sq_pubprop_pubprop_id.nextval
 INTO :new.pubprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_quantification_quantificati
BEFORE INSERT ON quantification
FOR EACH ROW WHEN (
 new.quantification_id IS NULL OR new.quantification_id = 0
)
BEGIN
 SELECT sq_quantification_quantificati.nextval
 INTO :new.quantification_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_quantification_quantifica01
BEFORE INSERT ON quantification
FOR EACH ROW WHEN (
 new.quantificationdate IS NULL OR new.quantificationdate = 0
)
BEGIN
 SELECT sq_quantification_quantifica01.nextval
 INTO :new.quantificationdate
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_quantification_relationship
BEFORE INSERT ON quantification_relationship
FOR EACH ROW WHEN (
 new.quantification_relationship_id IS NULL OR new.quantification_relationship_id = 0
)
BEGIN
 SELECT sq_quantification_relationship.nextval
 INTO :new.quantification_relationship_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_quantificationprop_quantifi
BEFORE INSERT ON quantificationprop
FOR EACH ROW WHEN (
 new.quantificationprop_id IS NULL OR new.quantificationprop_id = 0
)
BEGIN
 SELECT sq_quantificationprop_quantifi.nextval
 INTO :new.quantificationprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_study_study_id
BEFORE INSERT ON study
FOR EACH ROW WHEN (
 new.study_id IS NULL OR new.study_id = 0
)
BEGIN
 SELECT sq_study_study_id.nextval
 INTO :new.study_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_study_assay_study_assay_id
BEFORE INSERT ON study_assay
FOR EACH ROW WHEN (
 new.study_assay_id IS NULL OR new.study_assay_id = 0
)
BEGIN
 SELECT sq_study_assay_study_assay_id.nextval
 INTO :new.study_assay_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_studydesign_studydesign_id
BEFORE INSERT ON studydesign
FOR EACH ROW WHEN (
 new.studydesign_id IS NULL OR new.studydesign_id = 0
)
BEGIN
 SELECT sq_studydesign_studydesign_id.nextval
 INTO :new.studydesign_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_studydesignprop_studydesign
BEFORE INSERT ON studydesignprop
FOR EACH ROW WHEN (
 new.studydesignprop_id IS NULL OR new.studydesignprop_id = 0
)
BEGIN
 SELECT sq_studydesignprop_studydesign.nextval
 INTO :new.studydesignprop_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_studyfactor_studyfactor_id
BEFORE INSERT ON studyfactor
FOR EACH ROW WHEN (
 new.studyfactor_id IS NULL OR new.studyfactor_id = 0
)
BEGIN
 SELECT sq_studyfactor_studyfactor_id.nextval
 INTO :new.studyfactor_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_studyfactorvalue_studyfacto
BEFORE INSERT ON studyfactorvalue
FOR EACH ROW WHEN (
 new.studyfactorvalue_id IS NULL OR new.studyfactorvalue_id = 0
)
BEGIN
 SELECT sq_studyfactorvalue_studyfacto.nextval
 INTO :new.studyfactorvalue_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_synonym__synonym_id
BEFORE INSERT ON synonym_
FOR EACH ROW WHEN (
 new.synonym_id IS NULL OR new.synonym_id = 0
)
BEGIN
 SELECT sq_synonym__synonym_id.nextval
 INTO :new.synonym_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_tableinfo_tableinfo_id
BEFORE INSERT ON tableinfo
FOR EACH ROW WHEN (
 new.tableinfo_id IS NULL OR new.tableinfo_id = 0
)
BEGIN
 SELECT sq_tableinfo_tableinfo_id.nextval
 INTO :new.tableinfo_id
 FROM dual;
END;
/

CREATE OR REPLACE TRIGGER ai_treatment_treatment_id
BEFORE INSERT ON treatment
FOR EACH ROW WHEN (
 new.treatment_id IS NULL OR new.treatment_id = 0
)
BEGIN
 SELECT sq_treatment_treatment_id.nextval
 INTO :new.treatment_id
 FROM dual;
END;
/

