-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Mon Oct 17 10:33:37 2011
-- 

;
BEGIN TRANSACTION;
--
-- Table: acquisition
--
CREATE TABLE acquisition (
  acquisition_id INTEGER PRIMARY KEY NOT NULL,
  assay_id integer NOT NULL,
  protocol_id integer,
  channel_id integer,
  acquisitiondate timestamp DEFAULT current_timestamp,
  name text,
  uri text
);
CREATE INDEX acquisition_idx_assay_id ON acquisition (assay_id);
CREATE INDEX acquisition_idx_channel_id ON acquisition (channel_id);
CREATE INDEX acquisition_idx_protocol_id ON acquisition (protocol_id);
CREATE UNIQUE INDEX acquisition_c1 ON acquisition (name);
--
-- Table: acquisition_relationship
--
CREATE TABLE acquisition_relationship (
  acquisition_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  type_id integer NOT NULL,
  object_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX acquisition_relationship_idx_object_id ON acquisition_relationship (object_id);
CREATE INDEX acquisition_relationship_idx_subject_id ON acquisition_relationship (subject_id);
CREATE INDEX acquisition_relationship_idx_type_id ON acquisition_relationship (type_id);
CREATE UNIQUE INDEX acquisition_relationship_c1 ON acquisition_relationship (subject_id, object_id, type_id, rank);
--
-- Table: acquisitionprop
--
CREATE TABLE acquisitionprop (
  acquisitionprop_id INTEGER PRIMARY KEY NOT NULL,
  acquisition_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX acquisitionprop_idx_acquisition_id ON acquisitionprop (acquisition_id);
CREATE INDEX acquisitionprop_idx_type_id ON acquisitionprop (type_id);
CREATE UNIQUE INDEX acquisitionprop_c1 ON acquisitionprop (acquisition_id, type_id, rank);
--
-- Table: all_feature_names
--
CREATE TABLE all_feature_names (
  feature_id integer,
  name varchar(255),
  organism_id integer
);
--
-- Table: analysis
--
CREATE TABLE analysis (
  analysis_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255),
  description text,
  program varchar(255) NOT NULL,
  programversion varchar(255) NOT NULL,
  algorithm varchar(255),
  sourcename varchar(255),
  sourceversion varchar(255),
  sourceuri text,
  timeexecuted timestamp NOT NULL DEFAULT current_timestamp
);
CREATE UNIQUE INDEX analysis_c1 ON analysis (program, programversion, sourcename);
--
-- Table: analysisfeature
--
CREATE TABLE analysisfeature (
  analysisfeature_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer NOT NULL,
  analysis_id integer NOT NULL,
  rawscore double precision,
  normscore double precision,
  significance double precision,
  identity double precision
);
CREATE INDEX analysisfeature_idx_analysis_id ON analysisfeature (analysis_id);
CREATE INDEX analysisfeature_idx_feature_id ON analysisfeature (feature_id);
CREATE UNIQUE INDEX analysisfeature_c1 ON analysisfeature (feature_id, analysis_id);
--
-- Table: analysisfeatureprop
--
CREATE TABLE analysisfeatureprop (
  analysisfeatureprop_id INTEGER PRIMARY KEY NOT NULL,
  analysisfeature_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL
);
CREATE INDEX analysisfeatureprop_idx_analysisfeature_id ON analysisfeatureprop (analysisfeature_id);
CREATE INDEX analysisfeatureprop_idx_type_id ON analysisfeatureprop (type_id);
CREATE UNIQUE INDEX analysisfeature_id_type_id_rank ON analysisfeatureprop (analysisfeature_id, type_id, rank);
--
-- Table: analysisprop
--
CREATE TABLE analysisprop (
  analysisprop_id INTEGER PRIMARY KEY NOT NULL,
  analysis_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX analysisprop_idx_analysis_id ON analysisprop (analysis_id);
CREATE INDEX analysisprop_idx_type_id ON analysisprop (type_id);
CREATE UNIQUE INDEX analysisprop_c1 ON analysisprop (analysis_id, type_id, rank);
--
-- Table: arraydesign
--
CREATE TABLE arraydesign (
  arraydesign_id INTEGER PRIMARY KEY NOT NULL,
  manufacturer_id integer NOT NULL,
  platformtype_id integer NOT NULL,
  substratetype_id integer,
  protocol_id integer,
  dbxref_id integer,
  name text NOT NULL,
  version text,
  description text,
  array_dimensions text,
  element_dimensions text,
  num_of_elements integer,
  num_array_columns integer,
  num_array_rows integer,
  num_grid_columns integer,
  num_grid_rows integer,
  num_sub_columns integer,
  num_sub_rows integer
);
CREATE INDEX arraydesign_idx_dbxref_id ON arraydesign (dbxref_id);
CREATE INDEX arraydesign_idx_manufacturer_id ON arraydesign (manufacturer_id);
CREATE INDEX arraydesign_idx_platformtype_id ON arraydesign (platformtype_id);
CREATE INDEX arraydesign_idx_protocol_id ON arraydesign (protocol_id);
CREATE INDEX arraydesign_idx_substratetype_id ON arraydesign (substratetype_id);
CREATE UNIQUE INDEX arraydesign_c1 ON arraydesign (name);
--
-- Table: arraydesignprop
--
CREATE TABLE arraydesignprop (
  arraydesignprop_id INTEGER PRIMARY KEY NOT NULL,
  arraydesign_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX arraydesignprop_idx_arraydesign_id ON arraydesignprop (arraydesign_id);
CREATE INDEX arraydesignprop_idx_type_id ON arraydesignprop (type_id);
CREATE UNIQUE INDEX arraydesignprop_c1 ON arraydesignprop (arraydesign_id, type_id, rank);
--
-- Table: assay
--
CREATE TABLE assay (
  assay_id INTEGER PRIMARY KEY NOT NULL,
  arraydesign_id integer NOT NULL,
  protocol_id integer,
  assaydate timestamp DEFAULT current_timestamp,
  arrayidentifier text,
  arraybatchidentifier text,
  operator_id integer NOT NULL,
  dbxref_id integer,
  name text,
  description text
);
CREATE INDEX assay_idx_arraydesign_id ON assay (arraydesign_id);
CREATE INDEX assay_idx_dbxref_id ON assay (dbxref_id);
CREATE INDEX assay_idx_operator_id ON assay (operator_id);
CREATE INDEX assay_idx_protocol_id ON assay (protocol_id);
CREATE UNIQUE INDEX assay_c1 ON assay (name);
--
-- Table: assay_biomaterial
--
CREATE TABLE assay_biomaterial (
  assay_biomaterial_id INTEGER PRIMARY KEY NOT NULL,
  assay_id integer NOT NULL,
  biomaterial_id integer NOT NULL,
  channel_id integer,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX assay_biomaterial_idx_assay_id ON assay_biomaterial (assay_id);
CREATE INDEX assay_biomaterial_idx_biomaterial_id ON assay_biomaterial (biomaterial_id);
CREATE INDEX assay_biomaterial_idx_channel_id ON assay_biomaterial (channel_id);
CREATE UNIQUE INDEX assay_biomaterial_c1 ON assay_biomaterial (assay_id, biomaterial_id, channel_id, rank);
--
-- Table: assay_project
--
CREATE TABLE assay_project (
  assay_project_id INTEGER PRIMARY KEY NOT NULL,
  assay_id integer NOT NULL,
  project_id integer NOT NULL
);
CREATE INDEX assay_project_idx_assay_id ON assay_project (assay_id);
CREATE INDEX assay_project_idx_project_id ON assay_project (project_id);
CREATE UNIQUE INDEX assay_project_c1 ON assay_project (assay_id, project_id);
--
-- Table: assayprop
--
CREATE TABLE assayprop (
  assayprop_id INTEGER PRIMARY KEY NOT NULL,
  assay_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX assayprop_idx_assay_id ON assayprop (assay_id);
CREATE INDEX assayprop_idx_type_id ON assayprop (type_id);
CREATE UNIQUE INDEX assayprop_c1 ON assayprop (assay_id, type_id, rank);
--
-- Table: biomaterial
--
CREATE TABLE biomaterial (
  biomaterial_id INTEGER PRIMARY KEY NOT NULL,
  taxon_id integer,
  biosourceprovider_id integer,
  dbxref_id integer,
  name text,
  description text
);
CREATE INDEX biomaterial_idx_biosourceprovider_id ON biomaterial (biosourceprovider_id);
CREATE INDEX biomaterial_idx_dbxref_id ON biomaterial (dbxref_id);
CREATE INDEX biomaterial_idx_taxon_id ON biomaterial (taxon_id);
CREATE UNIQUE INDEX biomaterial_c1 ON biomaterial (name);
--
-- Table: biomaterial_dbxref
--
CREATE TABLE biomaterial_dbxref (
  biomaterial_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  biomaterial_id integer NOT NULL,
  dbxref_id integer NOT NULL
);
CREATE INDEX biomaterial_dbxref_idx_biomaterial_id ON biomaterial_dbxref (biomaterial_id);
CREATE INDEX biomaterial_dbxref_idx_dbxref_id ON biomaterial_dbxref (dbxref_id);
CREATE UNIQUE INDEX biomaterial_dbxref_c1 ON biomaterial_dbxref (biomaterial_id, dbxref_id);
--
-- Table: biomaterial_relationship
--
CREATE TABLE biomaterial_relationship (
  biomaterial_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  type_id integer NOT NULL,
  object_id integer NOT NULL
);
CREATE INDEX biomaterial_relationship_idx_object_id ON biomaterial_relationship (object_id);
CREATE INDEX biomaterial_relationship_idx_subject_id ON biomaterial_relationship (subject_id);
CREATE INDEX biomaterial_relationship_idx_type_id ON biomaterial_relationship (type_id);
CREATE UNIQUE INDEX biomaterial_relationship_c1 ON biomaterial_relationship (subject_id, object_id, type_id);
--
-- Table: biomaterial_treatment
--
CREATE TABLE biomaterial_treatment (
  biomaterial_treatment_id INTEGER PRIMARY KEY NOT NULL,
  biomaterial_id integer NOT NULL,
  treatment_id integer NOT NULL,
  unittype_id integer,
  value real,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX biomaterial_treatment_idx_biomaterial_id ON biomaterial_treatment (biomaterial_id);
CREATE INDEX biomaterial_treatment_idx_treatment_id ON biomaterial_treatment (treatment_id);
CREATE INDEX biomaterial_treatment_idx_unittype_id ON biomaterial_treatment (unittype_id);
CREATE UNIQUE INDEX biomaterial_treatment_c1 ON biomaterial_treatment (biomaterial_id, treatment_id);
--
-- Table: biomaterialprop
--
CREATE TABLE biomaterialprop (
  biomaterialprop_id INTEGER PRIMARY KEY NOT NULL,
  biomaterial_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX biomaterialprop_idx_biomaterial_id ON biomaterialprop (biomaterial_id);
CREATE INDEX biomaterialprop_idx_type_id ON biomaterialprop (type_id);
CREATE UNIQUE INDEX biomaterialprop_c1 ON biomaterialprop (biomaterial_id, type_id, rank);
--
-- Table: cell_line
--
CREATE TABLE cell_line (
  cell_line_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255),
  uniquename varchar(255) NOT NULL,
  organism_id integer NOT NULL,
  timeaccessioned timestamp NOT NULL DEFAULT current_timestamp,
  timelastmodified timestamp NOT NULL DEFAULT current_timestamp
);
CREATE INDEX cell_line_idx_organism_id ON cell_line (organism_id);
CREATE UNIQUE INDEX cell_line_c1 ON cell_line (uniquename, organism_id);
--
-- Table: cell_line_cvterm
--
CREATE TABLE cell_line_cvterm (
  cell_line_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  cell_line_id integer NOT NULL,
  cvterm_id integer NOT NULL,
  pub_id integer NOT NULL,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX cell_line_cvterm_idx_cell_line_id ON cell_line_cvterm (cell_line_id);
CREATE INDEX cell_line_cvterm_idx_cvterm_id ON cell_line_cvterm (cvterm_id);
CREATE INDEX cell_line_cvterm_idx_pub_id ON cell_line_cvterm (pub_id);
CREATE UNIQUE INDEX cell_line_cvterm_c1 ON cell_line_cvterm (cell_line_id, cvterm_id, pub_id, rank);
--
-- Table: cell_line_cvtermprop
--
CREATE TABLE cell_line_cvtermprop (
  cell_line_cvtermprop_id INTEGER PRIMARY KEY NOT NULL,
  cell_line_cvterm_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX cell_line_cvtermprop_idx_cell_line_cvterm_id ON cell_line_cvtermprop (cell_line_cvterm_id);
CREATE INDEX cell_line_cvtermprop_idx_type_id ON cell_line_cvtermprop (type_id);
CREATE UNIQUE INDEX cell_line_cvtermprop_c1 ON cell_line_cvtermprop (cell_line_cvterm_id, type_id, rank);
--
-- Table: cell_line_dbxref
--
CREATE TABLE cell_line_dbxref (
  cell_line_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  cell_line_id integer NOT NULL,
  dbxref_id integer NOT NULL,
  is_current boolean NOT NULL DEFAULT true
);
CREATE INDEX cell_line_dbxref_idx_cell_line_id ON cell_line_dbxref (cell_line_id);
CREATE INDEX cell_line_dbxref_idx_dbxref_id ON cell_line_dbxref (dbxref_id);
CREATE UNIQUE INDEX cell_line_dbxref_c1 ON cell_line_dbxref (cell_line_id, dbxref_id);
--
-- Table: cell_line_feature
--
CREATE TABLE cell_line_feature (
  cell_line_feature_id INTEGER PRIMARY KEY NOT NULL,
  cell_line_id integer NOT NULL,
  feature_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX cell_line_feature_idx_cell_line_id ON cell_line_feature (cell_line_id);
CREATE INDEX cell_line_feature_idx_feature_id ON cell_line_feature (feature_id);
CREATE INDEX cell_line_feature_idx_pub_id ON cell_line_feature (pub_id);
CREATE UNIQUE INDEX cell_line_feature_c1 ON cell_line_feature (cell_line_id, feature_id, pub_id);
--
-- Table: cell_line_library
--
CREATE TABLE cell_line_library (
  cell_line_library_id INTEGER PRIMARY KEY NOT NULL,
  cell_line_id integer NOT NULL,
  library_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX cell_line_library_idx_cell_line_id ON cell_line_library (cell_line_id);
CREATE INDEX cell_line_library_idx_library_id ON cell_line_library (library_id);
CREATE INDEX cell_line_library_idx_pub_id ON cell_line_library (pub_id);
CREATE UNIQUE INDEX cell_line_library_c1 ON cell_line_library (cell_line_id, library_id, pub_id);
--
-- Table: cell_line_pub
--
CREATE TABLE cell_line_pub (
  cell_line_pub_id INTEGER PRIMARY KEY NOT NULL,
  cell_line_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX cell_line_pub_idx_cell_line_id ON cell_line_pub (cell_line_id);
CREATE INDEX cell_line_pub_idx_pub_id ON cell_line_pub (pub_id);
CREATE UNIQUE INDEX cell_line_pub_c1 ON cell_line_pub (cell_line_id, pub_id);
--
-- Table: cell_line_relationship
--
CREATE TABLE cell_line_relationship (
  cell_line_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  object_id integer NOT NULL,
  type_id integer NOT NULL
);
CREATE INDEX cell_line_relationship_idx_object_id ON cell_line_relationship (object_id);
CREATE INDEX cell_line_relationship_idx_subject_id ON cell_line_relationship (subject_id);
CREATE INDEX cell_line_relationship_idx_type_id ON cell_line_relationship (type_id);
CREATE UNIQUE INDEX cell_line_relationship_c1 ON cell_line_relationship (subject_id, object_id, type_id);
--
-- Table: cell_line_synonym
--
CREATE TABLE cell_line_synonym (
  cell_line_synonym_id INTEGER PRIMARY KEY NOT NULL,
  cell_line_id integer NOT NULL,
  synonym_id integer NOT NULL,
  pub_id integer NOT NULL,
  is_current boolean NOT NULL DEFAULT false,
  is_internal boolean NOT NULL DEFAULT false
);
CREATE INDEX cell_line_synonym_idx_cell_line_id ON cell_line_synonym (cell_line_id);
CREATE INDEX cell_line_synonym_idx_pub_id ON cell_line_synonym (pub_id);
CREATE INDEX cell_line_synonym_idx_synonym_id ON cell_line_synonym (synonym_id);
CREATE UNIQUE INDEX cell_line_synonym_c1 ON cell_line_synonym (synonym_id, cell_line_id, pub_id);
--
-- Table: cell_lineprop
--
CREATE TABLE cell_lineprop (
  cell_lineprop_id INTEGER PRIMARY KEY NOT NULL,
  cell_line_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX cell_lineprop_idx_cell_line_id ON cell_lineprop (cell_line_id);
CREATE INDEX cell_lineprop_idx_type_id ON cell_lineprop (type_id);
CREATE UNIQUE INDEX cell_lineprop_c1 ON cell_lineprop (cell_line_id, type_id, rank);
--
-- Table: cell_lineprop_pub
--
CREATE TABLE cell_lineprop_pub (
  cell_lineprop_pub_id INTEGER PRIMARY KEY NOT NULL,
  cell_lineprop_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX cell_lineprop_pub_idx_cell_lineprop_id ON cell_lineprop_pub (cell_lineprop_id);
CREATE INDEX cell_lineprop_pub_idx_pub_id ON cell_lineprop_pub (pub_id);
CREATE UNIQUE INDEX cell_lineprop_pub_c1 ON cell_lineprop_pub (cell_lineprop_id, pub_id);
--
-- Table: channel
--
CREATE TABLE channel (
  channel_id INTEGER PRIMARY KEY NOT NULL,
  name text NOT NULL,
  definition text NOT NULL
);
CREATE UNIQUE INDEX channel_c1 ON channel (name);
--
-- Table: common_ancestor_cvterm
--
CREATE TABLE common_ancestor_cvterm (
  cvterm1_id integer,
  cvterm2_id integer,
  ancestor_cvterm_id integer,
  pathdistance1 integer,
  pathdistance2 integer,
  total_pathdistance integer
);
--
-- Table: common_descendant_cvterm
--
CREATE TABLE common_descendant_cvterm (
  cvterm1_id integer,
  cvterm2_id integer,
  ancestor_cvterm_id integer,
  pathdistance1 integer,
  pathdistance2 integer,
  total_pathdistance integer
);
--
-- Table: contact
--
CREATE TABLE contact (
  contact_id INTEGER PRIMARY KEY NOT NULL,
  type_id integer,
  name varchar(255) NOT NULL,
  description varchar(255)
);
CREATE INDEX contact_idx_type_id ON contact (type_id);
CREATE UNIQUE INDEX contact_c1 ON contact (name);
--
-- Table: contact_relationship
--
CREATE TABLE contact_relationship (
  contact_relationship_id INTEGER PRIMARY KEY NOT NULL,
  type_id integer NOT NULL,
  subject_id integer NOT NULL,
  object_id integer NOT NULL
);
CREATE INDEX contact_relationship_idx_object_id ON contact_relationship (object_id);
CREATE INDEX contact_relationship_idx_subject_id ON contact_relationship (subject_id);
CREATE INDEX contact_relationship_idx_type_id ON contact_relationship (type_id);
CREATE UNIQUE INDEX contact_relationship_c1 ON contact_relationship (subject_id, object_id, type_id);
--
-- Table: control
--
CREATE TABLE control (
  control_id INTEGER PRIMARY KEY NOT NULL,
  type_id integer NOT NULL,
  assay_id integer NOT NULL,
  tableinfo_id integer NOT NULL,
  row_id integer NOT NULL,
  name text,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX control_idx_assay_id ON control (assay_id);
CREATE INDEX control_idx_tableinfo_id ON control (tableinfo_id);
CREATE INDEX control_idx_type_id ON control (type_id);
--
-- Table: cv
--
CREATE TABLE cv (
  cv_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255) NOT NULL,
  definition text
);
CREATE UNIQUE INDEX cv_c1 ON cv (name);
--
-- Table: cv_cvterm_count
--
CREATE TABLE cv_cvterm_count (
  name varchar(255),
  num_terms_excl_obs bigint
);
--
-- Table: cv_cvterm_count_with_obs
--
CREATE TABLE cv_cvterm_count_with_obs (
  name varchar(255),
  num_terms_incl_obs bigint
);
--
-- Table: cv_leaf
--
CREATE TABLE cv_leaf (
  cv_id integer,
  cvterm_id integer
);
--
-- Table: cv_link_count
--
CREATE TABLE cv_link_count (
  cv_name varchar(255),
  relation_name varchar(1024),
  relation_cv_name varchar(255),
  num_links bigint
);
--
-- Table: cv_path_count
--
CREATE TABLE cv_path_count (
  cv_name varchar(255),
  relation_name varchar(1024),
  relation_cv_name varchar(255),
  num_paths bigint
);
--
-- Table: cv_root
--
CREATE TABLE cv_root (
  cv_id integer,
  root_cvterm_id integer
);
--
-- Table: cvprop
--
CREATE TABLE cvprop (
  cvprop_id INTEGER PRIMARY KEY NOT NULL,
  cv_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX cvprop_idx_cv_id ON cvprop (cv_id);
CREATE INDEX cvprop_idx_type_id ON cvprop (type_id);
CREATE UNIQUE INDEX cvprop_c1 ON cvprop (cv_id, type_id, rank);
--
-- Table: cvterm
--
CREATE TABLE cvterm (
  cvterm_id INTEGER PRIMARY KEY NOT NULL,
  cv_id integer NOT NULL,
  name varchar(1024) NOT NULL,
  definition text,
  dbxref_id integer NOT NULL,
  is_obsolete integer NOT NULL DEFAULT 0,
  is_relationshiptype integer NOT NULL DEFAULT 0
);
CREATE INDEX cvterm_idx_cv_id ON cvterm (cv_id);
CREATE INDEX cvterm_idx_dbxref_id ON cvterm (dbxref_id);
CREATE UNIQUE INDEX cvterm_c1 ON cvterm (name, cv_id, is_obsolete);
CREATE UNIQUE INDEX cvterm_c2 ON cvterm (dbxref_id);
--
-- Table: cvterm_dbxref
--
CREATE TABLE cvterm_dbxref (
  cvterm_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  cvterm_id integer NOT NULL,
  dbxref_id integer NOT NULL,
  is_for_definition integer NOT NULL DEFAULT 0
);
CREATE INDEX cvterm_dbxref_idx_cvterm_id ON cvterm_dbxref (cvterm_id);
CREATE INDEX cvterm_dbxref_idx_dbxref_id ON cvterm_dbxref (dbxref_id);
CREATE UNIQUE INDEX cvterm_dbxref_c1 ON cvterm_dbxref (cvterm_id, dbxref_id);
--
-- Table: cvterm_relationship
--
CREATE TABLE cvterm_relationship (
  cvterm_relationship_id INTEGER PRIMARY KEY NOT NULL,
  type_id integer NOT NULL,
  subject_id integer NOT NULL,
  object_id integer NOT NULL
);
CREATE INDEX cvterm_relationship_idx_object_id ON cvterm_relationship (object_id);
CREATE INDEX cvterm_relationship_idx_subject_id ON cvterm_relationship (subject_id);
CREATE INDEX cvterm_relationship_idx_type_id ON cvterm_relationship (type_id);
CREATE UNIQUE INDEX cvterm_relationship_c1 ON cvterm_relationship (subject_id, object_id, type_id);
--
-- Table: cvtermpath
--
CREATE TABLE cvtermpath (
  cvtermpath_id INTEGER PRIMARY KEY NOT NULL,
  type_id integer,
  subject_id integer NOT NULL,
  object_id integer NOT NULL,
  cv_id integer NOT NULL,
  pathdistance integer
);
CREATE INDEX cvtermpath_idx_cv_id ON cvtermpath (cv_id);
CREATE INDEX cvtermpath_idx_object_id ON cvtermpath (object_id);
CREATE INDEX cvtermpath_idx_subject_id ON cvtermpath (subject_id);
CREATE INDEX cvtermpath_idx_type_id ON cvtermpath (type_id);
CREATE UNIQUE INDEX cvtermpath_c1 ON cvtermpath (subject_id, object_id, type_id, pathdistance);
--
-- Table: cvtermprop
--
CREATE TABLE cvtermprop (
  cvtermprop_id INTEGER PRIMARY KEY NOT NULL,
  cvterm_id integer NOT NULL,
  type_id integer NOT NULL,
  value text NOT NULL DEFAULT '',
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX cvtermprop_idx_cvterm_id ON cvtermprop (cvterm_id);
CREATE INDEX cvtermprop_idx_type_id ON cvtermprop (type_id);
CREATE UNIQUE INDEX cvtermprop_cvterm_id_key ON cvtermprop (cvterm_id, type_id, value, rank);
--
-- Table: cvtermsynonym
--
CREATE TABLE cvtermsynonym (
  cvtermsynonym_id INTEGER PRIMARY KEY NOT NULL,
  cvterm_id integer NOT NULL,
  synonym varchar(1024) NOT NULL,
  type_id integer
);
CREATE INDEX cvtermsynonym_idx_cvterm_id ON cvtermsynonym (cvterm_id);
CREATE INDEX cvtermsynonym_idx_type_id ON cvtermsynonym (type_id);
CREATE UNIQUE INDEX cvtermsynonym_c1 ON cvtermsynonym (cvterm_id, synonym);
--
-- Table: db
--
CREATE TABLE db (
  db_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(255),
  urlprefix varchar(255),
  url varchar(255)
);
CREATE UNIQUE INDEX db_c1 ON db (name);
--
-- Table: db_dbxref_count
--
CREATE TABLE db_dbxref_count (
  name varchar(255),
  num_dbxrefs bigint
);
--
-- Table: dbxref
--
CREATE TABLE dbxref (
  dbxref_id INTEGER PRIMARY KEY NOT NULL,
  db_id integer NOT NULL,
  accession varchar(255) NOT NULL,
  version varchar(255) NOT NULL DEFAULT '',
  description text
);
CREATE INDEX dbxref_idx_db_id ON dbxref (db_id);
CREATE UNIQUE INDEX dbxref_c1 ON dbxref (db_id, accession, version);
--
-- Table: dbxrefprop
--
CREATE TABLE dbxrefprop (
  dbxrefprop_id INTEGER PRIMARY KEY NOT NULL,
  dbxref_id integer NOT NULL,
  type_id integer NOT NULL,
  value text NOT NULL DEFAULT '',
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX dbxrefprop_idx_dbxref_id ON dbxrefprop (dbxref_id);
CREATE INDEX dbxrefprop_idx_type_id ON dbxrefprop (type_id);
CREATE UNIQUE INDEX dbxrefprop_c1 ON dbxrefprop (dbxref_id, type_id, rank);
--
-- Table: dfeatureloc
--
CREATE TABLE dfeatureloc (
  featureloc_id integer,
  feature_id integer,
  srcfeature_id integer,
  nbeg integer,
  is_nbeg_partial boolean,
  nend integer,
  is_nend_partial boolean,
  strand smallint,
  phase integer,
  residue_info text,
  locgroup integer,
  rank integer
);
--
-- Table: eimage
--
CREATE TABLE eimage (
  eimage_id INTEGER PRIMARY KEY NOT NULL,
  eimage_data text,
  eimage_type varchar(255) NOT NULL,
  image_uri varchar(255)
);
--
-- Table: element
--
CREATE TABLE element (
  element_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer,
  arraydesign_id integer NOT NULL,
  type_id integer,
  dbxref_id integer
);
CREATE INDEX element_idx_arraydesign_id ON element (arraydesign_id);
CREATE INDEX element_idx_dbxref_id ON element (dbxref_id);
CREATE INDEX element_idx_feature_id ON element (feature_id);
CREATE INDEX element_idx_type_id ON element (type_id);
CREATE UNIQUE INDEX element_c1 ON element (feature_id, arraydesign_id);
--
-- Table: element_relationship
--
CREATE TABLE element_relationship (
  element_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  type_id integer NOT NULL,
  object_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX element_relationship_idx_object_id ON element_relationship (object_id);
CREATE INDEX element_relationship_idx_subject_id ON element_relationship (subject_id);
CREATE INDEX element_relationship_idx_type_id ON element_relationship (type_id);
CREATE UNIQUE INDEX element_relationship_c1 ON element_relationship (subject_id, object_id, type_id, rank);
--
-- Table: elementresult
--
CREATE TABLE elementresult (
  elementresult_id INTEGER PRIMARY KEY NOT NULL,
  element_id integer NOT NULL,
  quantification_id integer NOT NULL,
  signal double precision NOT NULL
);
CREATE INDEX elementresult_idx_element_id ON elementresult (element_id);
CREATE INDEX elementresult_idx_quantification_id ON elementresult (quantification_id);
CREATE UNIQUE INDEX elementresult_c1 ON elementresult (element_id, quantification_id);
--
-- Table: elementresult_relationship
--
CREATE TABLE elementresult_relationship (
  elementresult_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  type_id integer NOT NULL,
  object_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX elementresult_relationship_idx_object_id ON elementresult_relationship (object_id);
CREATE INDEX elementresult_relationship_idx_subject_id ON elementresult_relationship (subject_id);
CREATE INDEX elementresult_relationship_idx_type_id ON elementresult_relationship (type_id);
CREATE UNIQUE INDEX elementresult_relationship_c1 ON elementresult_relationship (subject_id, object_id, type_id, rank);
--
-- Table: environment
--
CREATE TABLE environment (
  environment_id INTEGER PRIMARY KEY NOT NULL,
  uniquename text NOT NULL,
  description text
);
CREATE UNIQUE INDEX environment_c1 ON environment (uniquename);
--
-- Table: environment_cvterm
--
CREATE TABLE environment_cvterm (
  environment_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  environment_id integer NOT NULL,
  cvterm_id integer NOT NULL
);
CREATE INDEX environment_cvterm_idx_cvterm_id ON environment_cvterm (cvterm_id);
CREATE INDEX environment_cvterm_idx_environment_id ON environment_cvterm (environment_id);
CREATE UNIQUE INDEX environment_cvterm_c1 ON environment_cvterm (environment_id, cvterm_id);
--
-- Table: expression
--
CREATE TABLE expression (
  expression_id INTEGER PRIMARY KEY NOT NULL,
  uniquename text NOT NULL,
  md5checksum char(32),
  description text
);
CREATE UNIQUE INDEX expression_c1 ON expression (uniquename);
--
-- Table: expression_cvterm
--
CREATE TABLE expression_cvterm (
  expression_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  expression_id integer NOT NULL,
  cvterm_id integer NOT NULL,
  rank integer NOT NULL DEFAULT 0,
  cvterm_type_id integer NOT NULL
);
CREATE INDEX expression_cvterm_idx_cvterm_id ON expression_cvterm (cvterm_id);
CREATE INDEX expression_cvterm_idx_cvterm_type_id ON expression_cvterm (cvterm_type_id);
CREATE INDEX expression_cvterm_idx_expression_id ON expression_cvterm (expression_id);
CREATE UNIQUE INDEX expression_cvterm_c1 ON expression_cvterm (expression_id, cvterm_id, cvterm_type_id);
--
-- Table: expression_cvtermprop
--
CREATE TABLE expression_cvtermprop (
  expression_cvtermprop_id INTEGER PRIMARY KEY NOT NULL,
  expression_cvterm_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX expression_cvtermprop_idx_expression_cvterm_id ON expression_cvtermprop (expression_cvterm_id);
CREATE INDEX expression_cvtermprop_idx_type_id ON expression_cvtermprop (type_id);
CREATE UNIQUE INDEX expression_cvtermprop_c1 ON expression_cvtermprop (expression_cvterm_id, type_id, rank);
--
-- Table: expression_image
--
CREATE TABLE expression_image (
  expression_image_id INTEGER PRIMARY KEY NOT NULL,
  expression_id integer NOT NULL,
  eimage_id integer NOT NULL
);
CREATE INDEX expression_image_idx_eimage_id ON expression_image (eimage_id);
CREATE INDEX expression_image_idx_expression_id ON expression_image (expression_id);
CREATE UNIQUE INDEX expression_image_c1 ON expression_image (expression_id, eimage_id);
--
-- Table: expression_pub
--
CREATE TABLE expression_pub (
  expression_pub_id INTEGER PRIMARY KEY NOT NULL,
  expression_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX expression_pub_idx_expression_id ON expression_pub (expression_id);
CREATE INDEX expression_pub_idx_pub_id ON expression_pub (pub_id);
CREATE UNIQUE INDEX expression_pub_c1 ON expression_pub (expression_id, pub_id);
--
-- Table: expressionprop
--
CREATE TABLE expressionprop (
  expressionprop_id INTEGER PRIMARY KEY NOT NULL,
  expression_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX expressionprop_idx_expression_id ON expressionprop (expression_id);
CREATE INDEX expressionprop_idx_type_id ON expressionprop (type_id);
CREATE UNIQUE INDEX expressionprop_c1 ON expressionprop (expression_id, type_id, rank);
--
-- Table: f_loc
--
CREATE TABLE f_loc (
  feature_id integer,
  name varchar(255),
  dbxref_id integer,
  nbeg integer,
  nend integer,
  strand smallint
);
--
-- Table: f_type
--
CREATE TABLE f_type (
  feature_id integer,
  name varchar(255),
  dbxref_id integer,
  type varchar(1024),
  residues text,
  seqlen integer,
  md5checksum char(32),
  type_id integer,
  timeaccessioned timestamp,
  timelastmodified timestamp
);
--
-- Table: feature
--
CREATE TABLE feature (
  feature_id INTEGER PRIMARY KEY NOT NULL,
  dbxref_id integer,
  organism_id integer NOT NULL,
  name varchar(255),
  uniquename text NOT NULL,
  residues text,
  seqlen integer,
  md5checksum char(32),
  type_id integer NOT NULL,
  is_analysis boolean NOT NULL DEFAULT false,
  is_obsolete boolean NOT NULL DEFAULT false,
  timeaccessioned timestamp NOT NULL DEFAULT current_timestamp,
  timelastmodified timestamp NOT NULL DEFAULT current_timestamp
);
CREATE INDEX feature_idx_dbxref_id ON feature (dbxref_id);
CREATE INDEX feature_idx_organism_id ON feature (organism_id);
CREATE INDEX feature_idx_type_id ON feature (type_id);
CREATE UNIQUE INDEX feature_c1 ON feature (organism_id, uniquename, type_id);
--
-- Table: feature_contains
--
CREATE TABLE feature_contains (
  subject_id integer,
  object_id integer
);
--
-- Table: feature_cvterm
--
CREATE TABLE feature_cvterm (
  feature_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer NOT NULL,
  cvterm_id integer NOT NULL,
  pub_id integer NOT NULL,
  is_not boolean NOT NULL DEFAULT false,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX feature_cvterm_idx_cvterm_id ON feature_cvterm (cvterm_id);
CREATE INDEX feature_cvterm_idx_feature_id ON feature_cvterm (feature_id);
CREATE INDEX feature_cvterm_idx_pub_id ON feature_cvterm (pub_id);
CREATE UNIQUE INDEX feature_cvterm_c1 ON feature_cvterm (feature_id, cvterm_id, pub_id, rank);
--
-- Table: feature_cvterm_dbxref
--
CREATE TABLE feature_cvterm_dbxref (
  feature_cvterm_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  feature_cvterm_id integer NOT NULL,
  dbxref_id integer NOT NULL
);
CREATE INDEX feature_cvterm_dbxref_idx_dbxref_id ON feature_cvterm_dbxref (dbxref_id);
CREATE INDEX feature_cvterm_dbxref_idx_feature_cvterm_id ON feature_cvterm_dbxref (feature_cvterm_id);
CREATE UNIQUE INDEX feature_cvterm_dbxref_c1 ON feature_cvterm_dbxref (feature_cvterm_id, dbxref_id);
--
-- Table: feature_cvterm_pub
--
CREATE TABLE feature_cvterm_pub (
  feature_cvterm_pub_id INTEGER PRIMARY KEY NOT NULL,
  feature_cvterm_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX feature_cvterm_pub_idx_feature_cvterm_id ON feature_cvterm_pub (feature_cvterm_id);
CREATE INDEX feature_cvterm_pub_idx_pub_id ON feature_cvterm_pub (pub_id);
CREATE UNIQUE INDEX feature_cvterm_pub_c1 ON feature_cvterm_pub (feature_cvterm_id, pub_id);
--
-- Table: feature_cvtermprop
--
CREATE TABLE feature_cvtermprop (
  feature_cvtermprop_id INTEGER PRIMARY KEY NOT NULL,
  feature_cvterm_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX feature_cvtermprop_idx_feature_cvterm_id ON feature_cvtermprop (feature_cvterm_id);
CREATE INDEX feature_cvtermprop_idx_type_id ON feature_cvtermprop (type_id);
CREATE UNIQUE INDEX feature_cvtermprop_c1 ON feature_cvtermprop (feature_cvterm_id, type_id, rank);
--
-- Table: feature_dbxref
--
CREATE TABLE feature_dbxref (
  feature_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer NOT NULL,
  dbxref_id integer NOT NULL,
  is_current boolean NOT NULL DEFAULT true
);
CREATE INDEX feature_dbxref_idx_dbxref_id ON feature_dbxref (dbxref_id);
CREATE INDEX feature_dbxref_idx_feature_id ON feature_dbxref (feature_id);
CREATE UNIQUE INDEX feature_dbxref_c1 ON feature_dbxref (feature_id, dbxref_id);
--
-- Table: feature_difference
--
CREATE TABLE feature_difference (
  subject_id integer,
  object_id integer,
  srcfeature_id smallint,
  fmin integer,
  fmax integer,
  strand integer
);
--
-- Table: feature_disjoint
--
CREATE TABLE feature_disjoint (
  subject_id integer,
  object_id integer
);
--
-- Table: feature_distance
--
CREATE TABLE feature_distance (
  subject_id integer,
  object_id integer,
  srcfeature_id integer,
  subject_strand smallint,
  object_strand smallint,
  distance integer
);
--
-- Table: feature_expression
--
CREATE TABLE feature_expression (
  feature_expression_id INTEGER PRIMARY KEY NOT NULL,
  expression_id integer NOT NULL,
  feature_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX feature_expression_idx_expression_id ON feature_expression (expression_id);
CREATE INDEX feature_expression_idx_feature_id ON feature_expression (feature_id);
CREATE INDEX feature_expression_idx_pub_id ON feature_expression (pub_id);
CREATE UNIQUE INDEX feature_expression_c1 ON feature_expression (expression_id, feature_id, pub_id);
--
-- Table: feature_expressionprop
--
CREATE TABLE feature_expressionprop (
  feature_expressionprop_id INTEGER PRIMARY KEY NOT NULL,
  feature_expression_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX feature_expressionprop_idx_feature_expression_id ON feature_expressionprop (feature_expression_id);
CREATE INDEX feature_expressionprop_idx_type_id ON feature_expressionprop (type_id);
CREATE UNIQUE INDEX feature_expressionprop_c1 ON feature_expressionprop (feature_expression_id, type_id, rank);
--
-- Table: feature_genotype
--
CREATE TABLE feature_genotype (
  feature_genotype_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer NOT NULL,
  genotype_id integer NOT NULL,
  chromosome_id integer,
  rank integer NOT NULL,
  cgroup integer NOT NULL,
  cvterm_id integer NOT NULL
);
CREATE INDEX feature_genotype_idx_chromosome_id ON feature_genotype (chromosome_id);
CREATE INDEX feature_genotype_idx_cvterm_id ON feature_genotype (cvterm_id);
CREATE INDEX feature_genotype_idx_feature_id ON feature_genotype (feature_id);
CREATE INDEX feature_genotype_idx_genotype_id ON feature_genotype (genotype_id);
CREATE UNIQUE INDEX feature_genotype_c1 ON feature_genotype (feature_id, genotype_id, cvterm_id, chromosome_id, rank, cgroup);
--
-- Table: feature_intersection
--
CREATE TABLE feature_intersection (
  subject_id integer,
  object_id integer,
  srcfeature_id integer,
  subject_strand smallint,
  object_strand smallint,
  fmin integer,
  fmax integer
);
--
-- Table: feature_meets
--
CREATE TABLE feature_meets (
  subject_id integer,
  object_id integer
);
--
-- Table: feature_meets_on_same_strand
--
CREATE TABLE feature_meets_on_same_strand (
  subject_id integer,
  object_id integer
);
--
-- Table: feature_phenotype
--
CREATE TABLE feature_phenotype (
  feature_phenotype_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer NOT NULL,
  phenotype_id integer NOT NULL
);
CREATE INDEX feature_phenotype_idx_feature_id ON feature_phenotype (feature_id);
CREATE INDEX feature_phenotype_idx_phenotype_id ON feature_phenotype (phenotype_id);
CREATE UNIQUE INDEX feature_phenotype_c1 ON feature_phenotype (feature_id, phenotype_id);
--
-- Table: feature_pub
--
CREATE TABLE feature_pub (
  feature_pub_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX feature_pub_idx_feature_id ON feature_pub (feature_id);
CREATE INDEX feature_pub_idx_pub_id ON feature_pub (pub_id);
CREATE UNIQUE INDEX feature_pub_c1 ON feature_pub (feature_id, pub_id);
--
-- Table: feature_pubprop
--
CREATE TABLE feature_pubprop (
  feature_pubprop_id INTEGER PRIMARY KEY NOT NULL,
  feature_pub_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX feature_pubprop_idx_feature_pub_id ON feature_pubprop (feature_pub_id);
CREATE INDEX feature_pubprop_idx_type_id ON feature_pubprop (type_id);
CREATE UNIQUE INDEX feature_pubprop_c1 ON feature_pubprop (feature_pub_id, type_id, rank);
--
-- Table: feature_relationship
--
CREATE TABLE feature_relationship (
  feature_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  object_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX feature_relationship_idx_object_id ON feature_relationship (object_id);
CREATE INDEX feature_relationship_idx_subject_id ON feature_relationship (subject_id);
CREATE INDEX feature_relationship_idx_type_id ON feature_relationship (type_id);
CREATE UNIQUE INDEX feature_relationship_c1 ON feature_relationship (subject_id, object_id, type_id, rank);
--
-- Table: feature_relationship_pub
--
CREATE TABLE feature_relationship_pub (
  feature_relationship_pub_id INTEGER PRIMARY KEY NOT NULL,
  feature_relationship_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX feature_relationship_pub_idx_feature_relationship_id ON feature_relationship_pub (feature_relationship_id);
CREATE INDEX feature_relationship_pub_idx_pub_id ON feature_relationship_pub (pub_id);
CREATE UNIQUE INDEX feature_relationship_pub_c1 ON feature_relationship_pub (feature_relationship_id, pub_id);
--
-- Table: feature_relationshipprop
--
CREATE TABLE feature_relationshipprop (
  feature_relationshipprop_id INTEGER PRIMARY KEY NOT NULL,
  feature_relationship_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX feature_relationshipprop_idx_feature_relationship_id ON feature_relationshipprop (feature_relationship_id);
CREATE INDEX feature_relationshipprop_idx_type_id ON feature_relationshipprop (type_id);
CREATE UNIQUE INDEX feature_relationshipprop_c1 ON feature_relationshipprop (feature_relationship_id, type_id, rank);
--
-- Table: feature_relationshipprop_pub
--
CREATE TABLE feature_relationshipprop_pub (
  feature_relationshipprop_pub_id INTEGER PRIMARY KEY NOT NULL,
  feature_relationshipprop_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX feature_relationshipprop_pub_idx_feature_relationshipprop_id ON feature_relationshipprop_pub (feature_relationshipprop_id);
CREATE INDEX feature_relationshipprop_pub_idx_pub_id ON feature_relationshipprop_pub (pub_id);
CREATE UNIQUE INDEX feature_relationshipprop_pub_c1 ON feature_relationshipprop_pub (feature_relationshipprop_id, pub_id);
--
-- Table: feature_synonym
--
CREATE TABLE feature_synonym (
  feature_synonym_id INTEGER PRIMARY KEY NOT NULL,
  synonym_id integer NOT NULL,
  feature_id integer NOT NULL,
  pub_id integer NOT NULL,
  is_current boolean NOT NULL DEFAULT false,
  is_internal boolean NOT NULL DEFAULT false
);
CREATE INDEX feature_synonym_idx_feature_id ON feature_synonym (feature_id);
CREATE INDEX feature_synonym_idx_pub_id ON feature_synonym (pub_id);
CREATE INDEX feature_synonym_idx_synonym_id ON feature_synonym (synonym_id);
CREATE UNIQUE INDEX feature_synonym_c1 ON feature_synonym (synonym_id, feature_id, pub_id);
--
-- Table: feature_union
--
CREATE TABLE feature_union (
  subject_id integer,
  object_id integer,
  srcfeature_id integer,
  subject_strand smallint,
  object_strand smallint,
  fmin integer,
  fmax integer
);
--
-- Table: featureloc
--
CREATE TABLE featureloc (
  featureloc_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer NOT NULL,
  srcfeature_id integer,
  fmin integer,
  is_fmin_partial boolean NOT NULL DEFAULT false,
  fmax integer,
  is_fmax_partial boolean NOT NULL DEFAULT false,
  strand smallint,
  phase integer,
  residue_info text,
  locgroup integer NOT NULL DEFAULT 0,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX featureloc_idx_feature_id ON featureloc (feature_id);
CREATE INDEX featureloc_idx_srcfeature_id ON featureloc (srcfeature_id);
CREATE UNIQUE INDEX featureloc_c1 ON featureloc (feature_id, locgroup, rank);
--
-- Table: featureloc_pub
--
CREATE TABLE featureloc_pub (
  featureloc_pub_id INTEGER PRIMARY KEY NOT NULL,
  featureloc_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX featureloc_pub_idx_featureloc_id ON featureloc_pub (featureloc_id);
CREATE INDEX featureloc_pub_idx_pub_id ON featureloc_pub (pub_id);
CREATE UNIQUE INDEX featureloc_pub_c1 ON featureloc_pub (featureloc_id, pub_id);
--
-- Table: featuremap
--
CREATE TABLE featuremap (
  featuremap_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255),
  description text,
  unittype_id integer
);
CREATE INDEX featuremap_idx_unittype_id ON featuremap (unittype_id);
CREATE UNIQUE INDEX featuremap_c1 ON featuremap (name);
--
-- Table: featuremap_pub
--
CREATE TABLE featuremap_pub (
  featuremap_pub_id INTEGER PRIMARY KEY NOT NULL,
  featuremap_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX featuremap_pub_idx_featuremap_id ON featuremap_pub (featuremap_id);
CREATE INDEX featuremap_pub_idx_pub_id ON featuremap_pub (pub_id);
--
-- Table: featurepos
--
CREATE TABLE featurepos (
  featurepos_id INTEGER PRIMARY KEY NOT NULL,
  featuremap_id integer NOT NULL,
  feature_id integer NOT NULL,
  map_feature_id integer NOT NULL,
  mappos double precision NOT NULL
);
CREATE INDEX featurepos_idx_feature_id ON featurepos (feature_id);
CREATE INDEX featurepos_idx_featuremap_id ON featurepos (featuremap_id);
CREATE INDEX featurepos_idx_map_feature_id ON featurepos (map_feature_id);
--
-- Table: featureprop_pub
--
CREATE TABLE featureprop_pub (
  featureprop_pub_id INTEGER PRIMARY KEY NOT NULL,
  featureprop_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX featureprop_pub_idx_featureprop_id ON featureprop_pub (featureprop_id);
CREATE INDEX featureprop_pub_idx_pub_id ON featureprop_pub (pub_id);
CREATE UNIQUE INDEX featureprop_pub_c1 ON featureprop_pub (featureprop_id, pub_id);
--
-- Table: featurerange
--
CREATE TABLE featurerange (
  featurerange_id INTEGER PRIMARY KEY NOT NULL,
  featuremap_id integer NOT NULL,
  feature_id integer NOT NULL,
  leftstartf_id integer NOT NULL,
  leftendf_id integer,
  rightstartf_id integer,
  rightendf_id integer NOT NULL,
  rangestr varchar(255)
);
CREATE INDEX featurerange_idx_feature_id ON featurerange (feature_id);
CREATE INDEX featurerange_idx_featuremap_id ON featurerange (featuremap_id);
CREATE INDEX featurerange_idx_leftendf_id ON featurerange (leftendf_id);
CREATE INDEX featurerange_idx_leftstartf_id ON featurerange (leftstartf_id);
CREATE INDEX featurerange_idx_rightendf_id ON featurerange (rightendf_id);
CREATE INDEX featurerange_idx_rightstartf_id ON featurerange (rightstartf_id);
--
-- Table: featureset_meets
--
CREATE TABLE featureset_meets (
  subject_id integer,
  object_id integer
);
--
-- Table: fnr_type
--
CREATE TABLE fnr_type (
  feature_id integer,
  name varchar(255),
  dbxref_id integer,
  type varchar(1024),
  residues text,
  seqlen integer,
  md5checksum char(32),
  type_id integer,
  timeaccessioned timestamp,
  timelastmodified timestamp
);
--
-- Table: fp_key
--
CREATE TABLE fp_key (
  feature_id integer,
  pkey varchar(1024),
  value text
);
--
-- Table: genotype
--
CREATE TABLE genotype (
  genotype_id INTEGER PRIMARY KEY NOT NULL,
  name text,
  uniquename text NOT NULL,
  description varchar(255)
);
CREATE UNIQUE INDEX genotype_c1 ON genotype (uniquename);
--
-- Table: genotypeprop
--
CREATE TABLE genotypeprop (
  genotypeprop_id INTEGER PRIMARY KEY NOT NULL,
  genotype_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX genotypeprop_idx_genotype_id ON genotypeprop (genotype_id);
CREATE INDEX genotypeprop_idx_type_id ON genotypeprop (type_id);
CREATE UNIQUE INDEX genotypeprop_c1 ON genotypeprop (genotype_id, type_id, rank);
--
-- Table: gff3atts
--
CREATE TABLE gff3atts (
  feature_id integer,
  type text,
  attribute text
);
--
-- Table: gff3view
--
CREATE TABLE gff3view (
  feature_id integer,
  ref varchar(255),
  source varchar(255),
  type varchar(1024),
  fstart integer,
  fend integer,
  score double precision,
  strand text,
  phase integer,
  seqlen integer,
  name varchar(255),
  organism_id integer
);
--
-- Table: gffatts
--
CREATE TABLE gffatts (
  feature_id integer,
  type text,
  attribute text
);
--
-- Table: intron_combined_view
--
CREATE TABLE intron_combined_view (
  exon1_id integer,
  exon2_id integer,
  fmin integer,
  fmax integer,
  strand smallint,
  srcfeature_id integer,
  intron_rank integer,
  transcript_id integer
);
--
-- Table: intronloc_view
--
CREATE TABLE intronloc_view (
  exon1_id integer,
  exon2_id integer,
  fmin integer,
  fmax integer,
  strand smallint,
  srcfeature_id integer
);
--
-- Table: library
--
CREATE TABLE library (
  library_id INTEGER PRIMARY KEY NOT NULL,
  organism_id integer NOT NULL,
  name varchar(255),
  uniquename text NOT NULL,
  type_id integer NOT NULL,
  is_obsolete integer NOT NULL DEFAULT 0,
  timeaccessioned timestamp NOT NULL DEFAULT current_timestamp,
  timelastmodified timestamp NOT NULL DEFAULT current_timestamp
);
CREATE INDEX library_idx_organism_id ON library (organism_id);
CREATE INDEX library_idx_type_id ON library (type_id);
CREATE UNIQUE INDEX library_c1 ON library (organism_id, uniquename, type_id);
--
-- Table: library_cvterm
--
CREATE TABLE library_cvterm (
  library_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  library_id integer NOT NULL,
  cvterm_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX library_cvterm_idx_cvterm_id ON library_cvterm (cvterm_id);
CREATE INDEX library_cvterm_idx_library_id ON library_cvterm (library_id);
CREATE INDEX library_cvterm_idx_pub_id ON library_cvterm (pub_id);
CREATE UNIQUE INDEX library_cvterm_c1 ON library_cvterm (library_id, cvterm_id, pub_id);
--
-- Table: library_dbxref
--
CREATE TABLE library_dbxref (
  library_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  library_id integer NOT NULL,
  dbxref_id integer NOT NULL,
  is_current boolean NOT NULL DEFAULT true
);
CREATE INDEX library_dbxref_idx_dbxref_id ON library_dbxref (dbxref_id);
CREATE INDEX library_dbxref_idx_library_id ON library_dbxref (library_id);
CREATE UNIQUE INDEX library_dbxref_c1 ON library_dbxref (library_id, dbxref_id);
--
-- Table: library_feature
--
CREATE TABLE library_feature (
  library_feature_id INTEGER PRIMARY KEY NOT NULL,
  library_id integer NOT NULL,
  feature_id integer NOT NULL
);
CREATE INDEX library_feature_idx_feature_id ON library_feature (feature_id);
CREATE INDEX library_feature_idx_library_id ON library_feature (library_id);
CREATE UNIQUE INDEX library_feature_c1 ON library_feature (library_id, feature_id);
--
-- Table: library_pub
--
CREATE TABLE library_pub (
  library_pub_id INTEGER PRIMARY KEY NOT NULL,
  library_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX library_pub_idx_library_id ON library_pub (library_id);
CREATE INDEX library_pub_idx_pub_id ON library_pub (pub_id);
CREATE UNIQUE INDEX library_pub_c1 ON library_pub (library_id, pub_id);
--
-- Table: library_synonym
--
CREATE TABLE library_synonym (
  library_synonym_id INTEGER PRIMARY KEY NOT NULL,
  synonym_id integer NOT NULL,
  library_id integer NOT NULL,
  pub_id integer NOT NULL,
  is_current boolean NOT NULL DEFAULT true,
  is_internal boolean NOT NULL DEFAULT false
);
CREATE INDEX library_synonym_idx_library_id ON library_synonym (library_id);
CREATE INDEX library_synonym_idx_pub_id ON library_synonym (pub_id);
CREATE INDEX library_synonym_idx_synonym_id ON library_synonym (synonym_id);
CREATE UNIQUE INDEX library_synonym_c1 ON library_synonym (synonym_id, library_id, pub_id);
--
-- Table: libraryprop
--
CREATE TABLE libraryprop (
  libraryprop_id INTEGER PRIMARY KEY NOT NULL,
  library_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX libraryprop_idx_library_id ON libraryprop (library_id);
CREATE INDEX libraryprop_idx_type_id ON libraryprop (type_id);
CREATE UNIQUE INDEX libraryprop_c1 ON libraryprop (library_id, type_id, rank);
--
-- Table: libraryprop_pub
--
CREATE TABLE libraryprop_pub (
  libraryprop_pub_id INTEGER PRIMARY KEY NOT NULL,
  libraryprop_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX libraryprop_pub_idx_libraryprop_id ON libraryprop_pub (libraryprop_id);
CREATE INDEX libraryprop_pub_idx_pub_id ON libraryprop_pub (pub_id);
CREATE UNIQUE INDEX libraryprop_pub_c1 ON libraryprop_pub (libraryprop_id, pub_id);
--
-- Table: magedocumentation
--
CREATE TABLE magedocumentation (
  magedocumentation_id INTEGER PRIMARY KEY NOT NULL,
  mageml_id integer NOT NULL,
  tableinfo_id integer NOT NULL,
  row_id integer NOT NULL,
  mageidentifier text NOT NULL
);
CREATE INDEX magedocumentation_idx_mageml_id ON magedocumentation (mageml_id);
CREATE INDEX magedocumentation_idx_tableinfo_id ON magedocumentation (tableinfo_id);
--
-- Table: mageml
--
CREATE TABLE mageml (
  mageml_id INTEGER PRIMARY KEY NOT NULL,
  mage_package text NOT NULL,
  mage_ml text NOT NULL
);
--
-- Table: nd_experiment
--
CREATE TABLE nd_experiment (
  nd_experiment_id INTEGER PRIMARY KEY NOT NULL,
  nd_geolocation_id integer NOT NULL,
  type_id integer NOT NULL
);
CREATE INDEX nd_experiment_idx_nd_geolocation_id ON nd_experiment (nd_geolocation_id);
CREATE INDEX nd_experiment_idx_type_id ON nd_experiment (type_id);
--
-- Table: nd_experiment_contact
--
CREATE TABLE nd_experiment_contact (
  nd_experiment_contact_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_id integer NOT NULL,
  contact_id integer NOT NULL
);
CREATE INDEX nd_experiment_contact_idx_contact_id ON nd_experiment_contact (contact_id);
CREATE INDEX nd_experiment_contact_idx_nd_experiment_id ON nd_experiment_contact (nd_experiment_id);
--
-- Table: nd_experiment_dbxref
--
CREATE TABLE nd_experiment_dbxref (
  nd_experiment_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_id integer NOT NULL,
  dbxref_id integer NOT NULL
);
CREATE INDEX nd_experiment_dbxref_idx_dbxref_id ON nd_experiment_dbxref (dbxref_id);
CREATE INDEX nd_experiment_dbxref_idx_nd_experiment_id ON nd_experiment_dbxref (nd_experiment_id);
--
-- Table: nd_experiment_genotype
--
CREATE TABLE nd_experiment_genotype (
  nd_experiment_genotype_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_id integer NOT NULL,
  genotype_id integer NOT NULL
);
CREATE INDEX nd_experiment_genotype_idx_genotype_id ON nd_experiment_genotype (genotype_id);
CREATE INDEX nd_experiment_genotype_idx_nd_experiment_id ON nd_experiment_genotype (nd_experiment_id);
CREATE UNIQUE INDEX nd_experiment_genotype_c1 ON nd_experiment_genotype (nd_experiment_id, genotype_id);
--
-- Table: nd_experiment_phenotype
--
CREATE TABLE nd_experiment_phenotype (
  nd_experiment_phenotype_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_id integer NOT NULL,
  phenotype_id integer NOT NULL
);
CREATE INDEX nd_experiment_phenotype_idx_nd_experiment_id ON nd_experiment_phenotype (nd_experiment_id);
CREATE INDEX nd_experiment_phenotype_idx_phenotype_id ON nd_experiment_phenotype (phenotype_id);
CREATE UNIQUE INDEX nd_experiment_phenotype_c1 ON nd_experiment_phenotype (nd_experiment_id, phenotype_id);
--
-- Table: nd_experiment_project
--
CREATE TABLE nd_experiment_project (
  nd_experiment_project_id INTEGER PRIMARY KEY NOT NULL,
  project_id integer NOT NULL,
  nd_experiment_id integer NOT NULL
);
CREATE INDEX nd_experiment_project_idx_nd_experiment_id ON nd_experiment_project (nd_experiment_id);
CREATE INDEX nd_experiment_project_idx_project_id ON nd_experiment_project (project_id);
--
-- Table: nd_experiment_protocol
--
CREATE TABLE nd_experiment_protocol (
  nd_experiment_protocol_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_id integer NOT NULL,
  nd_protocol_id integer NOT NULL
);
CREATE INDEX nd_experiment_protocol_idx_nd_experiment_id ON nd_experiment_protocol (nd_experiment_id);
CREATE INDEX nd_experiment_protocol_idx_nd_protocol_id ON nd_experiment_protocol (nd_protocol_id);
--
-- Table: nd_experiment_pub
--
CREATE TABLE nd_experiment_pub (
  nd_experiment_pub_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX nd_experiment_pub_idx_nd_experiment_id ON nd_experiment_pub (nd_experiment_id);
CREATE INDEX nd_experiment_pub_idx_pub_id ON nd_experiment_pub (pub_id);
CREATE UNIQUE INDEX nd_experiment_pub_c1 ON nd_experiment_pub (nd_experiment_id, pub_id);
--
-- Table: nd_experiment_stock
--
CREATE TABLE nd_experiment_stock (
  nd_experiment_stock_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_id integer NOT NULL,
  stock_id integer NOT NULL,
  type_id integer NOT NULL
);
CREATE INDEX nd_experiment_stock_idx_nd_experiment_id ON nd_experiment_stock (nd_experiment_id);
CREATE INDEX nd_experiment_stock_idx_stock_id ON nd_experiment_stock (stock_id);
CREATE INDEX nd_experiment_stock_idx_type_id ON nd_experiment_stock (type_id);
--
-- Table: nd_experiment_stock_dbxref
--
CREATE TABLE nd_experiment_stock_dbxref (
  nd_experiment_stock_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_stock_id integer NOT NULL,
  dbxref_id integer NOT NULL
);
CREATE INDEX nd_experiment_stock_dbxref_idx_dbxref_id ON nd_experiment_stock_dbxref (dbxref_id);
CREATE INDEX nd_experiment_stock_dbxref_idx_nd_experiment_stock_id ON nd_experiment_stock_dbxref (nd_experiment_stock_id);
--
-- Table: nd_experiment_stockprop
--
CREATE TABLE nd_experiment_stockprop (
  nd_experiment_stockprop_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_stock_id integer NOT NULL,
  type_id integer NOT NULL,
  value varchar(255),
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX nd_experiment_stockprop_idx_nd_experiment_stock_id ON nd_experiment_stockprop (nd_experiment_stock_id);
CREATE INDEX nd_experiment_stockprop_idx_type_id ON nd_experiment_stockprop (type_id);
CREATE UNIQUE INDEX nd_experiment_stockprop_c1 ON nd_experiment_stockprop (nd_experiment_stock_id, type_id, rank);
--
-- Table: nd_experimentprop
--
CREATE TABLE nd_experimentprop (
  nd_experimentprop_id INTEGER PRIMARY KEY NOT NULL,
  nd_experiment_id integer NOT NULL,
  type_id integer NOT NULL,
  value varchar(255) NOT NULL,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX nd_experimentprop_idx_nd_experiment_id ON nd_experimentprop (nd_experiment_id);
CREATE INDEX nd_experimentprop_idx_type_id ON nd_experimentprop (type_id);
CREATE UNIQUE INDEX nd_experimentprop_c1 ON nd_experimentprop (nd_experiment_id, type_id, rank);
--
-- Table: nd_geolocation
--
CREATE TABLE nd_geolocation (
  nd_geolocation_id INTEGER PRIMARY KEY NOT NULL,
  description varchar(255),
  latitude real,
  longitude real,
  geodetic_datum varchar(32),
  altitude real
);
--
-- Table: nd_geolocationprop
--
CREATE TABLE nd_geolocationprop (
  nd_geolocationprop_id INTEGER PRIMARY KEY NOT NULL,
  nd_geolocation_id integer NOT NULL,
  type_id integer NOT NULL,
  value varchar(250),
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX nd_geolocationprop_idx_nd_geolocation_id ON nd_geolocationprop (nd_geolocation_id);
CREATE INDEX nd_geolocationprop_idx_type_id ON nd_geolocationprop (type_id);
CREATE UNIQUE INDEX nd_geolocationprop_c1 ON nd_geolocationprop (nd_geolocation_id, type_id, rank);
--
-- Table: nd_protocol
--
CREATE TABLE nd_protocol (
  nd_protocol_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255) NOT NULL
);
CREATE UNIQUE INDEX nd_protocol_name_key ON nd_protocol (name);
--
-- Table: nd_protocol_reagent
--
CREATE TABLE nd_protocol_reagent (
  nd_protocol_reagent_id INTEGER PRIMARY KEY NOT NULL,
  nd_protocol_id integer NOT NULL,
  reagent_id integer NOT NULL,
  type_id integer NOT NULL
);
CREATE INDEX nd_protocol_reagent_idx_nd_protocol_id ON nd_protocol_reagent (nd_protocol_id);
CREATE INDEX nd_protocol_reagent_idx_reagent_id ON nd_protocol_reagent (reagent_id);
CREATE INDEX nd_protocol_reagent_idx_type_id ON nd_protocol_reagent (type_id);
--
-- Table: nd_protocolprop
--
CREATE TABLE nd_protocolprop (
  nd_protocolprop_id INTEGER PRIMARY KEY NOT NULL,
  nd_protocol_id integer NOT NULL,
  type_id integer NOT NULL,
  value varchar(255),
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX nd_protocolprop_idx_nd_protocol_id ON nd_protocolprop (nd_protocol_id);
CREATE INDEX nd_protocolprop_idx_type_id ON nd_protocolprop (type_id);
CREATE UNIQUE INDEX nd_protocolprop_c1 ON nd_protocolprop (nd_protocol_id, type_id, rank);
--
-- Table: nd_reagent
--
CREATE TABLE nd_reagent (
  nd_reagent_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(80) NOT NULL,
  type_id integer NOT NULL,
  feature_id integer
);
CREATE INDEX nd_reagent_idx_type_id ON nd_reagent (type_id);
--
-- Table: nd_reagent_relationship
--
CREATE TABLE nd_reagent_relationship (
  nd_reagent_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_reagent_id integer NOT NULL,
  object_reagent_id integer NOT NULL,
  type_id integer NOT NULL
);
CREATE INDEX nd_reagent_relationship_idx_object_reagent_id ON nd_reagent_relationship (object_reagent_id);
CREATE INDEX nd_reagent_relationship_idx_subject_reagent_id ON nd_reagent_relationship (subject_reagent_id);
CREATE INDEX nd_reagent_relationship_idx_type_id ON nd_reagent_relationship (type_id);
--
-- Table: nd_reagentprop
--
CREATE TABLE nd_reagentprop (
  nd_reagentprop_id INTEGER PRIMARY KEY NOT NULL,
  nd_reagent_id integer NOT NULL,
  type_id integer NOT NULL,
  value varchar(255),
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX nd_reagentprop_idx_nd_reagent_id ON nd_reagentprop (nd_reagent_id);
CREATE INDEX nd_reagentprop_idx_type_id ON nd_reagentprop (type_id);
CREATE UNIQUE INDEX nd_reagentprop_c1 ON nd_reagentprop (nd_reagent_id, type_id, rank);
--
-- Table: organism
--
CREATE TABLE organism (
  organism_id INTEGER PRIMARY KEY NOT NULL,
  abbreviation varchar(255),
  genus varchar(255) NOT NULL,
  species varchar(255) NOT NULL,
  common_name varchar(255),
  comment text
);
CREATE UNIQUE INDEX organism_c1 ON organism (genus, species);
--
-- Table: organism_dbxref
--
CREATE TABLE organism_dbxref (
  organism_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  organism_id integer NOT NULL,
  dbxref_id integer NOT NULL
);
CREATE INDEX organism_dbxref_idx_dbxref_id ON organism_dbxref (dbxref_id);
CREATE INDEX organism_dbxref_idx_organism_id ON organism_dbxref (organism_id);
CREATE UNIQUE INDEX organism_dbxref_c1 ON organism_dbxref (organism_id, dbxref_id);
--
-- Table: organismprop
--
CREATE TABLE organismprop (
  organismprop_id INTEGER PRIMARY KEY NOT NULL,
  organism_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX organismprop_idx_organism_id ON organismprop (organism_id);
CREATE INDEX organismprop_idx_type_id ON organismprop (type_id);
CREATE UNIQUE INDEX organismprop_c1 ON organismprop (organism_id, type_id, rank);
--
-- Table: phendesc
--
CREATE TABLE phendesc (
  phendesc_id INTEGER PRIMARY KEY NOT NULL,
  genotype_id integer NOT NULL,
  environment_id integer NOT NULL,
  description text NOT NULL,
  type_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX phendesc_idx_environment_id ON phendesc (environment_id);
CREATE INDEX phendesc_idx_genotype_id ON phendesc (genotype_id);
CREATE INDEX phendesc_idx_pub_id ON phendesc (pub_id);
CREATE INDEX phendesc_idx_type_id ON phendesc (type_id);
CREATE UNIQUE INDEX phendesc_c1 ON phendesc (genotype_id, environment_id, type_id, pub_id);
--
-- Table: phenotype
--
CREATE TABLE phenotype (
  phenotype_id INTEGER PRIMARY KEY NOT NULL,
  uniquename text NOT NULL,
  observable_id integer,
  attr_id integer,
  value text,
  cvalue_id integer,
  assay_id integer
);
CREATE INDEX phenotype_idx_assay_id ON phenotype (assay_id);
CREATE INDEX phenotype_idx_attr_id ON phenotype (attr_id);
CREATE INDEX phenotype_idx_cvalue_id ON phenotype (cvalue_id);
CREATE INDEX phenotype_idx_observable_id ON phenotype (observable_id);
CREATE UNIQUE INDEX phenotype_c1 ON phenotype (uniquename);
--
-- Table: phenotype_comparison
--
CREATE TABLE phenotype_comparison (
  phenotype_comparison_id INTEGER PRIMARY KEY NOT NULL,
  genotype1_id integer NOT NULL,
  environment1_id integer NOT NULL,
  genotype2_id integer NOT NULL,
  environment2_id integer NOT NULL,
  phenotype1_id integer NOT NULL,
  phenotype2_id integer,
  pub_id integer NOT NULL,
  organism_id integer NOT NULL
);
CREATE INDEX phenotype_comparison_idx_environment1_id ON phenotype_comparison (environment1_id);
CREATE INDEX phenotype_comparison_idx_environment2_id ON phenotype_comparison (environment2_id);
CREATE INDEX phenotype_comparison_idx_genotype1_id ON phenotype_comparison (genotype1_id);
CREATE INDEX phenotype_comparison_idx_genotype2_id ON phenotype_comparison (genotype2_id);
CREATE INDEX phenotype_comparison_idx_organism_id ON phenotype_comparison (organism_id);
CREATE INDEX phenotype_comparison_idx_phenotype1_id ON phenotype_comparison (phenotype1_id);
CREATE INDEX phenotype_comparison_idx_phenotype2_id ON phenotype_comparison (phenotype2_id);
CREATE INDEX phenotype_comparison_idx_pub_id ON phenotype_comparison (pub_id);
CREATE UNIQUE INDEX phenotype_comparison_c1 ON phenotype_comparison (genotype1_id, environment1_id, genotype2_id, environment2_id, phenotype1_id, pub_id);
--
-- Table: phenotype_comparison_cvterm
--
CREATE TABLE phenotype_comparison_cvterm (
  phenotype_comparison_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  phenotype_comparison_id integer NOT NULL,
  cvterm_id integer NOT NULL,
  pub_id integer NOT NULL,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX phenotype_comparison_cvterm_idx_cvterm_id ON phenotype_comparison_cvterm (cvterm_id);
CREATE INDEX phenotype_comparison_cvterm_idx_phenotype_comparison_id ON phenotype_comparison_cvterm (phenotype_comparison_id);
CREATE INDEX phenotype_comparison_cvterm_idx_pub_id ON phenotype_comparison_cvterm (pub_id);
CREATE UNIQUE INDEX phenotype_comparison_cvterm_c1 ON phenotype_comparison_cvterm (phenotype_comparison_id, cvterm_id);
--
-- Table: phenotype_cvterm
--
CREATE TABLE phenotype_cvterm (
  phenotype_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  phenotype_id integer NOT NULL,
  cvterm_id integer NOT NULL,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX phenotype_cvterm_idx_cvterm_id ON phenotype_cvterm (cvterm_id);
CREATE INDEX phenotype_cvterm_idx_phenotype_id ON phenotype_cvterm (phenotype_id);
CREATE UNIQUE INDEX phenotype_cvterm_c1 ON phenotype_cvterm (phenotype_id, cvterm_id, rank);
--
-- Table: phenstatement
--
CREATE TABLE phenstatement (
  phenstatement_id INTEGER PRIMARY KEY NOT NULL,
  genotype_id integer NOT NULL,
  environment_id integer NOT NULL,
  phenotype_id integer NOT NULL,
  type_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX phenstatement_idx_environment_id ON phenstatement (environment_id);
CREATE INDEX phenstatement_idx_genotype_id ON phenstatement (genotype_id);
CREATE INDEX phenstatement_idx_phenotype_id ON phenstatement (phenotype_id);
CREATE INDEX phenstatement_idx_pub_id ON phenstatement (pub_id);
CREATE INDEX phenstatement_idx_type_id ON phenstatement (type_id);
CREATE UNIQUE INDEX phenstatement_c1 ON phenstatement (genotype_id, phenotype_id, environment_id, type_id, pub_id);
--
-- Table: phylonode
--
CREATE TABLE phylonode (
  phylonode_id INTEGER PRIMARY KEY NOT NULL,
  phylotree_id integer NOT NULL,
  parent_phylonode_id integer,
  left_idx integer NOT NULL,
  right_idx integer NOT NULL,
  type_id integer,
  feature_id integer,
  label varchar(255),
  distance double precision
);
CREATE INDEX phylonode_idx_feature_id ON phylonode (feature_id);
CREATE INDEX phylonode_idx_phylotree_id ON phylonode (phylotree_id);
CREATE INDEX phylonode_idx_parent_phylonode_id ON phylonode (parent_phylonode_id);
CREATE INDEX phylonode_idx_type_id ON phylonode (type_id);
CREATE UNIQUE INDEX phylonode_phylotree_id_key ON phylonode (phylotree_id, left_idx);
CREATE UNIQUE INDEX phylonode_phylotree_id_key1 ON phylonode (phylotree_id, right_idx);
--
-- Table: phylonode_dbxref
--
CREATE TABLE phylonode_dbxref (
  phylonode_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  phylonode_id integer NOT NULL,
  dbxref_id integer NOT NULL
);
CREATE INDEX phylonode_dbxref_idx_dbxref_id ON phylonode_dbxref (dbxref_id);
CREATE INDEX phylonode_dbxref_idx_phylonode_id ON phylonode_dbxref (phylonode_id);
CREATE UNIQUE INDEX phylonode_dbxref_phylonode_id_key ON phylonode_dbxref (phylonode_id, dbxref_id);
--
-- Table: phylonode_organism
--
CREATE TABLE phylonode_organism (
  phylonode_organism_id INTEGER PRIMARY KEY NOT NULL,
  phylonode_id integer NOT NULL,
  organism_id integer NOT NULL
);
CREATE INDEX phylonode_organism_idx_organism_id ON phylonode_organism (organism_id);
CREATE INDEX phylonode_organism_idx_phylonode_id ON phylonode_organism (phylonode_id);
CREATE UNIQUE INDEX phylonode_organism_phylonode_id_key ON phylonode_organism (phylonode_id);
--
-- Table: phylonode_pub
--
CREATE TABLE phylonode_pub (
  phylonode_pub_id INTEGER PRIMARY KEY NOT NULL,
  phylonode_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX phylonode_pub_idx_phylonode_id ON phylonode_pub (phylonode_id);
CREATE INDEX phylonode_pub_idx_pub_id ON phylonode_pub (pub_id);
CREATE UNIQUE INDEX phylonode_pub_phylonode_id_key ON phylonode_pub (phylonode_id, pub_id);
--
-- Table: phylonode_relationship
--
CREATE TABLE phylonode_relationship (
  phylonode_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  object_id integer NOT NULL,
  type_id integer NOT NULL,
  rank integer,
  phylotree_id integer NOT NULL
);
CREATE INDEX phylonode_relationship_idx_object_id ON phylonode_relationship (object_id);
CREATE INDEX phylonode_relationship_idx_phylotree_id ON phylonode_relationship (phylotree_id);
CREATE INDEX phylonode_relationship_idx_subject_id ON phylonode_relationship (subject_id);
CREATE INDEX phylonode_relationship_idx_type_id ON phylonode_relationship (type_id);
CREATE UNIQUE INDEX phylonode_relationship_subject_id_key ON phylonode_relationship (subject_id, object_id, type_id);
--
-- Table: phylonodeprop
--
CREATE TABLE phylonodeprop (
  phylonodeprop_id INTEGER PRIMARY KEY NOT NULL,
  phylonode_id integer NOT NULL,
  type_id integer NOT NULL,
  value text NOT NULL DEFAULT '',
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX phylonodeprop_idx_phylonode_id ON phylonodeprop (phylonode_id);
CREATE INDEX phylonodeprop_idx_type_id ON phylonodeprop (type_id);
CREATE UNIQUE INDEX phylonodeprop_phylonode_id_key ON phylonodeprop (phylonode_id, type_id, value, rank);
--
-- Table: phylotree
--
CREATE TABLE phylotree (
  phylotree_id INTEGER PRIMARY KEY NOT NULL,
  dbxref_id integer NOT NULL,
  name varchar(255),
  type_id integer,
  analysis_id integer,
  comment text
);
CREATE INDEX phylotree_idx_analysis_id ON phylotree (analysis_id);
CREATE INDEX phylotree_idx_dbxref_id ON phylotree (dbxref_id);
CREATE INDEX phylotree_idx_type_id ON phylotree (type_id);
--
-- Table: phylotree_pub
--
CREATE TABLE phylotree_pub (
  phylotree_pub_id INTEGER PRIMARY KEY NOT NULL,
  phylotree_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX phylotree_pub_idx_phylotree_id ON phylotree_pub (phylotree_id);
CREATE INDEX phylotree_pub_idx_pub_id ON phylotree_pub (pub_id);
CREATE UNIQUE INDEX phylotree_pub_phylotree_id_key ON phylotree_pub (phylotree_id, pub_id);
--
-- Table: project
--
CREATE TABLE project (
  project_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(255) NOT NULL
);
CREATE UNIQUE INDEX project_c1 ON project (name);
--
-- Table: project_contact
--
CREATE TABLE project_contact (
  project_contact_id INTEGER PRIMARY KEY NOT NULL,
  project_id integer NOT NULL,
  contact_id integer NOT NULL
);
CREATE INDEX project_contact_idx_contact_id ON project_contact (contact_id);
CREATE INDEX project_contact_idx_project_id ON project_contact (project_id);
CREATE UNIQUE INDEX project_contact_c1 ON project_contact (project_id, contact_id);
--
-- Table: project_pub
--
CREATE TABLE project_pub (
  project_pub_id INTEGER PRIMARY KEY NOT NULL,
  project_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX project_pub_idx_project_id ON project_pub (project_id);
CREATE INDEX project_pub_idx_pub_id ON project_pub (pub_id);
CREATE UNIQUE INDEX project_pub_c1 ON project_pub (project_id, pub_id);
--
-- Table: project_relationship
--
CREATE TABLE project_relationship (
  project_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_project_id integer NOT NULL,
  object_project_id integer NOT NULL,
  type_id integer NOT NULL
);
CREATE INDEX project_relationship_idx_object_project_id ON project_relationship (object_project_id);
CREATE INDEX project_relationship_idx_subject_project_id ON project_relationship (subject_project_id);
CREATE INDEX project_relationship_idx_type_id ON project_relationship (type_id);
CREATE UNIQUE INDEX project_relationship_c1 ON project_relationship (subject_project_id, object_project_id, type_id);
--
-- Table: projectprop
--
CREATE TABLE projectprop (
  projectprop_id INTEGER PRIMARY KEY NOT NULL,
  project_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX projectprop_idx_project_id ON projectprop (project_id);
CREATE INDEX projectprop_idx_type_id ON projectprop (type_id);
CREATE UNIQUE INDEX projectprop_c1 ON projectprop (project_id, type_id, rank);
--
-- Table: protein_coding_gene
--
CREATE TABLE protein_coding_gene (
  feature_id integer,
  dbxref_id integer,
  organism_id integer,
  name varchar(255),
  uniquename text,
  residues text,
  seqlen integer,
  md5checksum char(32),
  type_id integer,
  is_analysis boolean,
  is_obsolete boolean,
  timeaccessioned timestamp,
  timelastmodified timestamp
);
--
-- Table: protocol
--
CREATE TABLE protocol (
  protocol_id INTEGER PRIMARY KEY NOT NULL,
  type_id integer NOT NULL,
  pub_id integer,
  dbxref_id integer,
  name text NOT NULL,
  uri text,
  protocoldescription text,
  hardwaredescription text,
  softwaredescription text
);
CREATE INDEX protocol_idx_dbxref_id ON protocol (dbxref_id);
CREATE INDEX protocol_idx_pub_id ON protocol (pub_id);
CREATE INDEX protocol_idx_type_id ON protocol (type_id);
CREATE UNIQUE INDEX protocol_c1 ON protocol (name);
--
-- Table: protocolparam
--
CREATE TABLE protocolparam (
  protocolparam_id INTEGER PRIMARY KEY NOT NULL,
  protocol_id integer NOT NULL,
  name text NOT NULL,
  datatype_id integer,
  unittype_id integer,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX protocolparam_idx_datatype_id ON protocolparam (datatype_id);
CREATE INDEX protocolparam_idx_protocol_id ON protocolparam (protocol_id);
CREATE INDEX protocolparam_idx_unittype_id ON protocolparam (unittype_id);
--
-- Table: pub
--
CREATE TABLE pub (
  pub_id INTEGER PRIMARY KEY NOT NULL,
  title text,
  volumetitle text,
  volume varchar(255),
  series_name varchar(255),
  issue varchar(255),
  pyear varchar(255),
  pages varchar(255),
  miniref varchar(255),
  uniquename text NOT NULL,
  type_id integer NOT NULL,
  is_obsolete boolean DEFAULT false,
  publisher varchar(255),
  pubplace varchar(255)
);
CREATE INDEX pub_idx_type_id ON pub (type_id);
CREATE UNIQUE INDEX pub_c1 ON pub (uniquename);
--
-- Table: pub_dbxref
--
CREATE TABLE pub_dbxref (
  pub_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  pub_id integer NOT NULL,
  dbxref_id integer NOT NULL,
  is_current boolean NOT NULL DEFAULT true
);
CREATE INDEX pub_dbxref_idx_dbxref_id ON pub_dbxref (dbxref_id);
CREATE INDEX pub_dbxref_idx_pub_id ON pub_dbxref (pub_id);
CREATE UNIQUE INDEX pub_dbxref_c1 ON pub_dbxref (pub_id, dbxref_id);
--
-- Table: pub_relationship
--
CREATE TABLE pub_relationship (
  pub_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  object_id integer NOT NULL,
  type_id integer NOT NULL
);
CREATE INDEX pub_relationship_idx_object_id ON pub_relationship (object_id);
CREATE INDEX pub_relationship_idx_subject_id ON pub_relationship (subject_id);
CREATE INDEX pub_relationship_idx_type_id ON pub_relationship (type_id);
CREATE UNIQUE INDEX pub_relationship_c1 ON pub_relationship (subject_id, object_id, type_id);
--
-- Table: pubauthor
--
CREATE TABLE pubauthor (
  pubauthor_id INTEGER PRIMARY KEY NOT NULL,
  pub_id integer NOT NULL,
  rank integer NOT NULL,
  editor boolean DEFAULT false,
  surname varchar(100) NOT NULL,
  givennames varchar(100),
  suffix varchar(100)
);
CREATE INDEX pubauthor_idx_pub_id ON pubauthor (pub_id);
CREATE UNIQUE INDEX pubauthor_c1 ON pubauthor (pub_id, rank);
--
-- Table: pubprop
--
CREATE TABLE pubprop (
  pubprop_id INTEGER PRIMARY KEY NOT NULL,
  pub_id integer NOT NULL,
  type_id integer NOT NULL,
  value text NOT NULL,
  rank integer
);
CREATE INDEX pubprop_idx_pub_id ON pubprop (pub_id);
CREATE INDEX pubprop_idx_type_id ON pubprop (type_id);
CREATE UNIQUE INDEX pubprop_c1 ON pubprop (pub_id, type_id, rank);
--
-- Table: quantification
--
CREATE TABLE quantification (
  quantification_id INTEGER PRIMARY KEY NOT NULL,
  acquisition_id integer NOT NULL,
  operator_id integer,
  protocol_id integer,
  analysis_id integer NOT NULL,
  quantificationdate timestamp DEFAULT current_timestamp,
  name text,
  uri text
);
CREATE INDEX quantification_idx_acquisition_id ON quantification (acquisition_id);
CREATE INDEX quantification_idx_analysis_id ON quantification (analysis_id);
CREATE INDEX quantification_idx_operator_id ON quantification (operator_id);
CREATE INDEX quantification_idx_protocol_id ON quantification (protocol_id);
CREATE UNIQUE INDEX quantification_c1 ON quantification (name, analysis_id);
--
-- Table: quantification_relationship
--
CREATE TABLE quantification_relationship (
  quantification_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  type_id integer NOT NULL,
  object_id integer NOT NULL
);
CREATE INDEX quantification_relationship_idx_object_id ON quantification_relationship (object_id);
CREATE INDEX quantification_relationship_idx_subject_id ON quantification_relationship (subject_id);
CREATE INDEX quantification_relationship_idx_type_id ON quantification_relationship (type_id);
CREATE UNIQUE INDEX quantification_relationship_c1 ON quantification_relationship (subject_id, object_id, type_id);
--
-- Table: quantificationprop
--
CREATE TABLE quantificationprop (
  quantificationprop_id INTEGER PRIMARY KEY NOT NULL,
  quantification_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX quantificationprop_idx_quantification_id ON quantificationprop (quantification_id);
CREATE INDEX quantificationprop_idx_type_id ON quantificationprop (type_id);
CREATE UNIQUE INDEX quantificationprop_c1 ON quantificationprop (quantification_id, type_id, rank);
--
-- Table: stats_paths_to_root
--
CREATE TABLE stats_paths_to_root (
  cvterm_id integer,
  total_paths bigint,
  avg_distance numeric,
  min_distance integer,
  max_distance integer
);
--
-- Table: stock
--
CREATE TABLE stock (
  stock_id INTEGER PRIMARY KEY NOT NULL,
  dbxref_id integer,
  organism_id integer,
  name varchar(255),
  uniquename text NOT NULL,
  description text,
  type_id integer NOT NULL,
  is_obsolete boolean NOT NULL DEFAULT false
);
CREATE INDEX stock_idx_dbxref_id ON stock (dbxref_id);
CREATE INDEX stock_idx_organism_id ON stock (organism_id);
CREATE INDEX stock_idx_type_id ON stock (type_id);
CREATE UNIQUE INDEX stock_c1 ON stock (organism_id, uniquename, type_id);
--
-- Table: stock_cvterm
--
CREATE TABLE stock_cvterm (
  stock_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  stock_id integer NOT NULL,
  cvterm_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX stock_cvterm_idx_cvterm_id ON stock_cvterm (cvterm_id);
CREATE INDEX stock_cvterm_idx_pub_id ON stock_cvterm (pub_id);
CREATE INDEX stock_cvterm_idx_stock_id ON stock_cvterm (stock_id);
CREATE UNIQUE INDEX stock_cvterm_c1 ON stock_cvterm (stock_id, cvterm_id, pub_id);
--
-- Table: stock_cvtermprop
--
CREATE TABLE stock_cvtermprop (
  stock_cvtermprop_id INTEGER PRIMARY KEY NOT NULL,
  stock_cvterm_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX stock_cvtermprop_idx_stock_cvterm_id ON stock_cvtermprop (stock_cvterm_id);
CREATE INDEX stock_cvtermprop_idx_type_id ON stock_cvtermprop (type_id);
CREATE UNIQUE INDEX stock_cvtermprop_c1 ON stock_cvtermprop (stock_cvterm_id, type_id, rank);
--
-- Table: stock_dbxref
--
CREATE TABLE stock_dbxref (
  stock_dbxref_id INTEGER PRIMARY KEY NOT NULL,
  stock_id integer NOT NULL,
  dbxref_id integer NOT NULL,
  is_current boolean NOT NULL DEFAULT true
);
CREATE INDEX stock_dbxref_idx_dbxref_id ON stock_dbxref (dbxref_id);
CREATE INDEX stock_dbxref_idx_stock_id ON stock_dbxref (stock_id);
CREATE UNIQUE INDEX stock_dbxref_c1 ON stock_dbxref (stock_id, dbxref_id);
--
-- Table: stock_dbxrefprop
--
CREATE TABLE stock_dbxrefprop (
  stock_dbxrefprop_id INTEGER PRIMARY KEY NOT NULL,
  stock_dbxref_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX stock_dbxrefprop_idx_stock_dbxref_id ON stock_dbxrefprop (stock_dbxref_id);
CREATE INDEX stock_dbxrefprop_idx_type_id ON stock_dbxrefprop (type_id);
CREATE UNIQUE INDEX stock_dbxrefprop_c1 ON stock_dbxrefprop (stock_dbxref_id, type_id, rank);
--
-- Table: stock_genotype
--
CREATE TABLE stock_genotype (
  stock_genotype_id INTEGER PRIMARY KEY NOT NULL,
  stock_id integer NOT NULL,
  genotype_id integer NOT NULL
);
CREATE INDEX stock_genotype_idx_genotype_id ON stock_genotype (genotype_id);
CREATE INDEX stock_genotype_idx_stock_id ON stock_genotype (stock_id);
CREATE UNIQUE INDEX stock_genotype_c1 ON stock_genotype (stock_id, genotype_id);
--
-- Table: stock_pub
--
CREATE TABLE stock_pub (
  stock_pub_id INTEGER PRIMARY KEY NOT NULL,
  stock_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX stock_pub_idx_pub_id ON stock_pub (pub_id);
CREATE INDEX stock_pub_idx_stock_id ON stock_pub (stock_id);
CREATE UNIQUE INDEX stock_pub_c1 ON stock_pub (stock_id, pub_id);
--
-- Table: stock_relationship
--
CREATE TABLE stock_relationship (
  stock_relationship_id INTEGER PRIMARY KEY NOT NULL,
  subject_id integer NOT NULL,
  object_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX stock_relationship_idx_object_id ON stock_relationship (object_id);
CREATE INDEX stock_relationship_idx_subject_id ON stock_relationship (subject_id);
CREATE INDEX stock_relationship_idx_type_id ON stock_relationship (type_id);
CREATE UNIQUE INDEX stock_relationship_c1 ON stock_relationship (subject_id, object_id, type_id, rank);
--
-- Table: stock_relationship_cvterm
--
CREATE TABLE stock_relationship_cvterm (
  stock_relationship_cvterm_id INTEGER PRIMARY KEY NOT NULL,
  stock_relatiohship_id integer NOT NULL,
  cvterm_id integer NOT NULL,
  pub_id integer
);
CREATE INDEX stock_relationship_cvterm_idx_cvterm_id ON stock_relationship_cvterm (cvterm_id);
CREATE INDEX stock_relationship_cvterm_idx_pub_id ON stock_relationship_cvterm (pub_id);
--
-- Table: stock_relationship_pub
--
CREATE TABLE stock_relationship_pub (
  stock_relationship_pub_id INTEGER PRIMARY KEY NOT NULL,
  stock_relationship_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX stock_relationship_pub_idx_pub_id ON stock_relationship_pub (pub_id);
CREATE INDEX stock_relationship_pub_idx_stock_relationship_id ON stock_relationship_pub (stock_relationship_id);
CREATE UNIQUE INDEX stock_relationship_pub_c1 ON stock_relationship_pub (stock_relationship_id, pub_id);
--
-- Table: stockcollection
--
CREATE TABLE stockcollection (
  stockcollection_id INTEGER PRIMARY KEY NOT NULL,
  type_id integer NOT NULL,
  contact_id integer,
  name varchar(255),
  uniquename text NOT NULL
);
CREATE INDEX stockcollection_idx_contact_id ON stockcollection (contact_id);
CREATE INDEX stockcollection_idx_type_id ON stockcollection (type_id);
CREATE UNIQUE INDEX stockcollection_c1 ON stockcollection (uniquename, type_id);
--
-- Table: stockcollection_stock
--
CREATE TABLE stockcollection_stock (
  stockcollection_stock_id INTEGER PRIMARY KEY NOT NULL,
  stockcollection_id integer NOT NULL,
  stock_id integer NOT NULL
);
CREATE INDEX stockcollection_stock_idx_stock_id ON stockcollection_stock (stock_id);
CREATE INDEX stockcollection_stock_idx_stockcollection_id ON stockcollection_stock (stockcollection_id);
CREATE UNIQUE INDEX stockcollection_stock_c1 ON stockcollection_stock (stockcollection_id, stock_id);
--
-- Table: stockcollectionprop
--
CREATE TABLE stockcollectionprop (
  stockcollectionprop_id INTEGER PRIMARY KEY NOT NULL,
  stockcollection_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX stockcollectionprop_idx_stockcollection_id ON stockcollectionprop (stockcollection_id);
CREATE INDEX stockcollectionprop_idx_type_id ON stockcollectionprop (type_id);
CREATE UNIQUE INDEX stockcollectionprop_c1 ON stockcollectionprop (stockcollection_id, type_id, rank);
--
-- Table: stockprop
--
CREATE TABLE stockprop (
  stockprop_id INTEGER PRIMARY KEY NOT NULL,
  stock_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX stockprop_idx_stock_id ON stockprop (stock_id);
CREATE INDEX stockprop_idx_type_id ON stockprop (type_id);
CREATE UNIQUE INDEX stockprop_c1 ON stockprop (stock_id, type_id, rank);
--
-- Table: stockprop_pub
--
CREATE TABLE stockprop_pub (
  stockprop_pub_id INTEGER PRIMARY KEY NOT NULL,
  stockprop_id integer NOT NULL,
  pub_id integer NOT NULL
);
CREATE INDEX stockprop_pub_idx_pub_id ON stockprop_pub (pub_id);
CREATE INDEX stockprop_pub_idx_stockprop_id ON stockprop_pub (stockprop_id);
CREATE UNIQUE INDEX stockprop_pub_c1 ON stockprop_pub (stockprop_id, pub_id);
--
-- Table: study
--
CREATE TABLE study (
  study_id INTEGER PRIMARY KEY NOT NULL,
  contact_id integer NOT NULL,
  pub_id integer,
  dbxref_id integer,
  name text NOT NULL,
  description text
);
CREATE INDEX study_idx_contact_id ON study (contact_id);
CREATE INDEX study_idx_dbxref_id ON study (dbxref_id);
CREATE INDEX study_idx_pub_id ON study (pub_id);
CREATE UNIQUE INDEX study_c1 ON study (name);
--
-- Table: study_assay
--
CREATE TABLE study_assay (
  study_assay_id INTEGER PRIMARY KEY NOT NULL,
  study_id integer NOT NULL,
  assay_id integer NOT NULL
);
CREATE INDEX study_assay_idx_assay_id ON study_assay (assay_id);
CREATE INDEX study_assay_idx_study_id ON study_assay (study_id);
CREATE UNIQUE INDEX study_assay_c1 ON study_assay (study_id, assay_id);
--
-- Table: studydesign
--
CREATE TABLE studydesign (
  studydesign_id INTEGER PRIMARY KEY NOT NULL,
  study_id integer NOT NULL,
  description text
);
CREATE INDEX studydesign_idx_study_id ON studydesign (study_id);
--
-- Table: studydesignprop
--
CREATE TABLE studydesignprop (
  studydesignprop_id INTEGER PRIMARY KEY NOT NULL,
  studydesign_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX studydesignprop_idx_studydesign_id ON studydesignprop (studydesign_id);
CREATE INDEX studydesignprop_idx_type_id ON studydesignprop (type_id);
CREATE UNIQUE INDEX studydesignprop_c1 ON studydesignprop (studydesign_id, type_id, rank);
--
-- Table: studyfactor
--
CREATE TABLE studyfactor (
  studyfactor_id INTEGER PRIMARY KEY NOT NULL,
  studydesign_id integer NOT NULL,
  type_id integer,
  name text NOT NULL,
  description text
);
CREATE INDEX studyfactor_idx_studydesign_id ON studyfactor (studydesign_id);
CREATE INDEX studyfactor_idx_type_id ON studyfactor (type_id);
--
-- Table: studyfactorvalue
--
CREATE TABLE studyfactorvalue (
  studyfactorvalue_id INTEGER PRIMARY KEY NOT NULL,
  studyfactor_id integer NOT NULL,
  assay_id integer NOT NULL,
  factorvalue text,
  name text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX studyfactorvalue_idx_assay_id ON studyfactorvalue (assay_id);
CREATE INDEX studyfactorvalue_idx_studyfactor_id ON studyfactorvalue (studyfactor_id);
--
-- Table: studyprop
--
CREATE TABLE studyprop (
  studyprop_id INTEGER PRIMARY KEY NOT NULL,
  study_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX studyprop_idx_study_id ON studyprop (study_id);
CREATE INDEX studyprop_idx_type_id ON studyprop (type_id);
CREATE UNIQUE INDEX studyprop_study_id_key ON studyprop (study_id, type_id, rank);
--
-- Table: studyprop_feature
--
CREATE TABLE studyprop_feature (
  studyprop_feature_id INTEGER PRIMARY KEY NOT NULL,
  studyprop_id integer NOT NULL,
  feature_id integer NOT NULL,
  type_id integer
);
CREATE INDEX studyprop_feature_idx_feature_id ON studyprop_feature (feature_id);
CREATE INDEX studyprop_feature_idx_studyprop_id ON studyprop_feature (studyprop_id);
CREATE INDEX studyprop_feature_idx_type_id ON studyprop_feature (type_id);
CREATE UNIQUE INDEX studyprop_feature_studyprop_id_key ON studyprop_feature (studyprop_id, feature_id);
--
-- Table: synonym
--
CREATE TABLE synonym (
  synonym_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255) NOT NULL,
  type_id integer NOT NULL,
  synonym_sgml varchar(255) NOT NULL
);
CREATE INDEX synonym_idx_type_id ON synonym (type_id);
CREATE UNIQUE INDEX synonym_c1 ON synonym (name, type_id);
--
-- Table: tableinfo
--
CREATE TABLE tableinfo (
  tableinfo_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(30) NOT NULL,
  primary_key_column varchar(30),
  is_view integer NOT NULL DEFAULT 0,
  view_on_table_id integer,
  superclass_table_id integer,
  is_updateable integer NOT NULL DEFAULT 1,
  modification_date date NOT NULL DEFAULT current_timestamp
);
CREATE UNIQUE INDEX tableinfo_c1 ON tableinfo (name);
--
-- Table: treatment
--
CREATE TABLE treatment (
  treatment_id INTEGER PRIMARY KEY NOT NULL,
  rank integer NOT NULL DEFAULT 0,
  biomaterial_id integer NOT NULL,
  type_id integer NOT NULL,
  protocol_id integer,
  name text
);
CREATE INDEX treatment_idx_biomaterial_id ON treatment (biomaterial_id);
CREATE INDEX treatment_idx_protocol_id ON treatment (protocol_id);
CREATE INDEX treatment_idx_type_id ON treatment (type_id);
--
-- Table: type_feature_count
--
CREATE TABLE type_feature_count (
  type varchar(1024),
  num_features bigint
);
--
-- Table: featureprop
--
CREATE TABLE featureprop (
  featureprop_id INTEGER PRIMARY KEY NOT NULL,
  feature_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);
CREATE INDEX featureprop_idx_type_id ON featureprop (type_id);
CREATE INDEX featureprop_idx_feature_id ON featureprop (feature_id);
CREATE UNIQUE INDEX featureprop_c1 ON featureprop (feature_id, type_id, rank);
COMMIT