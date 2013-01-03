-- 
-- Created by SQL::Translator::Producer::Oracle
-- Created on Wed Jan  2 13:53:04 2013
-- 
;
--
-- Table: acquisition
--;
CREATE SEQUENCE "sq_acquisition_acquisition_id";
CREATE TABLE "acquisition" (
  "acquisition_id" number NOT NULL,
  "assay_id" number NOT NULL,
  "protocol_id" number,
  "channel_id" number,
  "acquisitiondate" date DEFAULT current_timestamp,
  "name" varchar2(4000),
  "uri" clob,
  PRIMARY KEY ("acquisition_id"),
  CONSTRAINT "acquisition_c1" UNIQUE ("name")
);
--
-- Table: acquisition_relationship
--;
CREATE SEQUENCE "sq_acquisition_relationship_ac";
CREATE TABLE "acquisition_relationship" (
  "acquisition_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "type_id" number NOT NULL,
  "object_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("acquisition_relationship_id"),
  CONSTRAINT "acquisition_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
--
-- Table: acquisitionprop
--;
CREATE SEQUENCE "sq_acquisitionprop_acquisition";
CREATE TABLE "acquisitionprop" (
  "acquisitionprop_id" number NOT NULL,
  "acquisition_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("acquisitionprop_id"),
  CONSTRAINT "acquisitionprop_c1" UNIQUE ("acquisition_id", "type_id", "rank")
);
--
-- Table: all_feature_names
--;
CREATE TABLE "all_feature_names" (
  "feature_id" number,
  "name" varchar2(255),
  "organism_id" number
);
--
-- Table: analysis
--;
CREATE SEQUENCE "sq_analysis_analysis_id";
CREATE TABLE "analysis" (
  "analysis_id" number NOT NULL,
  "name" varchar2(255),
  "description" clob,
  "program" varchar2(255) NOT NULL,
  "programversion" varchar2(255) NOT NULL,
  "algorithm" varchar2(255),
  "sourcename" varchar2(255),
  "sourceversion" varchar2(255),
  "sourceuri" clob,
  "timeexecuted" date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("analysis_id"),
  CONSTRAINT "analysis_c1" UNIQUE ("program", "programversion", "sourcename")
);
--
-- Table: analysisfeature
--;
CREATE SEQUENCE "sq_analysisfeature_analysisfea";
CREATE TABLE "analysisfeature" (
  "analysisfeature_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "analysis_id" number NOT NULL,
  "rawscore" number,
  "normscore" number,
  "significance" number,
  "identity" number,
  PRIMARY KEY ("analysisfeature_id"),
  CONSTRAINT "analysisfeature_c1" UNIQUE ("feature_id", "analysis_id")
);
--
-- Table: analysisfeatureprop
--;
CREATE SEQUENCE "sq_analysisfeatureprop_analysi";
CREATE TABLE "analysisfeatureprop" (
  "analysisfeatureprop_id" number NOT NULL,
  "analysisfeature_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number NOT NULL,
  PRIMARY KEY ("analysisfeatureprop_id"),
  CONSTRAINT "u_analysisfeatureprop_analysis" UNIQUE ("analysisfeature_id", "type_id", "rank")
);
--
-- Table: analysisprop
--;
CREATE SEQUENCE "sq_analysisprop_analysisprop_i";
CREATE TABLE "analysisprop" (
  "analysisprop_id" number NOT NULL,
  "analysis_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("analysisprop_id"),
  CONSTRAINT "analysisprop_c1" UNIQUE ("analysis_id", "type_id", "rank")
);
--
-- Table: arraydesign
--;
CREATE SEQUENCE "sq_arraydesign_arraydesign_id";
CREATE TABLE "arraydesign" (
  "arraydesign_id" number NOT NULL,
  "manufacturer_id" number NOT NULL,
  "platformtype_id" number NOT NULL,
  "substratetype_id" number,
  "protocol_id" number,
  "dbxref_id" number,
  "name" varchar2(4000) NOT NULL,
  "version" clob,
  "description" clob,
  "array_dimensions" clob,
  "element_dimensions" clob,
  "num_of_elements" number,
  "num_array_columns" number,
  "num_array_rows" number,
  "num_grid_columns" number,
  "num_grid_rows" number,
  "num_sub_columns" number,
  "num_sub_rows" number,
  PRIMARY KEY ("arraydesign_id"),
  CONSTRAINT "arraydesign_c1" UNIQUE ("name")
);
--
-- Table: arraydesignprop
--;
CREATE SEQUENCE "sq_arraydesignprop_arraydesign";
CREATE TABLE "arraydesignprop" (
  "arraydesignprop_id" number NOT NULL,
  "arraydesign_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("arraydesignprop_id"),
  CONSTRAINT "arraydesignprop_c1" UNIQUE ("arraydesign_id", "type_id", "rank")
);
--
-- Table: assay
--;
CREATE SEQUENCE "sq_assay_assay_id";
CREATE TABLE "assay" (
  "assay_id" number NOT NULL,
  "arraydesign_id" number NOT NULL,
  "protocol_id" number,
  "assaydate" date DEFAULT current_timestamp,
  "arrayidentifier" clob,
  "arraybatchidentifier" clob,
  "operator_id" number NOT NULL,
  "dbxref_id" number,
  "name" varchar2(4000),
  "description" clob,
  PRIMARY KEY ("assay_id"),
  CONSTRAINT "assay_c1" UNIQUE ("name")
);
--
-- Table: assay_biomaterial
--;
CREATE SEQUENCE "sq_assay_biomaterial_assay_bio";
CREATE TABLE "assay_biomaterial" (
  "assay_biomaterial_id" number NOT NULL,
  "assay_id" number NOT NULL,
  "biomaterial_id" number NOT NULL,
  "channel_id" number,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("assay_biomaterial_id"),
  CONSTRAINT "assay_biomaterial_c1" UNIQUE ("assay_id", "biomaterial_id", "channel_id", "rank")
);
--
-- Table: assay_project
--;
CREATE SEQUENCE "sq_assay_project_assay_project";
CREATE TABLE "assay_project" (
  "assay_project_id" number NOT NULL,
  "assay_id" number NOT NULL,
  "project_id" number NOT NULL,
  PRIMARY KEY ("assay_project_id"),
  CONSTRAINT "assay_project_c1" UNIQUE ("assay_id", "project_id")
);
--
-- Table: assayprop
--;
CREATE SEQUENCE "sq_assayprop_assayprop_id";
CREATE TABLE "assayprop" (
  "assayprop_id" number NOT NULL,
  "assay_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("assayprop_id"),
  CONSTRAINT "assayprop_c1" UNIQUE ("assay_id", "type_id", "rank")
);
--
-- Table: biomaterial
--;
CREATE SEQUENCE "sq_biomaterial_biomaterial_id";
CREATE TABLE "biomaterial" (
  "biomaterial_id" number NOT NULL,
  "taxon_id" number,
  "biosourceprovider_id" number,
  "dbxref_id" number,
  "name" varchar2(4000),
  "description" clob,
  PRIMARY KEY ("biomaterial_id"),
  CONSTRAINT "biomaterial_c1" UNIQUE ("name")
);
--
-- Table: biomaterial_dbxref
--;
CREATE SEQUENCE "sq_biomaterial_dbxref_biomater";
CREATE TABLE "biomaterial_dbxref" (
  "biomaterial_dbxref_id" number NOT NULL,
  "biomaterial_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  PRIMARY KEY ("biomaterial_dbxref_id"),
  CONSTRAINT "biomaterial_dbxref_c1" UNIQUE ("biomaterial_id", "dbxref_id")
);
--
-- Table: biomaterial_relationship
--;
CREATE SEQUENCE "sq_biomaterial_relationship_bi";
CREATE TABLE "biomaterial_relationship" (
  "biomaterial_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "type_id" number NOT NULL,
  "object_id" number NOT NULL,
  PRIMARY KEY ("biomaterial_relationship_id"),
  CONSTRAINT "biomaterial_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
--
-- Table: biomaterial_treatment
--;
CREATE SEQUENCE "sq_biomaterial_treatment_bioma";
CREATE TABLE "biomaterial_treatment" (
  "biomaterial_treatment_id" number NOT NULL,
  "biomaterial_id" number NOT NULL,
  "treatment_id" number NOT NULL,
  "unittype_id" number,
  "value" real,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("biomaterial_treatment_id"),
  CONSTRAINT "biomaterial_treatment_c1" UNIQUE ("biomaterial_id", "treatment_id")
);
--
-- Table: biomaterialprop
--;
CREATE SEQUENCE "sq_biomaterialprop_biomaterial";
CREATE TABLE "biomaterialprop" (
  "biomaterialprop_id" number NOT NULL,
  "biomaterial_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("biomaterialprop_id"),
  CONSTRAINT "biomaterialprop_c1" UNIQUE ("biomaterial_id", "type_id", "rank")
);
--
-- Table: cell_line
--;
CREATE SEQUENCE "sq_cell_line_cell_line_id";
CREATE TABLE "cell_line" (
  "cell_line_id" number NOT NULL,
  "name" varchar2(255),
  "uniquename" varchar2(255) NOT NULL,
  "organism_id" number NOT NULL,
  "timeaccessioned" date DEFAULT current_timestamp NOT NULL,
  "timelastmodified" date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("cell_line_id"),
  CONSTRAINT "cell_line_c1" UNIQUE ("uniquename", "organism_id")
);
--
-- Table: cell_line_cvterm
--;
CREATE SEQUENCE "sq_cell_line_cvterm_cell_line_";
CREATE TABLE "cell_line_cvterm" (
  "cell_line_cvterm_id" number NOT NULL,
  "cell_line_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("cell_line_cvterm_id"),
  CONSTRAINT "cell_line_cvterm_c1" UNIQUE ("cell_line_id", "cvterm_id", "pub_id", "rank")
);
--
-- Table: cell_line_cvtermprop
--;
CREATE SEQUENCE "sq_cell_line_cvtermprop_cell_l";
CREATE TABLE "cell_line_cvtermprop" (
  "cell_line_cvtermprop_id" number NOT NULL,
  "cell_line_cvterm_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("cell_line_cvtermprop_id"),
  CONSTRAINT "cell_line_cvtermprop_c1" UNIQUE ("cell_line_cvterm_id", "type_id", "rank")
);
--
-- Table: cell_line_dbxref
--;
CREATE SEQUENCE "sq_cell_line_dbxref_cell_line_";
CREATE TABLE "cell_line_dbxref" (
  "cell_line_dbxref_id" number NOT NULL,
  "cell_line_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  "is_current" number DEFAULT true NOT NULL,
  PRIMARY KEY ("cell_line_dbxref_id"),
  CONSTRAINT "cell_line_dbxref_c1" UNIQUE ("cell_line_id", "dbxref_id")
);
--
-- Table: cell_line_feature
--;
CREATE SEQUENCE "sq_cell_line_feature_cell_line";
CREATE TABLE "cell_line_feature" (
  "cell_line_feature_id" number NOT NULL,
  "cell_line_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("cell_line_feature_id"),
  CONSTRAINT "cell_line_feature_c1" UNIQUE ("cell_line_id", "feature_id", "pub_id")
);
--
-- Table: cell_line_library
--;
CREATE SEQUENCE "sq_cell_line_library_cell_line";
CREATE TABLE "cell_line_library" (
  "cell_line_library_id" number NOT NULL,
  "cell_line_id" number NOT NULL,
  "library_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("cell_line_library_id"),
  CONSTRAINT "cell_line_library_c1" UNIQUE ("cell_line_id", "library_id", "pub_id")
);
--
-- Table: cell_line_pub
--;
CREATE SEQUENCE "sq_cell_line_pub_cell_line_pub";
CREATE TABLE "cell_line_pub" (
  "cell_line_pub_id" number NOT NULL,
  "cell_line_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("cell_line_pub_id"),
  CONSTRAINT "cell_line_pub_c1" UNIQUE ("cell_line_id", "pub_id")
);
--
-- Table: cell_line_relationship
--;
CREATE SEQUENCE "sq_cell_line_relationship_cell";
CREATE TABLE "cell_line_relationship" (
  "cell_line_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "object_id" number NOT NULL,
  "type_id" number NOT NULL,
  PRIMARY KEY ("cell_line_relationship_id"),
  CONSTRAINT "cell_line_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
--
-- Table: cell_line_synonym
--;
CREATE SEQUENCE "sq_cell_line_synonym_cell_line";
CREATE TABLE "cell_line_synonym" (
  "cell_line_synonym_id" number NOT NULL,
  "cell_line_id" number NOT NULL,
  "synonym_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "is_current" number DEFAULT false NOT NULL,
  "is_internal" number DEFAULT false NOT NULL,
  PRIMARY KEY ("cell_line_synonym_id"),
  CONSTRAINT "cell_line_synonym_c1" UNIQUE ("synonym_id", "cell_line_id", "pub_id")
);
--
-- Table: cell_lineprop
--;
CREATE SEQUENCE "sq_cell_lineprop_cell_lineprop";
CREATE TABLE "cell_lineprop" (
  "cell_lineprop_id" number NOT NULL,
  "cell_line_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("cell_lineprop_id"),
  CONSTRAINT "cell_lineprop_c1" UNIQUE ("cell_line_id", "type_id", "rank")
);
--
-- Table: cell_lineprop_pub
--;
CREATE SEQUENCE "sq_cell_lineprop_pub_cell_line";
CREATE TABLE "cell_lineprop_pub" (
  "cell_lineprop_pub_id" number NOT NULL,
  "cell_lineprop_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("cell_lineprop_pub_id"),
  CONSTRAINT "cell_lineprop_pub_c1" UNIQUE ("cell_lineprop_id", "pub_id")
);
--
-- Table: channel
--;
CREATE SEQUENCE "sq_channel_channel_id";
CREATE TABLE "channel" (
  "channel_id" number NOT NULL,
  "name" varchar2(4000) NOT NULL,
  "definition" clob NOT NULL,
  PRIMARY KEY ("channel_id"),
  CONSTRAINT "channel_c1" UNIQUE ("name")
);
--
-- Table: common_ancestor_cvterm
--;
CREATE TABLE "common_ancestor_cvterm" (
  "cvterm1_id" number,
  "cvterm2_id" number,
  "ancestor_cvterm_id" number,
  "pathdistance1" number,
  "pathdistance2" number,
  "total_pathdistance" number
);
--
-- Table: common_descendant_cvterm
--;
CREATE TABLE "common_descendant_cvterm" (
  "cvterm1_id" number,
  "cvterm2_id" number,
  "ancestor_cvterm_id" number,
  "pathdistance1" number,
  "pathdistance2" number,
  "total_pathdistance" number
);
--
-- Table: contact
--;
CREATE SEQUENCE "sq_contact_contact_id";
CREATE TABLE "contact" (
  "contact_id" number NOT NULL,
  "type_id" number,
  "name" varchar2(255) NOT NULL,
  "description" varchar2(255),
  PRIMARY KEY ("contact_id"),
  CONSTRAINT "contact_c1" UNIQUE ("name")
);
--
-- Table: contact_relationship
--;
CREATE SEQUENCE "sq_contact_relationship_contac";
CREATE TABLE "contact_relationship" (
  "contact_relationship_id" number NOT NULL,
  "type_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "object_id" number NOT NULL,
  PRIMARY KEY ("contact_relationship_id"),
  CONSTRAINT "contact_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
--
-- Table: control
--;
CREATE SEQUENCE "sq_control_control_id";
CREATE TABLE "control" (
  "control_id" number NOT NULL,
  "type_id" number NOT NULL,
  "assay_id" number NOT NULL,
  "tableinfo_id" number NOT NULL,
  "row_id" number NOT NULL,
  "name" clob,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("control_id")
);
--
-- Table: cv
--;
CREATE SEQUENCE "sq_cv_cv_id";
CREATE TABLE "cv" (
  "cv_id" number NOT NULL,
  "name" varchar2(255) NOT NULL,
  "definition" clob,
  PRIMARY KEY ("cv_id"),
  CONSTRAINT "cv_c1" UNIQUE ("name")
);
--
-- Table: cv_cvterm_count
--;
CREATE TABLE "cv_cvterm_count" (
  "name" varchar2(255),
  "num_terms_excl_obs" number
);
--
-- Table: cv_cvterm_count_with_obs
--;
CREATE TABLE "cv_cvterm_count_with_obs" (
  "name" varchar2(255),
  "num_terms_incl_obs" number
);
--
-- Table: cv_leaf
--;
CREATE TABLE "cv_leaf" (
  "cv_id" number,
  "cvterm_id" number
);
--
-- Table: cv_link_count
--;
CREATE TABLE "cv_link_count" (
  "cv_name" varchar2(255),
  "relation_name" varchar2(1024),
  "relation_cv_name" varchar2(255),
  "num_links" number
);
--
-- Table: cv_path_count
--;
CREATE TABLE "cv_path_count" (
  "cv_name" varchar2(255),
  "relation_name" varchar2(1024),
  "relation_cv_name" varchar2(255),
  "num_paths" number
);
--
-- Table: cv_root
--;
CREATE TABLE "cv_root" (
  "cv_id" number,
  "root_cvterm_id" number
);
--
-- Table: cvprop
--;
CREATE SEQUENCE "sq_cvprop_cvprop_id";
CREATE TABLE "cvprop" (
  "cvprop_id" number NOT NULL,
  "cv_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("cvprop_id"),
  CONSTRAINT "cvprop_c1" UNIQUE ("cv_id", "type_id", "rank")
);
--
-- Table: cvterm
--;
CREATE SEQUENCE "sq_cvterm_cvterm_id";
CREATE TABLE "cvterm" (
  "cvterm_id" number NOT NULL,
  "cv_id" number NOT NULL,
  "name" varchar2(1024) NOT NULL,
  "definition" clob,
  "dbxref_id" number NOT NULL,
  "is_obsolete" number DEFAULT '0' NOT NULL,
  "is_relationshiptype" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("cvterm_id"),
  CONSTRAINT "cvterm_c1" UNIQUE ("name", "cv_id", "is_obsolete"),
  CONSTRAINT "cvterm_c2" UNIQUE ("dbxref_id")
);
--
-- Table: cvterm_dbxref
--;
CREATE SEQUENCE "sq_cvterm_dbxref_cvterm_dbxref";
CREATE TABLE "cvterm_dbxref" (
  "cvterm_dbxref_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  "is_for_definition" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("cvterm_dbxref_id"),
  CONSTRAINT "cvterm_dbxref_c1" UNIQUE ("cvterm_id", "dbxref_id")
);
--
-- Table: cvterm_relationship
--;
CREATE SEQUENCE "sq_cvterm_relationship_cvterm_";
CREATE TABLE "cvterm_relationship" (
  "cvterm_relationship_id" number NOT NULL,
  "type_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "object_id" number NOT NULL,
  PRIMARY KEY ("cvterm_relationship_id"),
  CONSTRAINT "cvterm_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
--
-- Table: cvtermpath
--;
CREATE SEQUENCE "sq_cvtermpath_cvtermpath_id";
CREATE TABLE "cvtermpath" (
  "cvtermpath_id" number NOT NULL,
  "type_id" number,
  "subject_id" number NOT NULL,
  "object_id" number NOT NULL,
  "cv_id" number NOT NULL,
  "pathdistance" number,
  PRIMARY KEY ("cvtermpath_id"),
  CONSTRAINT "cvtermpath_c1" UNIQUE ("subject_id", "object_id", "type_id", "pathdistance")
);
--
-- Table: cvtermprop
--;
CREATE SEQUENCE "sq_cvtermprop_cvtermprop_id";
CREATE TABLE "cvtermprop" (
  "cvtermprop_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" varchar2(4000) DEFAULT '' NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("cvtermprop_id"),
  CONSTRAINT "cvtermprop_cvterm_id_key" UNIQUE ("cvterm_id", "type_id", "value", "rank")
);
--
-- Table: cvtermsynonym
--;
CREATE SEQUENCE "sq_cvtermsynonym_cvtermsynonym";
CREATE TABLE "cvtermsynonym" (
  "cvtermsynonym_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "type_id" number,
  "synonym_" varchar2(1024) NOT NULL,
  PRIMARY KEY ("cvtermsynonym_id"),
  CONSTRAINT "cvtermsynonym_c1" UNIQUE ("cvterm_id", "synonym")
);
--
-- Table: db
--;
CREATE SEQUENCE "sq_db_db_id";
CREATE TABLE "db" (
  "db_id" number NOT NULL,
  "name" varchar2(255) NOT NULL,
  "description" varchar2(255),
  "urlprefix" varchar2(255),
  "url" varchar2(255),
  PRIMARY KEY ("db_id"),
  CONSTRAINT "db_c1" UNIQUE ("name")
);
--
-- Table: db_dbxref_count
--;
CREATE TABLE "db_dbxref_count" (
  "name" varchar2(255),
  "num_dbxrefs" number
);
--
-- Table: dbxref
--;
CREATE SEQUENCE "sq_dbxref_dbxref_id";
CREATE TABLE "dbxref" (
  "dbxref_id" number NOT NULL,
  "db_id" number NOT NULL,
  "accession" varchar2(255) NOT NULL,
  "version" varchar2(255) DEFAULT '' NOT NULL,
  "description" clob,
  PRIMARY KEY ("dbxref_id"),
  CONSTRAINT "dbxref_c1" UNIQUE ("db_id", "accession", "version")
);
--
-- Table: dbxrefprop
--;
CREATE SEQUENCE "sq_dbxrefprop_dbxrefprop_id";
CREATE TABLE "dbxrefprop" (
  "dbxrefprop_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob DEFAULT '' NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("dbxrefprop_id"),
  CONSTRAINT "dbxrefprop_c1" UNIQUE ("dbxref_id", "type_id", "rank")
);
--
-- Table: dfeatureloc
--;
CREATE TABLE "dfeatureloc" (
  "featureloc_id" number,
  "feature_id" number,
  "srcfeature_id" number,
  "nbeg" number,
  "is_nbeg_partial" number,
  "nend" number,
  "is_nend_partial" number,
  "strand" number,
  "phase" number,
  "residue_info" clob,
  "locgroup" number,
  "rank" number
);
--
-- Table: eimage
--;
CREATE SEQUENCE "sq_eimage_eimage_id";
CREATE TABLE "eimage" (
  "eimage_id" number NOT NULL,
  "eimage_data" clob,
  "eimage_type" varchar2(255) NOT NULL,
  "image_uri" varchar2(255),
  PRIMARY KEY ("eimage_id")
);
--
-- Table: element
--;
CREATE SEQUENCE "sq_element_element_id";
CREATE TABLE "element" (
  "element_id" number NOT NULL,
  "feature_id" number,
  "arraydesign_id" number NOT NULL,
  "type_id" number,
  "dbxref_id" number,
  PRIMARY KEY ("element_id"),
  CONSTRAINT "element_c1" UNIQUE ("feature_id", "arraydesign_id")
);
--
-- Table: element_relationship
--;
CREATE SEQUENCE "sq_element_relationship_elemen";
CREATE TABLE "element_relationship" (
  "element_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "type_id" number NOT NULL,
  "object_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("element_relationship_id"),
  CONSTRAINT "element_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
--
-- Table: elementresult
--;
CREATE SEQUENCE "sq_elementresult_elementresult";
CREATE TABLE "elementresult" (
  "elementresult_id" number NOT NULL,
  "element_id" number NOT NULL,
  "quantification_id" number NOT NULL,
  "signal" number NOT NULL,
  PRIMARY KEY ("elementresult_id"),
  CONSTRAINT "elementresult_c1" UNIQUE ("element_id", "quantification_id")
);
--
-- Table: elementresult_relationship
--;
CREATE SEQUENCE "sq_elementresult_relationship_";
CREATE TABLE "elementresult_relationship" (
  "elementresult_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "type_id" number NOT NULL,
  "object_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("elementresult_relationship_id"),
  CONSTRAINT "elementresult_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
--
-- Table: environment
--;
CREATE SEQUENCE "sq_environment_environment_id";
CREATE TABLE "environment" (
  "environment_id" number NOT NULL,
  "uniquename" varchar2(4000) NOT NULL,
  "description" clob,
  PRIMARY KEY ("environment_id"),
  CONSTRAINT "environment_c1" UNIQUE ("uniquename")
);
--
-- Table: environment_cvterm
--;
CREATE SEQUENCE "sq_environment_cvterm_environm";
CREATE TABLE "environment_cvterm" (
  "environment_cvterm_id" number NOT NULL,
  "environment_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  PRIMARY KEY ("environment_cvterm_id"),
  CONSTRAINT "environment_cvterm_c1" UNIQUE ("environment_id", "cvterm_id")
);
--
-- Table: expression
--;
CREATE SEQUENCE "sq_expression_expression_id";
CREATE TABLE "expression" (
  "expression_id" number NOT NULL,
  "uniquename" varchar2(4000) NOT NULL,
  "md5checksum" char(32),
  "description" clob,
  PRIMARY KEY ("expression_id"),
  CONSTRAINT "expression_c1" UNIQUE ("uniquename")
);
--
-- Table: expression_cvterm
--;
CREATE SEQUENCE "sq_expression_cvterm_expressio";
CREATE TABLE "expression_cvterm" (
  "expression_cvterm_id" number NOT NULL,
  "expression_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  "cvterm_type_id" number NOT NULL,
  PRIMARY KEY ("expression_cvterm_id"),
  CONSTRAINT "expression_cvterm_c1" UNIQUE ("expression_id", "cvterm_id", "cvterm_type_id")
);
--
-- Table: expression_cvtermprop
--;
CREATE SEQUENCE "sq_expression_cvtermprop_expre";
CREATE TABLE "expression_cvtermprop" (
  "expression_cvtermprop_id" number NOT NULL,
  "expression_cvterm_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("expression_cvtermprop_id"),
  CONSTRAINT "expression_cvtermprop_c1" UNIQUE ("expression_cvterm_id", "type_id", "rank")
);
--
-- Table: expression_image
--;
CREATE SEQUENCE "sq_expression_image_expression";
CREATE TABLE "expression_image" (
  "expression_image_id" number NOT NULL,
  "expression_id" number NOT NULL,
  "eimage_id" number NOT NULL,
  PRIMARY KEY ("expression_image_id"),
  CONSTRAINT "expression_image_c1" UNIQUE ("expression_id", "eimage_id")
);
--
-- Table: expression_pub
--;
CREATE SEQUENCE "sq_expression_pub_expression_p";
CREATE TABLE "expression_pub" (
  "expression_pub_id" number NOT NULL,
  "expression_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("expression_pub_id"),
  CONSTRAINT "expression_pub_c1" UNIQUE ("expression_id", "pub_id")
);
--
-- Table: expressionprop
--;
CREATE SEQUENCE "sq_expressionprop_expressionpr";
CREATE TABLE "expressionprop" (
  "expressionprop_id" number NOT NULL,
  "expression_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("expressionprop_id"),
  CONSTRAINT "expressionprop_c1" UNIQUE ("expression_id", "type_id", "rank")
);
--
-- Table: f_loc
--;
CREATE TABLE "f_loc" (
  "feature_id" number,
  "name" varchar2(255),
  "dbxref_id" number,
  "nbeg" number,
  "nend" number,
  "strand" number
);
--
-- Table: f_type
--;
CREATE TABLE "f_type" (
  "feature_id" number,
  "name" varchar2(255),
  "dbxref_id" number,
  "type" varchar2(1024),
  "residues" clob,
  "seqlen" number,
  "md5checksum" char(32),
  "type_id" number,
  "timeaccessioned" date,
  "timelastmodified" date
);
--
-- Table: feature
--;
CREATE SEQUENCE "sq_feature_feature_id";
CREATE TABLE "feature" (
  "feature_id" number NOT NULL,
  "dbxref_id" number,
  "organism_id" number NOT NULL,
  "name" varchar2(255),
  "uniquename" varchar2(4000) NOT NULL,
  "residues" clob,
  "seqlen" number,
  "md5checksum" char(32),
  "type_id" number NOT NULL,
  "is_analysis" number DEFAULT false NOT NULL,
  "is_obsolete" number DEFAULT false NOT NULL,
  "timeaccessioned" date DEFAULT current_timestamp NOT NULL,
  "timelastmodified" date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("feature_id"),
  CONSTRAINT "feature_c1" UNIQUE ("organism_id", "uniquename", "type_id")
);
--
-- Table: feature_contains
--;
CREATE TABLE "feature_contains" (
  "subject_id" number,
  "object_id" number
);
--
-- Table: feature_cvterm
--;
CREATE SEQUENCE "sq_feature_cvterm_feature_cvte";
CREATE TABLE "feature_cvterm" (
  "feature_cvterm_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "is_not" number DEFAULT false NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("feature_cvterm_id"),
  CONSTRAINT "feature_cvterm_c1" UNIQUE ("feature_id", "cvterm_id", "pub_id", "rank")
);
--
-- Table: feature_cvterm_dbxref
--;
CREATE SEQUENCE "sq_feature_cvterm_dbxref_featu";
CREATE TABLE "feature_cvterm_dbxref" (
  "feature_cvterm_dbxref_id" number NOT NULL,
  "feature_cvterm_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  PRIMARY KEY ("feature_cvterm_dbxref_id"),
  CONSTRAINT "feature_cvterm_dbxref_c1" UNIQUE ("feature_cvterm_id", "dbxref_id")
);
--
-- Table: feature_cvterm_pub
--;
CREATE SEQUENCE "sq_feature_cvterm_pub_feature_";
CREATE TABLE "feature_cvterm_pub" (
  "feature_cvterm_pub_id" number NOT NULL,
  "feature_cvterm_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("feature_cvterm_pub_id"),
  CONSTRAINT "feature_cvterm_pub_c1" UNIQUE ("feature_cvterm_id", "pub_id")
);
--
-- Table: feature_cvtermprop
--;
CREATE SEQUENCE "sq_feature_cvtermprop_feature_";
CREATE TABLE "feature_cvtermprop" (
  "feature_cvtermprop_id" number NOT NULL,
  "feature_cvterm_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("feature_cvtermprop_id"),
  CONSTRAINT "feature_cvtermprop_c1" UNIQUE ("feature_cvterm_id", "type_id", "rank")
);
--
-- Table: feature_dbxref
--;
CREATE SEQUENCE "sq_feature_dbxref_feature_dbxr";
CREATE TABLE "feature_dbxref" (
  "feature_dbxref_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  "is_current" number DEFAULT true NOT NULL,
  PRIMARY KEY ("feature_dbxref_id"),
  CONSTRAINT "feature_dbxref_c1" UNIQUE ("feature_id", "dbxref_id")
);
--
-- Table: feature_difference
--;
CREATE TABLE "feature_difference" (
  "subject_id" number,
  "object_id" number,
  "srcfeature_id" number,
  "fmin" number,
  "fmax" number,
  "strand" number
);
--
-- Table: feature_disjoint
--;
CREATE TABLE "feature_disjoint" (
  "subject_id" number,
  "object_id" number
);
--
-- Table: feature_distance
--;
CREATE TABLE "feature_distance" (
  "subject_id" number,
  "object_id" number,
  "srcfeature_id" number,
  "subject_strand" number,
  "object_strand" number,
  "distance" number
);
--
-- Table: feature_expression
--;
CREATE SEQUENCE "sq_feature_expression_feature_";
CREATE TABLE "feature_expression" (
  "feature_expression_id" number NOT NULL,
  "expression_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("feature_expression_id"),
  CONSTRAINT "feature_expression_c1" UNIQUE ("expression_id", "feature_id", "pub_id")
);
--
-- Table: feature_expressionprop
--;
CREATE SEQUENCE "sq_feature_expressionprop_feat";
CREATE TABLE "feature_expressionprop" (
  "feature_expressionprop_id" number NOT NULL,
  "feature_expression_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("feature_expressionprop_id"),
  CONSTRAINT "feature_expressionprop_c1" UNIQUE ("feature_expression_id", "type_id", "rank")
);
--
-- Table: feature_genotype
--;
CREATE SEQUENCE "sq_feature_genotype_feature_ge";
CREATE TABLE "feature_genotype" (
  "feature_genotype_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "genotype_id" number NOT NULL,
  "chromosome_id" number,
  "rank" number NOT NULL,
  "cgroup" number NOT NULL,
  "cvterm_id" number NOT NULL,
  PRIMARY KEY ("feature_genotype_id"),
  CONSTRAINT "feature_genotype_c1" UNIQUE ("feature_id", "genotype_id", "cvterm_id", "chromosome_id", "rank", "cgroup")
);
--
-- Table: feature_intersection
--;
CREATE TABLE "feature_intersection" (
  "subject_id" number,
  "object_id" number,
  "srcfeature_id" number,
  "subject_strand" number,
  "object_strand" number,
  "fmin" number,
  "fmax" number
);
--
-- Table: feature_meets
--;
CREATE TABLE "feature_meets" (
  "subject_id" number,
  "object_id" number
);
--
-- Table: feature_meets_on_same_strand
--;
CREATE TABLE "feature_meets_on_same_strand" (
  "subject_id" number,
  "object_id" number
);
--
-- Table: feature_phenotype
--;
CREATE SEQUENCE "sq_feature_phenotype_feature_p";
CREATE TABLE "feature_phenotype" (
  "feature_phenotype_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "phenotype_id" number NOT NULL,
  PRIMARY KEY ("feature_phenotype_id"),
  CONSTRAINT "feature_phenotype_c1" UNIQUE ("feature_id", "phenotype_id")
);
--
-- Table: feature_pub
--;
CREATE SEQUENCE "sq_feature_pub_feature_pub_id";
CREATE TABLE "feature_pub" (
  "feature_pub_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("feature_pub_id"),
  CONSTRAINT "feature_pub_c1" UNIQUE ("feature_id", "pub_id")
);
--
-- Table: feature_pubprop
--;
CREATE SEQUENCE "sq_feature_pubprop_feature_pub";
CREATE TABLE "feature_pubprop" (
  "feature_pubprop_id" number NOT NULL,
  "feature_pub_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("feature_pubprop_id"),
  CONSTRAINT "feature_pubprop_c1" UNIQUE ("feature_pub_id", "type_id", "rank")
);
--
-- Table: feature_relationship
--;
CREATE SEQUENCE "sq_feature_relationship_featur";
CREATE TABLE "feature_relationship" (
  "feature_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "object_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("feature_relationship_id"),
  CONSTRAINT "feature_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
--
-- Table: feature_relationship_pub
--;
CREATE SEQUENCE "sq_feature_relationship_pub_fe";
CREATE TABLE "feature_relationship_pub" (
  "feature_relationship_pub_id" number NOT NULL,
  "feature_relationship_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("feature_relationship_pub_id"),
  CONSTRAINT "feature_relationship_pub_c1" UNIQUE ("feature_relationship_id", "pub_id")
);
--
-- Table: feature_relationshipprop
--;
CREATE SEQUENCE "sq_feature_relationshipprop_fe";
CREATE TABLE "feature_relationshipprop" (
  "feature_relationshipprop_id" number NOT NULL,
  "feature_relationship_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("feature_relationshipprop_id"),
  CONSTRAINT "feature_relationshipprop_c1" UNIQUE ("feature_relationship_id", "type_id", "rank")
);
--
-- Table: feature_relationshipprop_pub
--;
CREATE SEQUENCE "sq_feature_relationshipprop_pu";
CREATE TABLE "feature_relationshipprop_pub" (
  "feature_relationshipprop_pub_i" number NOT NULL,
  "feature_relationshipprop_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("feature_relationshipprop_pub_i"),
  CONSTRAINT "feature_relationshipprop_pub_c1" UNIQUE ("feature_relationshipprop_id", "pub_id")
);
--
-- Table: feature_synonym
--;
CREATE SEQUENCE "sq_feature_synonym_feature_syn";
CREATE TABLE "feature_synonym" (
  "feature_synonym_id" number NOT NULL,
  "synonym_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "is_current" number DEFAULT false NOT NULL,
  "is_internal" number DEFAULT false NOT NULL,
  PRIMARY KEY ("feature_synonym_id"),
  CONSTRAINT "feature_synonym_c1" UNIQUE ("synonym_id", "feature_id", "pub_id")
);
--
-- Table: feature_union
--;
CREATE TABLE "feature_union" (
  "subject_id" number,
  "object_id" number,
  "srcfeature_id" number,
  "subject_strand" number,
  "object_strand" number,
  "fmin" number,
  "fmax" number
);
--
-- Table: featureloc
--;
CREATE SEQUENCE "sq_featureloc_featureloc_id";
CREATE TABLE "featureloc" (
  "featureloc_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "srcfeature_id" number,
  "fmin" number,
  "is_fmin_partial" number DEFAULT false NOT NULL,
  "fmax" number,
  "is_fmax_partial" number DEFAULT false NOT NULL,
  "strand" number,
  "phase" number,
  "residue_info" clob,
  "locgroup" number DEFAULT '0' NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("featureloc_id"),
  CONSTRAINT "featureloc_c1" UNIQUE ("feature_id", "locgroup", "rank")
);
--
-- Table: featureloc_pub
--;
CREATE SEQUENCE "sq_featureloc_pub_featureloc_p";
CREATE TABLE "featureloc_pub" (
  "featureloc_pub_id" number NOT NULL,
  "featureloc_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("featureloc_pub_id"),
  CONSTRAINT "featureloc_pub_c1" UNIQUE ("featureloc_id", "pub_id")
);
--
-- Table: featuremap
--;
CREATE SEQUENCE "sq_featuremap_featuremap_id";
CREATE TABLE "featuremap" (
  "featuremap_id" number NOT NULL,
  "name" varchar2(255),
  "description" clob,
  "unittype_id" number,
  PRIMARY KEY ("featuremap_id"),
  CONSTRAINT "featuremap_c1" UNIQUE ("name")
);
--
-- Table: featuremap_pub
--;
CREATE SEQUENCE "sq_featuremap_pub_featuremap_p";
CREATE TABLE "featuremap_pub" (
  "featuremap_pub_id" number NOT NULL,
  "featuremap_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("featuremap_pub_id")
);
--
-- Table: featurepos
--;
CREATE SEQUENCE "sq_featurepos_featurepos_id";
CREATE SEQUENCE "sq_featurepos_featuremap_id";
CREATE TABLE "featurepos" (
  "featurepos_id" number NOT NULL,
  "featuremap_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "map_feature_id" number NOT NULL,
  "mappos" number NOT NULL,
  PRIMARY KEY ("featurepos_id")
);
--
-- Table: featureprop_pub
--;
CREATE SEQUENCE "sq_featureprop_pub_featureprop";
CREATE TABLE "featureprop_pub" (
  "featureprop_pub_id" number NOT NULL,
  "featureprop_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("featureprop_pub_id"),
  CONSTRAINT "featureprop_pub_c1" UNIQUE ("featureprop_id", "pub_id")
);
--
-- Table: featurerange
--;
CREATE SEQUENCE "sq_featurerange_featurerange_i";
CREATE TABLE "featurerange" (
  "featurerange_id" number NOT NULL,
  "featuremap_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "leftstartf_id" number NOT NULL,
  "leftendf_id" number,
  "rightstartf_id" number,
  "rightendf_id" number NOT NULL,
  "rangestr" varchar2(255),
  PRIMARY KEY ("featurerange_id")
);
--
-- Table: featureset_meets
--;
CREATE TABLE "featureset_meets" (
  "subject_id" number,
  "object_id" number
);
--
-- Table: fnr_type
--;
CREATE TABLE "fnr_type" (
  "feature_id" number,
  "name" varchar2(255),
  "dbxref_id" number,
  "type" varchar2(1024),
  "residues" clob,
  "seqlen" number,
  "md5checksum" char(32),
  "type_id" number,
  "timeaccessioned" date,
  "timelastmodified" date
);
--
-- Table: fp_key
--;
CREATE TABLE "fp_key" (
  "feature_id" number,
  "pkey" varchar2(1024),
  "value" clob
);
--
-- Table: genotype
--;
CREATE SEQUENCE "sq_genotype_genotype_id";
CREATE TABLE "genotype" (
  "genotype_id" number NOT NULL,
  "name" clob,
  "uniquename" varchar2(4000) NOT NULL,
  "description" varchar2(255),
  "type_id" number NOT NULL,
  PRIMARY KEY ("genotype_id"),
  CONSTRAINT "genotype_c1" UNIQUE ("uniquename")
);
--
-- Table: genotypeprop
--;
CREATE SEQUENCE "sq_genotypeprop_genotypeprop_i";
CREATE TABLE "genotypeprop" (
  "genotypeprop_id" number NOT NULL,
  "genotype_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("genotypeprop_id"),
  CONSTRAINT "genotypeprop_c1" UNIQUE ("genotype_id", "type_id", "rank")
);
--
-- Table: gff3atts
--;
CREATE TABLE "gff3atts" (
  "feature_id" number,
  "type" clob,
  "attribute" clob
);
--
-- Table: gff3view
--;
CREATE TABLE "gff3view" (
  "feature_id" number,
  "ref" varchar2(255),
  "source" varchar2(255),
  "type" varchar2(1024),
  "fstart" number,
  "fend" number,
  "score" clob,
  "strand" clob,
  "phase" clob,
  "seqlen" number,
  "name" varchar2(255),
  "organism_id" number
);
--
-- Table: gffatts
--;
CREATE TABLE "gffatts" (
  "feature_id" number,
  "type" clob,
  "attribute" clob
);
--
-- Table: intron_combined_view
--;
CREATE TABLE "intron_combined_view" (
  "exon1_id" number,
  "exon2_id" number,
  "fmin" number,
  "fmax" number,
  "strand" number,
  "srcfeature_id" number,
  "intron_rank" number,
  "transcript_id" number
);
--
-- Table: intronloc_view
--;
CREATE TABLE "intronloc_view" (
  "exon1_id" number,
  "exon2_id" number,
  "fmin" number,
  "fmax" number,
  "strand" number,
  "srcfeature_id" number
);
--
-- Table: library
--;
CREATE SEQUENCE "sq_library_library_id";
CREATE TABLE "library" (
  "library_id" number NOT NULL,
  "organism_id" number NOT NULL,
  "name" varchar2(255),
  "uniquename" varchar2(4000) NOT NULL,
  "type_id" number NOT NULL,
  "is_obsolete" number DEFAULT '0' NOT NULL,
  "timeaccessioned" date DEFAULT current_timestamp NOT NULL,
  "timelastmodified" date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("library_id"),
  CONSTRAINT "library_c1" UNIQUE ("organism_id", "uniquename", "type_id")
);
--
-- Table: library_cvterm
--;
CREATE SEQUENCE "sq_library_cvterm_library_cvte";
CREATE TABLE "library_cvterm" (
  "library_cvterm_id" number NOT NULL,
  "library_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("library_cvterm_id"),
  CONSTRAINT "library_cvterm_c1" UNIQUE ("library_id", "cvterm_id", "pub_id")
);
--
-- Table: library_dbxref
--;
CREATE SEQUENCE "sq_library_dbxref_library_dbxr";
CREATE TABLE "library_dbxref" (
  "library_dbxref_id" number NOT NULL,
  "library_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  "is_current" number DEFAULT true NOT NULL,
  PRIMARY KEY ("library_dbxref_id"),
  CONSTRAINT "library_dbxref_c1" UNIQUE ("library_id", "dbxref_id")
);
--
-- Table: library_feature
--;
CREATE SEQUENCE "sq_library_feature_library_fea";
CREATE TABLE "library_feature" (
  "library_feature_id" number NOT NULL,
  "library_id" number NOT NULL,
  "feature_id" number NOT NULL,
  PRIMARY KEY ("library_feature_id"),
  CONSTRAINT "library_feature_c1" UNIQUE ("library_id", "feature_id")
);
--
-- Table: library_pub
--;
CREATE SEQUENCE "sq_library_pub_library_pub_id";
CREATE TABLE "library_pub" (
  "library_pub_id" number NOT NULL,
  "library_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("library_pub_id"),
  CONSTRAINT "library_pub_c1" UNIQUE ("library_id", "pub_id")
);
--
-- Table: library_synonym
--;
CREATE SEQUENCE "sq_library_synonym_library_syn";
CREATE TABLE "library_synonym" (
  "library_synonym_id" number NOT NULL,
  "synonym_id" number NOT NULL,
  "library_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "is_current" number DEFAULT true NOT NULL,
  "is_internal" number DEFAULT false NOT NULL,
  PRIMARY KEY ("library_synonym_id"),
  CONSTRAINT "library_synonym_c1" UNIQUE ("synonym_id", "library_id", "pub_id")
);
--
-- Table: libraryprop
--;
CREATE SEQUENCE "sq_libraryprop_libraryprop_id";
CREATE TABLE "libraryprop" (
  "libraryprop_id" number NOT NULL,
  "library_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("libraryprop_id"),
  CONSTRAINT "libraryprop_c1" UNIQUE ("library_id", "type_id", "rank")
);
--
-- Table: libraryprop_pub
--;
CREATE SEQUENCE "sq_libraryprop_pub_libraryprop";
CREATE TABLE "libraryprop_pub" (
  "libraryprop_pub_id" number NOT NULL,
  "libraryprop_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("libraryprop_pub_id"),
  CONSTRAINT "libraryprop_pub_c1" UNIQUE ("libraryprop_id", "pub_id")
);
--
-- Table: magedocumentation
--;
CREATE SEQUENCE "sq_magedocumentation_magedocum";
CREATE TABLE "magedocumentation" (
  "magedocumentation_id" number NOT NULL,
  "mageml_id" number NOT NULL,
  "tableinfo_id" number NOT NULL,
  "row_id" number NOT NULL,
  "mageidentifier" clob NOT NULL,
  PRIMARY KEY ("magedocumentation_id")
);
--
-- Table: mageml
--;
CREATE SEQUENCE "sq_mageml_mageml_id";
CREATE TABLE "mageml" (
  "mageml_id" number NOT NULL,
  "mage_package" clob NOT NULL,
  "mage_ml" clob NOT NULL,
  PRIMARY KEY ("mageml_id")
);
--
-- Table: nd_experiment
--;
CREATE SEQUENCE "sq_nd_experiment_nd_experiment";
CREATE TABLE "nd_experiment" (
  "nd_experiment_id" number NOT NULL,
  "nd_geolocation_id" number NOT NULL,
  "type_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_id")
);
--
-- Table: nd_experiment_contact
--;
CREATE SEQUENCE "sq_nd_experiment_contact_nd_ex";
CREATE TABLE "nd_experiment_contact" (
  "nd_experiment_contact_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  "contact_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_contact_id")
);
--
-- Table: nd_experiment_dbxref
--;
CREATE SEQUENCE "sq_nd_experiment_dbxref_nd_exp";
CREATE TABLE "nd_experiment_dbxref" (
  "nd_experiment_dbxref_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_dbxref_id")
);
--
-- Table: nd_experiment_genotype
--;
CREATE SEQUENCE "sq_nd_experiment_genotype_nd_e";
CREATE TABLE "nd_experiment_genotype" (
  "nd_experiment_genotype_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  "genotype_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_genotype_id"),
  CONSTRAINT "nd_experiment_genotype_c1" UNIQUE ("nd_experiment_id", "genotype_id")
);
--
-- Table: nd_experiment_phenotype
--;
CREATE SEQUENCE "sq_nd_experiment_phenotype_nd_";
CREATE TABLE "nd_experiment_phenotype" (
  "nd_experiment_phenotype_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  "phenotype_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_phenotype_id"),
  CONSTRAINT "nd_experiment_phenotype_c1" UNIQUE ("nd_experiment_id", "phenotype_id")
);
--
-- Table: nd_experiment_project
--;
CREATE SEQUENCE "sq_nd_experiment_project_nd_ex";
CREATE TABLE "nd_experiment_project" (
  "nd_experiment_project_id" number NOT NULL,
  "project_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_project_id")
);
--
-- Table: nd_experiment_protocol
--;
CREATE SEQUENCE "sq_nd_experiment_protocol_nd_e";
CREATE TABLE "nd_experiment_protocol" (
  "nd_experiment_protocol_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  "nd_protocol_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_protocol_id")
);
--
-- Table: nd_experiment_pub
--;
CREATE SEQUENCE "sq_nd_experiment_pub_nd_experi";
CREATE TABLE "nd_experiment_pub" (
  "nd_experiment_pub_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_pub_id"),
  CONSTRAINT "nd_experiment_pub_c1" UNIQUE ("nd_experiment_id", "pub_id")
);
--
-- Table: nd_experiment_stock
--;
CREATE SEQUENCE "sq_nd_experiment_stock_nd_expe";
CREATE TABLE "nd_experiment_stock" (
  "nd_experiment_stock_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  "stock_id" number NOT NULL,
  "type_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_stock_id")
);
--
-- Table: nd_experiment_stock_dbxref
--;
CREATE SEQUENCE "sq_nd_experiment_stock_dbxref_";
CREATE TABLE "nd_experiment_stock_dbxref" (
  "nd_experiment_stock_dbxref_id" number NOT NULL,
  "nd_experiment_stock_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  PRIMARY KEY ("nd_experiment_stock_dbxref_id")
);
--
-- Table: nd_experiment_stockprop
--;
CREATE SEQUENCE "sq_nd_experiment_stockprop_nd_";
CREATE TABLE "nd_experiment_stockprop" (
  "nd_experiment_stockprop_id" number NOT NULL,
  "nd_experiment_stock_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("nd_experiment_stockprop_id"),
  CONSTRAINT "nd_experiment_stockprop_c1" UNIQUE ("nd_experiment_stock_id", "type_id", "rank")
);
--
-- Table: nd_experimentprop
--;
CREATE SEQUENCE "sq_nd_experimentprop_nd_experi";
CREATE TABLE "nd_experimentprop" (
  "nd_experimentprop_id" number NOT NULL,
  "nd_experiment_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("nd_experimentprop_id"),
  CONSTRAINT "nd_experimentprop_c1" UNIQUE ("nd_experiment_id", "type_id", "rank")
);
--
-- Table: nd_geolocation
--;
CREATE SEQUENCE "sq_nd_geolocation_nd_geolocati";
CREATE TABLE "nd_geolocation" (
  "nd_geolocation_id" number NOT NULL,
  "description" varchar2(255),
  "latitude" real,
  "longitude" real,
  "geodetic_datum" varchar2(32),
  "altitude" real,
  PRIMARY KEY ("nd_geolocation_id")
);
--
-- Table: nd_geolocationprop
--;
CREATE SEQUENCE "sq_nd_geolocationprop_nd_geolo";
CREATE TABLE "nd_geolocationprop" (
  "nd_geolocationprop_id" number NOT NULL,
  "nd_geolocation_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("nd_geolocationprop_id"),
  CONSTRAINT "nd_geolocationprop_c1" UNIQUE ("nd_geolocation_id", "type_id", "rank")
);
--
-- Table: nd_protocol
--;
CREATE SEQUENCE "sq_nd_protocol_nd_protocol_id";
CREATE TABLE "nd_protocol" (
  "nd_protocol_id" number NOT NULL,
  "name" varchar2(255) NOT NULL,
  "type_id" number NOT NULL,
  PRIMARY KEY ("nd_protocol_id"),
  CONSTRAINT "nd_protocol_name_key" UNIQUE ("name")
);
--
-- Table: nd_protocol_reagent
--;
CREATE SEQUENCE "sq_nd_protocol_reagent_nd_prot";
CREATE TABLE "nd_protocol_reagent" (
  "nd_protocol_reagent_id" number NOT NULL,
  "nd_protocol_id" number NOT NULL,
  "reagent_id" number NOT NULL,
  "type_id" number NOT NULL,
  PRIMARY KEY ("nd_protocol_reagent_id")
);
--
-- Table: nd_protocolprop
--;
CREATE SEQUENCE "sq_nd_protocolprop_nd_protocol";
CREATE TABLE "nd_protocolprop" (
  "nd_protocolprop_id" number NOT NULL,
  "nd_protocol_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("nd_protocolprop_id"),
  CONSTRAINT "nd_protocolprop_c1" UNIQUE ("nd_protocol_id", "type_id", "rank")
);
--
-- Table: nd_reagent
--;
CREATE SEQUENCE "sq_nd_reagent_nd_reagent_id";
CREATE TABLE "nd_reagent" (
  "nd_reagent_id" number NOT NULL,
  "name" varchar2(80) NOT NULL,
  "type_id" number NOT NULL,
  "feature_id" number,
  PRIMARY KEY ("nd_reagent_id")
);
--
-- Table: nd_reagent_relationship
--;
CREATE SEQUENCE "sq_nd_reagent_relationship_nd_";
CREATE TABLE "nd_reagent_relationship" (
  "nd_reagent_relationship_id" number NOT NULL,
  "subject_reagent_id" number NOT NULL,
  "object_reagent_id" number NOT NULL,
  "type_id" number NOT NULL,
  PRIMARY KEY ("nd_reagent_relationship_id")
);
--
-- Table: nd_reagentprop
--;
CREATE SEQUENCE "sq_nd_reagentprop_nd_reagentpr";
CREATE TABLE "nd_reagentprop" (
  "nd_reagentprop_id" number NOT NULL,
  "nd_reagent_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("nd_reagentprop_id"),
  CONSTRAINT "nd_reagentprop_c1" UNIQUE ("nd_reagent_id", "type_id", "rank")
);
--
-- Table: organism
--;
CREATE SEQUENCE "sq_organism_organism_id";
CREATE TABLE "organism" (
  "organism_id" number NOT NULL,
  "abbreviation" varchar2(255),
  "genus" varchar2(255) NOT NULL,
  "species" varchar2(255) NOT NULL,
  "common_name" varchar2(255),
  "comment_" clob DEFAULT NULL,
  PRIMARY KEY ("organism_id"),
  CONSTRAINT "organism_c1" UNIQUE ("genus", "species")
);
--
-- Table: organism_dbxref
--;
CREATE SEQUENCE "sq_organism_dbxref_organism_db";
CREATE TABLE "organism_dbxref" (
  "organism_dbxref_id" number NOT NULL,
  "organism_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  PRIMARY KEY ("organism_dbxref_id"),
  CONSTRAINT "organism_dbxref_c1" UNIQUE ("organism_id", "dbxref_id")
);
--
-- Table: organismprop
--;
CREATE SEQUENCE "sq_organismprop_organismprop_i";
CREATE TABLE "organismprop" (
  "organismprop_id" number NOT NULL,
  "organism_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("organismprop_id"),
  CONSTRAINT "organismprop_c1" UNIQUE ("organism_id", "type_id", "rank")
);
--
-- Table: phendesc
--;
CREATE SEQUENCE "sq_phendesc_phendesc_id";
CREATE TABLE "phendesc" (
  "phendesc_id" number NOT NULL,
  "genotype_id" number NOT NULL,
  "environment_id" number NOT NULL,
  "description" clob NOT NULL,
  "type_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("phendesc_id"),
  CONSTRAINT "phendesc_c1" UNIQUE ("genotype_id", "environment_id", "type_id", "pub_id")
);
--
-- Table: phenotype
--;
CREATE SEQUENCE "sq_phenotype_phenotype_id";
CREATE TABLE "phenotype" (
  "phenotype_id" number NOT NULL,
  "uniquename" varchar2(4000) NOT NULL,
  "name" clob,
  "observable_id" number,
  "attr_id" number,
  "value" clob,
  "cvalue_id" number,
  "assay_id" number,
  PRIMARY KEY ("phenotype_id"),
  CONSTRAINT "phenotype_c1" UNIQUE ("uniquename")
);
--
-- Table: phenotype_comparison
--;
CREATE SEQUENCE "sq_phenotype_comparison_phenot";
CREATE TABLE "phenotype_comparison" (
  "phenotype_comparison_id" number NOT NULL,
  "genotype1_id" number NOT NULL,
  "environment1_id" number NOT NULL,
  "genotype2_id" number NOT NULL,
  "environment2_id" number NOT NULL,
  "phenotype1_id" number NOT NULL,
  "phenotype2_id" number,
  "pub_id" number NOT NULL,
  "organism_id" number NOT NULL,
  PRIMARY KEY ("phenotype_comparison_id"),
  CONSTRAINT "phenotype_comparison_c1" UNIQUE ("genotype1_id", "environment1_id", "genotype2_id", "environment2_id", "phenotype1_id", "pub_id")
);
--
-- Table: phenotype_comparison_cvterm
--;
CREATE SEQUENCE "sq_phenotype_comparison_cvterm";
CREATE TABLE "phenotype_comparison_cvterm" (
  "phenotype_comparison_cvterm_id" number NOT NULL,
  "phenotype_comparison_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("phenotype_comparison_cvterm_id"),
  CONSTRAINT "phenotype_comparison_cvterm_c1" UNIQUE ("phenotype_comparison_id", "cvterm_id")
);
--
-- Table: phenotype_cvterm
--;
CREATE SEQUENCE "sq_phenotype_cvterm_phenotype_";
CREATE TABLE "phenotype_cvterm" (
  "phenotype_cvterm_id" number NOT NULL,
  "phenotype_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("phenotype_cvterm_id"),
  CONSTRAINT "phenotype_cvterm_c1" UNIQUE ("phenotype_id", "cvterm_id", "rank")
);
--
-- Table: phenstatement
--;
CREATE SEQUENCE "sq_phenstatement_phenstatement";
CREATE TABLE "phenstatement" (
  "phenstatement_id" number NOT NULL,
  "genotype_id" number NOT NULL,
  "environment_id" number NOT NULL,
  "phenotype_id" number NOT NULL,
  "type_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("phenstatement_id"),
  CONSTRAINT "phenstatement_c1" UNIQUE ("genotype_id", "phenotype_id", "environment_id", "type_id", "pub_id")
);
--
-- Table: phylonode
--;
CREATE SEQUENCE "sq_phylonode_phylonode_id";
CREATE TABLE "phylonode" (
  "phylonode_id" number NOT NULL,
  "phylotree_id" number NOT NULL,
  "parent_phylonode_id" number,
  "left_idx" number NOT NULL,
  "right_idx" number NOT NULL,
  "type_id" number,
  "feature_id" number,
  "label" varchar2(255),
  "distance" number,
  PRIMARY KEY ("phylonode_id"),
  CONSTRAINT "phylonode_phylotree_id_key" UNIQUE ("phylotree_id", "left_idx"),
  CONSTRAINT "phylonode_phylotree_id_key1" UNIQUE ("phylotree_id", "right_idx")
);
--
-- Table: phylonode_dbxref
--;
CREATE SEQUENCE "sq_phylonode_dbxref_phylonode_";
CREATE TABLE "phylonode_dbxref" (
  "phylonode_dbxref_id" number NOT NULL,
  "phylonode_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  PRIMARY KEY ("phylonode_dbxref_id"),
  CONSTRAINT "phylonode_dbxref_phylonode_id_key" UNIQUE ("phylonode_id", "dbxref_id")
);
--
-- Table: phylonode_organism
--;
CREATE SEQUENCE "sq_phylonode_organism_phylonod";
CREATE TABLE "phylonode_organism" (
  "phylonode_organism_id" number NOT NULL,
  "phylonode_id" number NOT NULL,
  "organism_id" number NOT NULL,
  PRIMARY KEY ("phylonode_organism_id"),
  CONSTRAINT "phylonode_organism_phylonode_id_key" UNIQUE ("phylonode_id")
);
--
-- Table: phylonode_pub
--;
CREATE SEQUENCE "sq_phylonode_pub_phylonode_pub";
CREATE TABLE "phylonode_pub" (
  "phylonode_pub_id" number NOT NULL,
  "phylonode_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("phylonode_pub_id"),
  CONSTRAINT "phylonode_pub_phylonode_id_key" UNIQUE ("phylonode_id", "pub_id")
);
--
-- Table: phylonode_relationship
--;
CREATE SEQUENCE "sq_phylonode_relationship_phyl";
CREATE TABLE "phylonode_relationship" (
  "phylonode_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "object_id" number NOT NULL,
  "type_id" number NOT NULL,
  "rank" number,
  "phylotree_id" number NOT NULL,
  PRIMARY KEY ("phylonode_relationship_id"),
  CONSTRAINT "phylonode_relationship_subject_id_key" UNIQUE ("subject_id", "object_id", "type_id")
);
--
-- Table: phylonodeprop
--;
CREATE SEQUENCE "sq_phylonodeprop_phylonodeprop";
CREATE TABLE "phylonodeprop" (
  "phylonodeprop_id" number NOT NULL,
  "phylonode_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" varchar2(4000) DEFAULT '' NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("phylonodeprop_id"),
  CONSTRAINT "phylonodeprop_phylonode_id_key" UNIQUE ("phylonode_id", "type_id", "value", "rank")
);
--
-- Table: phylotree
--;
CREATE SEQUENCE "sq_phylotree_phylotree_id";
CREATE TABLE "phylotree" (
  "phylotree_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  "name" varchar2(255),
  "type_id" number,
  "analysis_id" number,
  "comment" clob,
  PRIMARY KEY ("phylotree_id")
);
--
-- Table: phylotree_pub
--;
CREATE SEQUENCE "sq_phylotree_pub_phylotree_pub";
CREATE TABLE "phylotree_pub" (
  "phylotree_pub_id" number NOT NULL,
  "phylotree_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("phylotree_pub_id"),
  CONSTRAINT "phylotree_pub_phylotree_id_key" UNIQUE ("phylotree_id", "pub_id")
);
--
-- Table: project
--;
CREATE SEQUENCE "sq_project_project_id";
CREATE TABLE "project" (
  "project_id" number NOT NULL,
  "name" varchar2(255) NOT NULL,
  "description" varchar2(255) NOT NULL,
  PRIMARY KEY ("project_id"),
  CONSTRAINT "project_c1" UNIQUE ("name")
);
--
-- Table: project_contact
--;
CREATE SEQUENCE "sq_project_contact_project_con";
CREATE TABLE "project_contact" (
  "project_contact_id" number NOT NULL,
  "project_id" number NOT NULL,
  "contact_id" number NOT NULL,
  PRIMARY KEY ("project_contact_id"),
  CONSTRAINT "project_contact_c1" UNIQUE ("project_id", "contact_id")
);
--
-- Table: project_pub
--;
CREATE SEQUENCE "sq_project_pub_project_pub_id";
CREATE TABLE "project_pub" (
  "project_pub_id" number NOT NULL,
  "project_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("project_pub_id"),
  CONSTRAINT "project_pub_c1" UNIQUE ("project_id", "pub_id")
);
--
-- Table: project_relationship
--;
CREATE SEQUENCE "sq_project_relationship_projec";
CREATE TABLE "project_relationship" (
  "project_relationship_id" number NOT NULL,
  "subject_project_id" number NOT NULL,
  "object_project_id" number NOT NULL,
  "type_id" number NOT NULL,
  PRIMARY KEY ("project_relationship_id"),
  CONSTRAINT "project_relationship_c1" UNIQUE ("subject_project_id", "object_project_id", "type_id")
);
--
-- Table: projectprop
--;
CREATE SEQUENCE "sq_projectprop_projectprop_id";
CREATE TABLE "projectprop" (
  "projectprop_id" number NOT NULL,
  "project_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("projectprop_id"),
  CONSTRAINT "projectprop_c1" UNIQUE ("project_id", "type_id", "rank")
);
--
-- Table: protein_coding_gene
--;
CREATE TABLE "protein_coding_gene" (
  "feature_id" number,
  "dbxref_id" number,
  "organism_id" number,
  "name" varchar2(255),
  "uniquename" clob,
  "residues" clob,
  "seqlen" number,
  "md5checksum" char(32),
  "type_id" number,
  "is_analysis" number,
  "is_obsolete" number,
  "timeaccessioned" date,
  "timelastmodified" date
);
--
-- Table: protocol
--;
CREATE SEQUENCE "sq_protocol_protocol_id";
CREATE TABLE "protocol" (
  "protocol_id" number NOT NULL,
  "type_id" number NOT NULL,
  "pub_id" number,
  "dbxref_id" number,
  "name" varchar2(4000) NOT NULL,
  "uri" clob,
  "protocoldescription" clob,
  "hardwaredescription" clob,
  "softwaredescription" clob,
  PRIMARY KEY ("protocol_id"),
  CONSTRAINT "protocol_c1" UNIQUE ("name")
);
--
-- Table: protocolparam
--;
CREATE SEQUENCE "sq_protocolparam_protocolparam";
CREATE TABLE "protocolparam" (
  "protocolparam_id" number NOT NULL,
  "protocol_id" number NOT NULL,
  "name" clob NOT NULL,
  "datatype_id" number,
  "unittype_id" number,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("protocolparam_id")
);
--
-- Table: pub
--;
CREATE SEQUENCE "sq_pub_pub_id";
CREATE TABLE "pub" (
  "pub_id" number NOT NULL,
  "title" clob,
  "volumetitle" clob,
  "volume" varchar2(255),
  "series_name" varchar2(255),
  "issue" varchar2(255),
  "pyear" varchar2(255),
  "pages" varchar2(255),
  "miniref" varchar2(255),
  "uniquename" varchar2(4000) NOT NULL,
  "type_id" number NOT NULL,
  "is_obsolete" number DEFAULT false,
  "publisher" varchar2(255),
  "pubplace" varchar2(255),
  PRIMARY KEY ("pub_id"),
  CONSTRAINT "pub_c1" UNIQUE ("uniquename")
);
--
-- Table: pub_dbxref
--;
CREATE SEQUENCE "sq_pub_dbxref_pub_dbxref_id";
CREATE TABLE "pub_dbxref" (
  "pub_dbxref_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  "is_current" number DEFAULT true NOT NULL,
  PRIMARY KEY ("pub_dbxref_id"),
  CONSTRAINT "pub_dbxref_c1" UNIQUE ("pub_id", "dbxref_id")
);
--
-- Table: pub_relationship
--;
CREATE SEQUENCE "sq_pub_relationship_pub_relati";
CREATE TABLE "pub_relationship" (
  "pub_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "object_id" number NOT NULL,
  "type_id" number NOT NULL,
  PRIMARY KEY ("pub_relationship_id"),
  CONSTRAINT "pub_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
--
-- Table: pubauthor
--;
CREATE SEQUENCE "sq_pubauthor_pubauthor_id";
CREATE TABLE "pubauthor" (
  "pubauthor_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "rank" number NOT NULL,
  "editor" number DEFAULT false,
  "surname" varchar2(100) NOT NULL,
  "givennames" varchar2(100),
  "suffix" varchar2(100),
  PRIMARY KEY ("pubauthor_id"),
  CONSTRAINT "pubauthor_c1" UNIQUE ("pub_id", "rank")
);
--
-- Table: pubprop
--;
CREATE SEQUENCE "sq_pubprop_pubprop_id";
CREATE TABLE "pubprop" (
  "pubprop_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob NOT NULL,
  "rank" number,
  PRIMARY KEY ("pubprop_id"),
  CONSTRAINT "pubprop_c1" UNIQUE ("pub_id", "type_id", "rank")
);
--
-- Table: quantification
--;
CREATE SEQUENCE "sq_quantification_quantificati";
CREATE TABLE "quantification" (
  "quantification_id" number NOT NULL,
  "acquisition_id" number NOT NULL,
  "operator_id" number,
  "protocol_id" number,
  "analysis_id" number NOT NULL,
  "quantificationdate" date DEFAULT current_timestamp,
  "name" varchar2(4000),
  "uri" clob,
  PRIMARY KEY ("quantification_id"),
  CONSTRAINT "quantification_c1" UNIQUE ("name", "analysis_id")
);
--
-- Table: quantification_relationship
--;
CREATE SEQUENCE "sq_quantification_relationship";
CREATE TABLE "quantification_relationship" (
  "quantification_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "type_id" number NOT NULL,
  "object_id" number NOT NULL,
  PRIMARY KEY ("quantification_relationship_id"),
  CONSTRAINT "quantification_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
--
-- Table: quantificationprop
--;
CREATE SEQUENCE "sq_quantificationprop_quantifi";
CREATE TABLE "quantificationprop" (
  "quantificationprop_id" number NOT NULL,
  "quantification_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("quantificationprop_id"),
  CONSTRAINT "quantificationprop_c1" UNIQUE ("quantification_id", "type_id", "rank")
);
--
-- Table: stats_paths_to_root
--;
CREATE TABLE "stats_paths_to_root" (
  "cvterm_id" number,
  "total_paths" number,
  "avg_distance" number,
  "min_distance" number,
  "max_distance" number
);
--
-- Table: stock
--;
CREATE SEQUENCE "sq_stock_stock_id";
CREATE TABLE "stock" (
  "stock_id" number NOT NULL,
  "dbxref_id" number,
  "organism_id" number,
  "name" varchar2(255),
  "uniquename" varchar2(4000) NOT NULL,
  "description" clob,
  "type_id" number NOT NULL,
  "is_obsolete" number DEFAULT false NOT NULL,
  PRIMARY KEY ("stock_id"),
  CONSTRAINT "stock_c1" UNIQUE ("organism_id", "uniquename", "type_id")
);
--
-- Table: stock_cvterm
--;
CREATE SEQUENCE "sq_stock_cvterm_stock_cvterm_i";
CREATE TABLE "stock_cvterm" (
  "stock_cvterm_id" number NOT NULL,
  "stock_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "pub_id" number NOT NULL,
  "is_not" number DEFAULT false NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("stock_cvterm_id"),
  CONSTRAINT "stock_cvterm_c1" UNIQUE ("stock_id", "cvterm_id", "pub_id", "rank")
);
--
-- Table: stock_cvtermprop
--;
CREATE SEQUENCE "sq_stock_cvtermprop_stock_cvte";
CREATE TABLE "stock_cvtermprop" (
  "stock_cvtermprop_id" number NOT NULL,
  "stock_cvterm_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("stock_cvtermprop_id"),
  CONSTRAINT "stock_cvtermprop_c1" UNIQUE ("stock_cvterm_id", "type_id", "rank")
);
--
-- Table: stock_dbxref
--;
CREATE SEQUENCE "sq_stock_dbxref_stock_dbxref_i";
CREATE TABLE "stock_dbxref" (
  "stock_dbxref_id" number NOT NULL,
  "stock_id" number NOT NULL,
  "dbxref_id" number NOT NULL,
  "is_current" number DEFAULT true NOT NULL,
  PRIMARY KEY ("stock_dbxref_id"),
  CONSTRAINT "stock_dbxref_c1" UNIQUE ("stock_id", "dbxref_id")
);
--
-- Table: stock_dbxrefprop
--;
CREATE SEQUENCE "sq_stock_dbxrefprop_stock_dbxr";
CREATE TABLE "stock_dbxrefprop" (
  "stock_dbxrefprop_id" number NOT NULL,
  "stock_dbxref_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("stock_dbxrefprop_id"),
  CONSTRAINT "stock_dbxrefprop_c1" UNIQUE ("stock_dbxref_id", "type_id", "rank")
);
--
-- Table: stock_genotype
--;
CREATE SEQUENCE "sq_stock_genotype_stock_genoty";
CREATE TABLE "stock_genotype" (
  "stock_genotype_id" number NOT NULL,
  "stock_id" number NOT NULL,
  "genotype_id" number NOT NULL,
  PRIMARY KEY ("stock_genotype_id"),
  CONSTRAINT "stock_genotype_c1" UNIQUE ("stock_id", "genotype_id")
);
--
-- Table: stock_pub
--;
CREATE SEQUENCE "sq_stock_pub_stock_pub_id";
CREATE TABLE "stock_pub" (
  "stock_pub_id" number NOT NULL,
  "stock_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("stock_pub_id"),
  CONSTRAINT "stock_pub_c1" UNIQUE ("stock_id", "pub_id")
);
--
-- Table: stock_relationship
--;
CREATE SEQUENCE "sq_stock_relationship_stock_re";
CREATE TABLE "stock_relationship" (
  "stock_relationship_id" number NOT NULL,
  "subject_id" number NOT NULL,
  "object_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("stock_relationship_id"),
  CONSTRAINT "stock_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
--
-- Table: stock_relationship_cvterm
--;
CREATE SEQUENCE "sq_stock_relationship_cvterm_s";
CREATE TABLE "stock_relationship_cvterm" (
  "stock_relationship_cvterm_id" number NOT NULL,
  "stock_relationship_id" number NOT NULL,
  "cvterm_id" number NOT NULL,
  "pub_id" number,
  PRIMARY KEY ("stock_relationship_cvterm_id")
);
--
-- Table: stock_relationship_pub
--;
CREATE SEQUENCE "sq_stock_relationship_pub_stoc";
CREATE TABLE "stock_relationship_pub" (
  "stock_relationship_pub_id" number NOT NULL,
  "stock_relationship_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("stock_relationship_pub_id"),
  CONSTRAINT "stock_relationship_pub_c1" UNIQUE ("stock_relationship_id", "pub_id")
);
--
-- Table: stockcollection
--;
CREATE SEQUENCE "sq_stockcollection_stockcollec";
CREATE TABLE "stockcollection" (
  "stockcollection_id" number NOT NULL,
  "type_id" number NOT NULL,
  "contact_id" number,
  "name" varchar2(255),
  "uniquename" varchar2(4000) NOT NULL,
  PRIMARY KEY ("stockcollection_id"),
  CONSTRAINT "stockcollection_c1" UNIQUE ("uniquename", "type_id")
);
--
-- Table: stockcollection_stock
--;
CREATE SEQUENCE "sq_stockcollection_stock_stock";
CREATE TABLE "stockcollection_stock" (
  "stockcollection_stock_id" number NOT NULL,
  "stockcollection_id" number NOT NULL,
  "stock_id" number NOT NULL,
  PRIMARY KEY ("stockcollection_stock_id"),
  CONSTRAINT "stockcollection_stock_c1" UNIQUE ("stockcollection_id", "stock_id")
);
--
-- Table: stockcollectionprop
--;
CREATE SEQUENCE "sq_stockcollectionprop_stockco";
CREATE TABLE "stockcollectionprop" (
  "stockcollectionprop_id" number NOT NULL,
  "stockcollection_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("stockcollectionprop_id"),
  CONSTRAINT "stockcollectionprop_c1" UNIQUE ("stockcollection_id", "type_id", "rank")
);
--
-- Table: stockprop
--;
CREATE SEQUENCE "sq_stockprop_stockprop_id";
CREATE TABLE "stockprop" (
  "stockprop_id" number NOT NULL,
  "stock_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("stockprop_id"),
  CONSTRAINT "stockprop_c1" UNIQUE ("stock_id", "type_id", "rank")
);
--
-- Table: stockprop_pub
--;
CREATE SEQUENCE "sq_stockprop_pub_stockprop_pub";
CREATE TABLE "stockprop_pub" (
  "stockprop_pub_id" number NOT NULL,
  "stockprop_id" number NOT NULL,
  "pub_id" number NOT NULL,
  PRIMARY KEY ("stockprop_pub_id"),
  CONSTRAINT "stockprop_pub_c1" UNIQUE ("stockprop_id", "pub_id")
);
--
-- Table: study
--;
CREATE SEQUENCE "sq_study_study_id";
CREATE TABLE "study" (
  "study_id" number NOT NULL,
  "contact_id" number NOT NULL,
  "pub_id" number,
  "dbxref_id" number,
  "name" varchar2(4000) NOT NULL,
  "description" clob,
  PRIMARY KEY ("study_id"),
  CONSTRAINT "study_c1" UNIQUE ("name")
);
--
-- Table: study_assay
--;
CREATE SEQUENCE "sq_study_assay_study_assay_id";
CREATE TABLE "study_assay" (
  "study_assay_id" number NOT NULL,
  "study_id" number NOT NULL,
  "assay_id" number NOT NULL,
  PRIMARY KEY ("study_assay_id"),
  CONSTRAINT "study_assay_c1" UNIQUE ("study_id", "assay_id")
);
--
-- Table: studydesign
--;
CREATE SEQUENCE "sq_studydesign_studydesign_id";
CREATE TABLE "studydesign" (
  "studydesign_id" number NOT NULL,
  "study_id" number NOT NULL,
  "description" clob,
  PRIMARY KEY ("studydesign_id")
);
--
-- Table: studydesignprop
--;
CREATE SEQUENCE "sq_studydesignprop_studydesign";
CREATE TABLE "studydesignprop" (
  "studydesignprop_id" number NOT NULL,
  "studydesign_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("studydesignprop_id"),
  CONSTRAINT "studydesignprop_c1" UNIQUE ("studydesign_id", "type_id", "rank")
);
--
-- Table: studyfactor
--;
CREATE SEQUENCE "sq_studyfactor_studyfactor_id";
CREATE TABLE "studyfactor" (
  "studyfactor_id" number NOT NULL,
  "studydesign_id" number NOT NULL,
  "type_id" number,
  "name" clob NOT NULL,
  "description" clob,
  PRIMARY KEY ("studyfactor_id")
);
--
-- Table: studyfactorvalue
--;
CREATE SEQUENCE "sq_studyfactorvalue_studyfacto";
CREATE TABLE "studyfactorvalue" (
  "studyfactorvalue_id" number NOT NULL,
  "studyfactor_id" number NOT NULL,
  "assay_id" number NOT NULL,
  "factorvalue" clob,
  "name" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("studyfactorvalue_id")
);
--
-- Table: studyprop
--;
CREATE SEQUENCE "sq_studyprop_studyprop_id";
CREATE TABLE "studyprop" (
  "studyprop_id" number NOT NULL,
  "study_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("studyprop_id"),
  CONSTRAINT "studyprop_study_id_key" UNIQUE ("study_id", "type_id", "rank")
);
--
-- Table: studyprop_feature
--;
CREATE SEQUENCE "sq_studyprop_feature_studyprop";
CREATE TABLE "studyprop_feature" (
  "studyprop_feature_id" number NOT NULL,
  "studyprop_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "type_id" number,
  PRIMARY KEY ("studyprop_feature_id"),
  CONSTRAINT "studyprop_feature_studyprop_id_key" UNIQUE ("studyprop_id", "feature_id")
);
--
-- Table: synonym_
--;
CREATE SEQUENCE "sq_synonym__synonym_id";
CREATE TABLE "synonym_" (
  "synonym_id" number NOT NULL,
  "name" varchar2(255) NOT NULL,
  "type_id" number NOT NULL,
  "synonym_sgml" varchar2(255) NOT NULL,
  PRIMARY KEY ("synonym_id"),
  CONSTRAINT "synonym_c1" UNIQUE ("name", "type_id")
);
--
-- Table: tableinfo
--;
CREATE SEQUENCE "sq_tableinfo_tableinfo_id";
CREATE TABLE "tableinfo" (
  "tableinfo_id" number NOT NULL,
  "name" varchar2(30) NOT NULL,
  "primary_key_column" varchar2(30),
  "is_view" number DEFAULT '0' NOT NULL,
  "view_on_table_id" number,
  "superclass_table_id" number,
  "is_updateable" number DEFAULT '1' NOT NULL,
  "modification_date" date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("tableinfo_id"),
  CONSTRAINT "tableinfo_c1" UNIQUE ("name")
);
--
-- Table: treatment
--;
CREATE SEQUENCE "sq_treatment_treatment_id";
CREATE TABLE "treatment" (
  "treatment_id" number NOT NULL,
  "rank" number DEFAULT '0' NOT NULL,
  "biomaterial_id" number NOT NULL,
  "type_id" number NOT NULL,
  "protocol_id" number,
  "name" clob,
  PRIMARY KEY ("treatment_id")
);
--
-- Table: type_feature_count
--;
CREATE TABLE "type_feature_count" (
  "type" varchar2(1024),
  "num_features" number
);
--
-- Table: featureprop
--;
CREATE SEQUENCE "sq_featureprop_featureprop_id";
CREATE TABLE "featureprop" (
  "featureprop_id" number NOT NULL,
  "feature_id" number NOT NULL,
  "type_id" number NOT NULL,
  "value" clob,
  "rank" number DEFAULT '0' NOT NULL,
  PRIMARY KEY ("featureprop_id"),
  CONSTRAINT "featureprop_c1" UNIQUE ("feature_id", "type_id", "rank")
);
ALTER TABLE "acquisition" ADD CONSTRAINT "acquisition_assay_id_fk" FOREIGN KEY ("assay_id") REFERENCES "assay" ("assay_id") ON DELETE CASCADE;
ALTER TABLE "acquisition" ADD CONSTRAINT "acquisition_channel_id_fk" FOREIGN KEY ("channel_id") REFERENCES "channel" ("channel_id") ON DELETE CASCADE;
ALTER TABLE "acquisition" ADD CONSTRAINT "acquisition_protocol_id_fk" FOREIGN KEY ("protocol_id") REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE;
ALTER TABLE "acquisition_relationship" ADD CONSTRAINT "acquisition_relationship_objec" FOREIGN KEY ("object_id") REFERENCES "acquisition" ("acquisition_id") ON DELETE CASCADE;
ALTER TABLE "acquisition_relationship" ADD CONSTRAINT "acquisition_relationship_subje" FOREIGN KEY ("subject_id") REFERENCES "acquisition" ("acquisition_id") ON DELETE CASCADE;
ALTER TABLE "acquisition_relationship" ADD CONSTRAINT "acquisition_relationship_type_" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "acquisitionprop" ADD CONSTRAINT "acquisitionprop_acquisition_id" FOREIGN KEY ("acquisition_id") REFERENCES "acquisition" ("acquisition_id") ON DELETE CASCADE;
ALTER TABLE "acquisitionprop" ADD CONSTRAINT "acquisitionprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "analysisfeature" ADD CONSTRAINT "analysisfeature_analysis_id_fk" FOREIGN KEY ("analysis_id") REFERENCES "analysis" ("analysis_id") ON DELETE CASCADE;
ALTER TABLE "analysisfeature" ADD CONSTRAINT "analysisfeature_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "analysisfeatureprop" ADD CONSTRAINT "analysisfeatureprop_analysisfe" FOREIGN KEY ("analysisfeature_id") REFERENCES "analysisfeature" ("analysisfeature_id") ON DELETE CASCADE;
ALTER TABLE "analysisfeatureprop" ADD CONSTRAINT "analysisfeatureprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "analysisprop" ADD CONSTRAINT "analysisprop_analysis_id_fk" FOREIGN KEY ("analysis_id") REFERENCES "analysis" ("analysis_id") ON DELETE CASCADE;
ALTER TABLE "analysisprop" ADD CONSTRAINT "analysisprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "arraydesign" ADD CONSTRAINT "arraydesign_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "arraydesign" ADD CONSTRAINT "arraydesign_manufacturer_id_fk" FOREIGN KEY ("manufacturer_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "arraydesign" ADD CONSTRAINT "arraydesign_platformtype_id_fk" FOREIGN KEY ("platformtype_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "arraydesign" ADD CONSTRAINT "arraydesign_protocol_id_fk" FOREIGN KEY ("protocol_id") REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE;
ALTER TABLE "arraydesign" ADD CONSTRAINT "arraydesign_substratetype_id_f" FOREIGN KEY ("substratetype_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "arraydesignprop" ADD CONSTRAINT "arraydesignprop_arraydesign_id" FOREIGN KEY ("arraydesign_id") REFERENCES "arraydesign" ("arraydesign_id") ON DELETE CASCADE;
ALTER TABLE "arraydesignprop" ADD CONSTRAINT "arraydesignprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "assay" ADD CONSTRAINT "assay_arraydesign_id_fk" FOREIGN KEY ("arraydesign_id") REFERENCES "arraydesign" ("arraydesign_id") ON DELETE CASCADE;
ALTER TABLE "assay" ADD CONSTRAINT "assay_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "assay" ADD CONSTRAINT "assay_operator_id_fk" FOREIGN KEY ("operator_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "assay" ADD CONSTRAINT "assay_protocol_id_fk" FOREIGN KEY ("protocol_id") REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE;
ALTER TABLE "assay_biomaterial" ADD CONSTRAINT "assay_biomaterial_assay_id_fk" FOREIGN KEY ("assay_id") REFERENCES "assay" ("assay_id") ON DELETE CASCADE;
ALTER TABLE "assay_biomaterial" ADD CONSTRAINT "assay_biomaterial_biomaterial_" FOREIGN KEY ("biomaterial_id") REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE;
ALTER TABLE "assay_biomaterial" ADD CONSTRAINT "assay_biomaterial_channel_id_f" FOREIGN KEY ("channel_id") REFERENCES "channel" ("channel_id") ON DELETE CASCADE;
ALTER TABLE "assay_project" ADD CONSTRAINT "assay_project_assay_id_fk" FOREIGN KEY ("assay_id") REFERENCES "assay" ("assay_id") ON DELETE CASCADE;
ALTER TABLE "assay_project" ADD CONSTRAINT "assay_project_project_id_fk" FOREIGN KEY ("project_id") REFERENCES "project" ("project_id") ON DELETE CASCADE;
ALTER TABLE "assayprop" ADD CONSTRAINT "assayprop_assay_id_fk" FOREIGN KEY ("assay_id") REFERENCES "assay" ("assay_id") ON DELETE CASCADE;
ALTER TABLE "assayprop" ADD CONSTRAINT "assayprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial" ADD CONSTRAINT "biomaterial_biosourceprovider_" FOREIGN KEY ("biosourceprovider_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial" ADD CONSTRAINT "biomaterial_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial" ADD CONSTRAINT "biomaterial_taxon_id_fk" FOREIGN KEY ("taxon_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial_dbxref" ADD CONSTRAINT "biomaterial_dbxref_biomaterial" FOREIGN KEY ("biomaterial_id") REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial_dbxref" ADD CONSTRAINT "biomaterial_dbxref_dbxref_id_f" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial_relationship" ADD CONSTRAINT "biomaterial_relationship_objec" FOREIGN KEY ("object_id") REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial_relationship" ADD CONSTRAINT "biomaterial_relationship_subje" FOREIGN KEY ("subject_id") REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial_relationship" ADD CONSTRAINT "biomaterial_relationship_type_" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial_treatment" ADD CONSTRAINT "biomaterial_treatment_biomater" FOREIGN KEY ("biomaterial_id") REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial_treatment" ADD CONSTRAINT "biomaterial_treatment_treatmen" FOREIGN KEY ("treatment_id") REFERENCES "treatment" ("treatment_id") ON DELETE CASCADE;
ALTER TABLE "biomaterial_treatment" ADD CONSTRAINT "biomaterial_treatment_unittype" FOREIGN KEY ("unittype_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "biomaterialprop" ADD CONSTRAINT "biomaterialprop_biomaterial_id" FOREIGN KEY ("biomaterial_id") REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE;
ALTER TABLE "biomaterialprop" ADD CONSTRAINT "biomaterialprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cell_line" ADD CONSTRAINT "cell_line_organism_id_fk" FOREIGN KEY ("organism_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_cvterm" ADD CONSTRAINT "cell_line_cvterm_cell_line_id_" FOREIGN KEY ("cell_line_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_cvterm" ADD CONSTRAINT "cell_line_cvterm_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_cvterm" ADD CONSTRAINT "cell_line_cvterm_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_cvtermprop" ADD CONSTRAINT "cell_line_cvtermprop_cell_line" FOREIGN KEY ("cell_line_cvterm_id") REFERENCES "cell_line_cvterm" ("cell_line_cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_cvtermprop" ADD CONSTRAINT "cell_line_cvtermprop_type_id_f" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_dbxref" ADD CONSTRAINT "cell_line_dbxref_cell_line_id_" FOREIGN KEY ("cell_line_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_dbxref" ADD CONSTRAINT "cell_line_dbxref_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_feature" ADD CONSTRAINT "cell_line_feature_cell_line_id" FOREIGN KEY ("cell_line_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_feature" ADD CONSTRAINT "cell_line_feature_feature_id_f" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_feature" ADD CONSTRAINT "cell_line_feature_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_library" ADD CONSTRAINT "cell_line_library_cell_line_id" FOREIGN KEY ("cell_line_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_library" ADD CONSTRAINT "cell_line_library_library_id_f" FOREIGN KEY ("library_id") REFERENCES "library" ("library_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_library" ADD CONSTRAINT "cell_line_library_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_pub" ADD CONSTRAINT "cell_line_pub_cell_line_id_fk" FOREIGN KEY ("cell_line_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_pub" ADD CONSTRAINT "cell_line_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_relationship" ADD CONSTRAINT "cell_line_relationship_object_" FOREIGN KEY ("object_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_relationship" ADD CONSTRAINT "cell_line_relationship_subject" FOREIGN KEY ("subject_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_relationship" ADD CONSTRAINT "cell_line_relationship_type_id" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_synonym" ADD CONSTRAINT "cell_line_synonym_cell_line_id" FOREIGN KEY ("cell_line_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_synonym" ADD CONSTRAINT "cell_line_synonym_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "cell_line_synonym" ADD CONSTRAINT "cell_line_synonym_synonym_id_f" FOREIGN KEY ("synonym_id") REFERENCES "synonym_" ("synonym_id") ON DELETE CASCADE;
ALTER TABLE "cell_lineprop" ADD CONSTRAINT "cell_lineprop_cell_line_id_fk" FOREIGN KEY ("cell_line_id") REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE;
ALTER TABLE "cell_lineprop" ADD CONSTRAINT "cell_lineprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cell_lineprop_pub" ADD CONSTRAINT "cell_lineprop_pub_cell_linepro" FOREIGN KEY ("cell_lineprop_id") REFERENCES "cell_lineprop" ("cell_lineprop_id") ON DELETE CASCADE;
ALTER TABLE "cell_lineprop_pub" ADD CONSTRAINT "cell_lineprop_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "contact" ADD CONSTRAINT "contact_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "contact_relationship" ADD CONSTRAINT "contact_relationship_object_id" FOREIGN KEY ("object_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "contact_relationship" ADD CONSTRAINT "contact_relationship_subject_i" FOREIGN KEY ("subject_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "contact_relationship" ADD CONSTRAINT "contact_relationship_type_id_f" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "control" ADD CONSTRAINT "control_assay_id_fk" FOREIGN KEY ("assay_id") REFERENCES "assay" ("assay_id") ON DELETE CASCADE;
ALTER TABLE "control" ADD CONSTRAINT "control_tableinfo_id_fk" FOREIGN KEY ("tableinfo_id") REFERENCES "tableinfo" ("tableinfo_id") ON DELETE CASCADE;
ALTER TABLE "control" ADD CONSTRAINT "control_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvprop" ADD CONSTRAINT "cvprop_cv_id_fk" FOREIGN KEY ("cv_id") REFERENCES "cv" ("cv_id") ON DELETE CASCADE;
ALTER TABLE "cvprop" ADD CONSTRAINT "cvprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvterm" ADD CONSTRAINT "cvterm_cv_id_fk" FOREIGN KEY ("cv_id") REFERENCES "cv" ("cv_id") ON DELETE CASCADE;
ALTER TABLE "cvterm" ADD CONSTRAINT "cvterm_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "cvterm_dbxref" ADD CONSTRAINT "cvterm_dbxref_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvterm_dbxref" ADD CONSTRAINT "cvterm_dbxref_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "cvterm_relationship" ADD CONSTRAINT "cvterm_relationship_object_id_" FOREIGN KEY ("object_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvterm_relationship" ADD CONSTRAINT "cvterm_relationship_subject_id" FOREIGN KEY ("subject_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvterm_relationship" ADD CONSTRAINT "cvterm_relationship_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvtermpath" ADD CONSTRAINT "cvtermpath_cv_id_fk" FOREIGN KEY ("cv_id") REFERENCES "cv" ("cv_id") ON DELETE CASCADE;
ALTER TABLE "cvtermpath" ADD CONSTRAINT "cvtermpath_object_id_fk" FOREIGN KEY ("object_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvtermpath" ADD CONSTRAINT "cvtermpath_subject_id_fk" FOREIGN KEY ("subject_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvtermpath" ADD CONSTRAINT "cvtermpath_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvtermprop" ADD CONSTRAINT "cvtermprop_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvtermprop" ADD CONSTRAINT "cvtermprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvtermsynonym" ADD CONSTRAINT "cvtermsynonym_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "cvtermsynonym" ADD CONSTRAINT "cvtermsynonym_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "dbxref" ADD CONSTRAINT "dbxref_db_id_fk" FOREIGN KEY ("db_id") REFERENCES "db" ("db_id") ON DELETE CASCADE;
ALTER TABLE "dbxrefprop" ADD CONSTRAINT "dbxrefprop_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "dbxrefprop" ADD CONSTRAINT "dbxrefprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "element" ADD CONSTRAINT "element_arraydesign_id_fk" FOREIGN KEY ("arraydesign_id") REFERENCES "arraydesign" ("arraydesign_id") ON DELETE CASCADE;
ALTER TABLE "element" ADD CONSTRAINT "element_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "element" ADD CONSTRAINT "element_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "element" ADD CONSTRAINT "element_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "element_relationship" ADD CONSTRAINT "element_relationship_object_id" FOREIGN KEY ("object_id") REFERENCES "element" ("element_id") ON DELETE CASCADE;
ALTER TABLE "element_relationship" ADD CONSTRAINT "element_relationship_subject_i" FOREIGN KEY ("subject_id") REFERENCES "element" ("element_id") ON DELETE CASCADE;
ALTER TABLE "element_relationship" ADD CONSTRAINT "element_relationship_type_id_f" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "elementresult" ADD CONSTRAINT "elementresult_element_id_fk" FOREIGN KEY ("element_id") REFERENCES "element" ("element_id") ON DELETE CASCADE;
ALTER TABLE "elementresult" ADD CONSTRAINT "elementresult_quantification_i" FOREIGN KEY ("quantification_id") REFERENCES "quantification" ("quantification_id") ON DELETE CASCADE;
ALTER TABLE "elementresult_relationship" ADD CONSTRAINT "elementresult_relationship_obj" FOREIGN KEY ("object_id") REFERENCES "elementresult" ("elementresult_id") ON DELETE CASCADE;
ALTER TABLE "elementresult_relationship" ADD CONSTRAINT "elementresult_relationship_sub" FOREIGN KEY ("subject_id") REFERENCES "elementresult" ("elementresult_id") ON DELETE CASCADE;
ALTER TABLE "elementresult_relationship" ADD CONSTRAINT "elementresult_relationship_typ" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "environment_cvterm" ADD CONSTRAINT "environment_cvterm_cvterm_id_f" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "environment_cvterm" ADD CONSTRAINT "environment_cvterm_environment" FOREIGN KEY ("environment_id") REFERENCES "environment" ("environment_id") ON DELETE CASCADE;
ALTER TABLE "expression_cvterm" ADD CONSTRAINT "expression_cvterm_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "expression_cvterm" ADD CONSTRAINT "expression_cvterm_cvterm_type_" FOREIGN KEY ("cvterm_type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "expression_cvterm" ADD CONSTRAINT "expression_cvterm_expression_i" FOREIGN KEY ("expression_id") REFERENCES "expression" ("expression_id") ON DELETE CASCADE;
ALTER TABLE "expression_cvtermprop" ADD CONSTRAINT "expression_cvtermprop_expressi" FOREIGN KEY ("expression_cvterm_id") REFERENCES "expression_cvterm" ("expression_cvterm_id") ON DELETE CASCADE;
ALTER TABLE "expression_cvtermprop" ADD CONSTRAINT "expression_cvtermprop_type_id_" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "expression_image" ADD CONSTRAINT "expression_image_eimage_id_fk" FOREIGN KEY ("eimage_id") REFERENCES "eimage" ("eimage_id") ON DELETE CASCADE;
ALTER TABLE "expression_image" ADD CONSTRAINT "expression_image_expression_id" FOREIGN KEY ("expression_id") REFERENCES "expression" ("expression_id") ON DELETE CASCADE;
ALTER TABLE "expression_pub" ADD CONSTRAINT "expression_pub_expression_id_f" FOREIGN KEY ("expression_id") REFERENCES "expression" ("expression_id") ON DELETE CASCADE;
ALTER TABLE "expression_pub" ADD CONSTRAINT "expression_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "expressionprop" ADD CONSTRAINT "expressionprop_expression_id_f" FOREIGN KEY ("expression_id") REFERENCES "expression" ("expression_id") ON DELETE CASCADE;
ALTER TABLE "expressionprop" ADD CONSTRAINT "expressionprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature" ADD CONSTRAINT "feature_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "feature" ADD CONSTRAINT "feature_organism_id_fk" FOREIGN KEY ("organism_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "feature" ADD CONSTRAINT "feature_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvterm" ADD CONSTRAINT "feature_cvterm_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvterm" ADD CONSTRAINT "feature_cvterm_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvterm" ADD CONSTRAINT "feature_cvterm_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvterm_dbxref" ADD CONSTRAINT "feature_cvterm_dbxref_dbxref_i" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvterm_dbxref" ADD CONSTRAINT "feature_cvterm_dbxref_feature_" FOREIGN KEY ("feature_cvterm_id") REFERENCES "feature_cvterm" ("feature_cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvterm_pub" ADD CONSTRAINT "feature_cvterm_pub_feature_cvt" FOREIGN KEY ("feature_cvterm_id") REFERENCES "feature_cvterm" ("feature_cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvterm_pub" ADD CONSTRAINT "feature_cvterm_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvtermprop" ADD CONSTRAINT "feature_cvtermprop_feature_cvt" FOREIGN KEY ("feature_cvterm_id") REFERENCES "feature_cvterm" ("feature_cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_cvtermprop" ADD CONSTRAINT "feature_cvtermprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_dbxref" ADD CONSTRAINT "feature_dbxref_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "feature_dbxref" ADD CONSTRAINT "feature_dbxref_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_expression" ADD CONSTRAINT "feature_expression_expression_" FOREIGN KEY ("expression_id") REFERENCES "expression" ("expression_id") ON DELETE CASCADE;
ALTER TABLE "feature_expression" ADD CONSTRAINT "feature_expression_feature_id_" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_expression" ADD CONSTRAINT "feature_expression_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "feature_expressionprop" ADD CONSTRAINT "feature_expressionprop_feature" FOREIGN KEY ("feature_expression_id") REFERENCES "feature_expression" ("feature_expression_id") ON DELETE CASCADE;
ALTER TABLE "feature_expressionprop" ADD CONSTRAINT "feature_expressionprop_type_id" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_genotype" ADD CONSTRAINT "feature_genotype_chromosome_id" FOREIGN KEY ("chromosome_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_genotype" ADD CONSTRAINT "feature_genotype_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_genotype" ADD CONSTRAINT "feature_genotype_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_genotype" ADD CONSTRAINT "feature_genotype_genotype_id_f" FOREIGN KEY ("genotype_id") REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE;
ALTER TABLE "feature_phenotype" ADD CONSTRAINT "feature_phenotype_feature_id_f" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_phenotype" ADD CONSTRAINT "feature_phenotype_phenotype_id" FOREIGN KEY ("phenotype_id") REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE;
ALTER TABLE "feature_pub" ADD CONSTRAINT "feature_pub_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_pub" ADD CONSTRAINT "feature_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "feature_pubprop" ADD CONSTRAINT "feature_pubprop_feature_pub_id" FOREIGN KEY ("feature_pub_id") REFERENCES "feature_pub" ("feature_pub_id") ON DELETE CASCADE;
ALTER TABLE "feature_pubprop" ADD CONSTRAINT "feature_pubprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationship" ADD CONSTRAINT "feature_relationship_object_id" FOREIGN KEY ("object_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationship" ADD CONSTRAINT "feature_relationship_subject_i" FOREIGN KEY ("subject_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationship" ADD CONSTRAINT "feature_relationship_type_id_f" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationship_pub" ADD CONSTRAINT "feature_relationship_pub_featu" FOREIGN KEY ("feature_relationship_id") REFERENCES "feature_relationship" ("feature_relationship_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationship_pub" ADD CONSTRAINT "feature_relationship_pub_pub_i" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationshipprop" ADD CONSTRAINT "feature_relationshipprop_featu" FOREIGN KEY ("feature_relationship_id") REFERENCES "feature_relationship" ("feature_relationship_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationshipprop" ADD CONSTRAINT "feature_relationshipprop_type_" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationshipprop_pub" ADD CONSTRAINT "feature_relationshipprop_pub_f" FOREIGN KEY ("feature_relationshipprop_id") REFERENCES "feature_relationshipprop" ("feature_relationshipprop_id") ON DELETE CASCADE;
ALTER TABLE "feature_relationshipprop_pub" ADD CONSTRAINT "feature_relationshipprop_pub_p" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "feature_synonym" ADD CONSTRAINT "feature_synonym_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "feature_synonym" ADD CONSTRAINT "feature_synonym_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "feature_synonym" ADD CONSTRAINT "feature_synonym_synonym_id_fk" FOREIGN KEY ("synonym_id") REFERENCES "synonym_" ("synonym_id") ON DELETE CASCADE;
ALTER TABLE "featureloc" ADD CONSTRAINT "featureloc_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "featureloc" ADD CONSTRAINT "featureloc_srcfeature_id_fk" FOREIGN KEY ("srcfeature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "featureloc_pub" ADD CONSTRAINT "featureloc_pub_featureloc_id_f" FOREIGN KEY ("featureloc_id") REFERENCES "featureloc" ("featureloc_id") ON DELETE CASCADE;
ALTER TABLE "featureloc_pub" ADD CONSTRAINT "featureloc_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "featuremap" ADD CONSTRAINT "featuremap_unittype_id_fk" FOREIGN KEY ("unittype_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "featuremap_pub" ADD CONSTRAINT "featuremap_pub_featuremap_id_f" FOREIGN KEY ("featuremap_id") REFERENCES "featuremap" ("featuremap_id") ON DELETE CASCADE;
ALTER TABLE "featuremap_pub" ADD CONSTRAINT "featuremap_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "featurepos" ADD CONSTRAINT "featurepos_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "featurepos" ADD CONSTRAINT "featurepos_featuremap_id_fk" FOREIGN KEY ("featuremap_id") REFERENCES "featuremap" ("featuremap_id") ON DELETE CASCADE;
ALTER TABLE "featurepos" ADD CONSTRAINT "featurepos_map_feature_id_fk" FOREIGN KEY ("map_feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "featureprop_pub" ADD CONSTRAINT "featureprop_pub_featureprop_id" FOREIGN KEY ("featureprop_id") REFERENCES "featureprop" ("featureprop_id") ON DELETE CASCADE;
ALTER TABLE "featureprop_pub" ADD CONSTRAINT "featureprop_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "featurerange" ADD CONSTRAINT "featurerange_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "featurerange" ADD CONSTRAINT "featurerange_featuremap_id_fk" FOREIGN KEY ("featuremap_id") REFERENCES "featuremap" ("featuremap_id") ON DELETE CASCADE;
ALTER TABLE "featurerange" ADD CONSTRAINT "featurerange_leftendf_id_fk" FOREIGN KEY ("leftendf_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "featurerange" ADD CONSTRAINT "featurerange_leftstartf_id_fk" FOREIGN KEY ("leftstartf_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "featurerange" ADD CONSTRAINT "featurerange_rightendf_id_fk" FOREIGN KEY ("rightendf_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "featurerange" ADD CONSTRAINT "featurerange_rightstartf_id_fk" FOREIGN KEY ("rightstartf_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "genotype" ADD CONSTRAINT "genotype_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "genotypeprop" ADD CONSTRAINT "genotypeprop_genotype_id_fk" FOREIGN KEY ("genotype_id") REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE;
ALTER TABLE "genotypeprop" ADD CONSTRAINT "genotypeprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "library" ADD CONSTRAINT "library_organism_id_fk" FOREIGN KEY ("organism_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "library" ADD CONSTRAINT "library_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "library_cvterm" ADD CONSTRAINT "library_cvterm_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "library_cvterm" ADD CONSTRAINT "library_cvterm_library_id_fk" FOREIGN KEY ("library_id") REFERENCES "library" ("library_id") ON DELETE CASCADE;
ALTER TABLE "library_cvterm" ADD CONSTRAINT "library_cvterm_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "library_dbxref" ADD CONSTRAINT "library_dbxref_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "library_dbxref" ADD CONSTRAINT "library_dbxref_library_id_fk" FOREIGN KEY ("library_id") REFERENCES "library" ("library_id") ON DELETE CASCADE;
ALTER TABLE "library_feature" ADD CONSTRAINT "library_feature_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "library_feature" ADD CONSTRAINT "library_feature_library_id_fk" FOREIGN KEY ("library_id") REFERENCES "library" ("library_id") ON DELETE CASCADE;
ALTER TABLE "library_pub" ADD CONSTRAINT "library_pub_library_id_fk" FOREIGN KEY ("library_id") REFERENCES "library" ("library_id") ON DELETE CASCADE;
ALTER TABLE "library_pub" ADD CONSTRAINT "library_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "library_synonym" ADD CONSTRAINT "library_synonym_library_id_fk" FOREIGN KEY ("library_id") REFERENCES "library" ("library_id") ON DELETE CASCADE;
ALTER TABLE "library_synonym" ADD CONSTRAINT "library_synonym_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "library_synonym" ADD CONSTRAINT "library_synonym_synonym_id_fk" FOREIGN KEY ("synonym_id") REFERENCES "synonym_" ("synonym_id") ON DELETE CASCADE;
ALTER TABLE "libraryprop" ADD CONSTRAINT "libraryprop_library_id_fk" FOREIGN KEY ("library_id") REFERENCES "library" ("library_id") ON DELETE CASCADE;
ALTER TABLE "libraryprop" ADD CONSTRAINT "libraryprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "libraryprop_pub" ADD CONSTRAINT "libraryprop_pub_libraryprop_id" FOREIGN KEY ("libraryprop_id") REFERENCES "libraryprop" ("libraryprop_id") ON DELETE CASCADE;
ALTER TABLE "libraryprop_pub" ADD CONSTRAINT "libraryprop_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "magedocumentation" ADD CONSTRAINT "magedocumentation_mageml_id_fk" FOREIGN KEY ("mageml_id") REFERENCES "mageml" ("mageml_id") ON DELETE CASCADE;
ALTER TABLE "magedocumentation" ADD CONSTRAINT "magedocumentation_tableinfo_id" FOREIGN KEY ("tableinfo_id") REFERENCES "tableinfo" ("tableinfo_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment" ADD CONSTRAINT "nd_experiment_nd_geolocation_i" FOREIGN KEY ("nd_geolocation_id") REFERENCES "nd_geolocation" ("nd_geolocation_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment" ADD CONSTRAINT "nd_experiment_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_contact" ADD CONSTRAINT "nd_experiment_contact_contact_" FOREIGN KEY ("contact_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_contact" ADD CONSTRAINT "nd_experiment_contact_nd_exper" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_dbxref" ADD CONSTRAINT "nd_experiment_dbxref_dbxref_id" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_dbxref" ADD CONSTRAINT "nd_experiment_dbxref_nd_experi" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_genotype" ADD CONSTRAINT "nd_experiment_genotype_genotyp" FOREIGN KEY ("genotype_id") REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_genotype" ADD CONSTRAINT "nd_experiment_genotype_nd_expe" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_phenotype" ADD CONSTRAINT "nd_experiment_phenotype_nd_exp" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_phenotype" ADD CONSTRAINT "nd_experiment_phenotype_phenot" FOREIGN KEY ("phenotype_id") REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_project" ADD CONSTRAINT "nd_experiment_project_nd_exper" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_project" ADD CONSTRAINT "nd_experiment_project_project_" FOREIGN KEY ("project_id") REFERENCES "project" ("project_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_protocol" ADD CONSTRAINT "nd_experiment_protocol_nd_expe" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_protocol" ADD CONSTRAINT "nd_experiment_protocol_nd_prot" FOREIGN KEY ("nd_protocol_id") REFERENCES "nd_protocol" ("nd_protocol_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_pub" ADD CONSTRAINT "nd_experiment_pub_nd_experimen" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_pub" ADD CONSTRAINT "nd_experiment_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_stock" ADD CONSTRAINT "nd_experiment_stock_nd_experim" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_stock" ADD CONSTRAINT "nd_experiment_stock_stock_id_f" FOREIGN KEY ("stock_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_stock" ADD CONSTRAINT "nd_experiment_stock_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_stock_dbxref" ADD CONSTRAINT "nd_experiment_stock_dbxref_dbx" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_stock_dbxref" ADD CONSTRAINT "nd_experiment_stock_dbxref_nd_" FOREIGN KEY ("nd_experiment_stock_id") REFERENCES "nd_experiment_stock" ("nd_experiment_stock_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_stockprop" ADD CONSTRAINT "nd_experiment_stockprop_nd_exp" FOREIGN KEY ("nd_experiment_stock_id") REFERENCES "nd_experiment_stock" ("nd_experiment_stock_id") ON DELETE CASCADE;
ALTER TABLE "nd_experiment_stockprop" ADD CONSTRAINT "nd_experiment_stockprop_type_i" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_experimentprop" ADD CONSTRAINT "nd_experimentprop_nd_experimen" FOREIGN KEY ("nd_experiment_id") REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE;
ALTER TABLE "nd_experimentprop" ADD CONSTRAINT "nd_experimentprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_geolocationprop" ADD CONSTRAINT "nd_geolocationprop_nd_geolocat" FOREIGN KEY ("nd_geolocation_id") REFERENCES "nd_geolocation" ("nd_geolocation_id") ON DELETE CASCADE;
ALTER TABLE "nd_geolocationprop" ADD CONSTRAINT "nd_geolocationprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_protocol" ADD CONSTRAINT "nd_protocol_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_protocol_reagent" ADD CONSTRAINT "nd_protocol_reagent_nd_protoco" FOREIGN KEY ("nd_protocol_id") REFERENCES "nd_protocol" ("nd_protocol_id") ON DELETE CASCADE;
ALTER TABLE "nd_protocol_reagent" ADD CONSTRAINT "nd_protocol_reagent_reagent_id" FOREIGN KEY ("reagent_id") REFERENCES "nd_reagent" ("nd_reagent_id") ON DELETE CASCADE;
ALTER TABLE "nd_protocol_reagent" ADD CONSTRAINT "nd_protocol_reagent_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_protocolprop" ADD CONSTRAINT "nd_protocolprop_nd_protocol_id" FOREIGN KEY ("nd_protocol_id") REFERENCES "nd_protocol" ("nd_protocol_id") ON DELETE CASCADE;
ALTER TABLE "nd_protocolprop" ADD CONSTRAINT "nd_protocolprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_reagent" ADD CONSTRAINT "nd_reagent_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_reagent_relationship" ADD CONSTRAINT "nd_reagent_relationship_object" FOREIGN KEY ("object_reagent_id") REFERENCES "nd_reagent" ("nd_reagent_id") ON DELETE CASCADE;
ALTER TABLE "nd_reagent_relationship" ADD CONSTRAINT "nd_reagent_relationship_subjec" FOREIGN KEY ("subject_reagent_id") REFERENCES "nd_reagent" ("nd_reagent_id") ON DELETE CASCADE;
ALTER TABLE "nd_reagent_relationship" ADD CONSTRAINT "nd_reagent_relationship_type_i" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "nd_reagentprop" ADD CONSTRAINT "nd_reagentprop_nd_reagent_id_f" FOREIGN KEY ("nd_reagent_id") REFERENCES "nd_reagent" ("nd_reagent_id") ON DELETE CASCADE;
ALTER TABLE "nd_reagentprop" ADD CONSTRAINT "nd_reagentprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "organism_dbxref" ADD CONSTRAINT "organism_dbxref_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "organism_dbxref" ADD CONSTRAINT "organism_dbxref_organism_id_fk" FOREIGN KEY ("organism_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "organismprop" ADD CONSTRAINT "organismprop_organism_id_fk" FOREIGN KEY ("organism_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "organismprop" ADD CONSTRAINT "organismprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phendesc" ADD CONSTRAINT "phendesc_environment_id_fk" FOREIGN KEY ("environment_id") REFERENCES "environment" ("environment_id") ON DELETE CASCADE;
ALTER TABLE "phendesc" ADD CONSTRAINT "phendesc_genotype_id_fk" FOREIGN KEY ("genotype_id") REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE;
ALTER TABLE "phendesc" ADD CONSTRAINT "phendesc_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "phendesc" ADD CONSTRAINT "phendesc_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phenotype" ADD CONSTRAINT "phenotype_assay_id_fk" FOREIGN KEY ("assay_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phenotype" ADD CONSTRAINT "phenotype_attr_id_fk" FOREIGN KEY ("attr_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phenotype" ADD CONSTRAINT "phenotype_cvalue_id_fk" FOREIGN KEY ("cvalue_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phenotype" ADD CONSTRAINT "phenotype_observable_id_fk" FOREIGN KEY ("observable_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison" ADD CONSTRAINT "phenotype_comparison_environme" FOREIGN KEY ("environment1_id") REFERENCES "environment" ("environment_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison" ADD CONSTRAINT "phenotype_comparison_environ01" FOREIGN KEY ("environment2_id") REFERENCES "environment" ("environment_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison" ADD CONSTRAINT "phenotype_comparison_genotype1" FOREIGN KEY ("genotype1_id") REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison" ADD CONSTRAINT "phenotype_comparison_genotype2" FOREIGN KEY ("genotype2_id") REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison" ADD CONSTRAINT "phenotype_comparison_organism_" FOREIGN KEY ("organism_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison" ADD CONSTRAINT "phenotype_comparison_phenotype" FOREIGN KEY ("phenotype1_id") REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison" ADD CONSTRAINT "phenotype_comparison_phenoty01" FOREIGN KEY ("phenotype2_id") REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison" ADD CONSTRAINT "phenotype_comparison_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison_cvterm" ADD CONSTRAINT "phenotype_comparison_cvterm_cv" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison_cvterm" ADD CONSTRAINT "phenotype_comparison_cvterm_ph" FOREIGN KEY ("phenotype_comparison_id") REFERENCES "phenotype_comparison" ("phenotype_comparison_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_comparison_cvterm" ADD CONSTRAINT "phenotype_comparison_cvterm_pu" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_cvterm" ADD CONSTRAINT "phenotype_cvterm_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phenotype_cvterm" ADD CONSTRAINT "phenotype_cvterm_phenotype_id_" FOREIGN KEY ("phenotype_id") REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE;
ALTER TABLE "phenstatement" ADD CONSTRAINT "phenstatement_environment_id_f" FOREIGN KEY ("environment_id") REFERENCES "environment" ("environment_id") ON DELETE CASCADE;
ALTER TABLE "phenstatement" ADD CONSTRAINT "phenstatement_genotype_id_fk" FOREIGN KEY ("genotype_id") REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE;
ALTER TABLE "phenstatement" ADD CONSTRAINT "phenstatement_phenotype_id_fk" FOREIGN KEY ("phenotype_id") REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE;
ALTER TABLE "phenstatement" ADD CONSTRAINT "phenstatement_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "phenstatement" ADD CONSTRAINT "phenstatement_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phylonode" ADD CONSTRAINT "phylonode_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "phylonode" ADD CONSTRAINT "phylonode_parent_phylonode_id_" FOREIGN KEY ("parent_phylonode_id") REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE;
ALTER TABLE "phylonode" ADD CONSTRAINT "phylonode_phylotree_id_fk" FOREIGN KEY ("phylotree_id") REFERENCES "phylotree" ("phylotree_id") ON DELETE CASCADE;
ALTER TABLE "phylonode" ADD CONSTRAINT "phylonode_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_dbxref" ADD CONSTRAINT "phylonode_dbxref_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_dbxref" ADD CONSTRAINT "phylonode_dbxref_phylonode_id_" FOREIGN KEY ("phylonode_id") REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_organism" ADD CONSTRAINT "phylonode_organism_organism_id" FOREIGN KEY ("organism_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_organism" ADD CONSTRAINT "phylonode_organism_phylonode_i" FOREIGN KEY ("phylonode_id") REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_pub" ADD CONSTRAINT "phylonode_pub_phylonode_id_fk" FOREIGN KEY ("phylonode_id") REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_pub" ADD CONSTRAINT "phylonode_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_relationship" ADD CONSTRAINT "phylonode_relationship_object_" FOREIGN KEY ("object_id") REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_relationship" ADD CONSTRAINT "phylonode_relationship_phylotr" FOREIGN KEY ("phylotree_id") REFERENCES "phylotree" ("phylotree_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_relationship" ADD CONSTRAINT "phylonode_relationship_subject" FOREIGN KEY ("subject_id") REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE;
ALTER TABLE "phylonode_relationship" ADD CONSTRAINT "phylonode_relationship_type_id" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phylonodeprop" ADD CONSTRAINT "phylonodeprop_phylonode_id_fk" FOREIGN KEY ("phylonode_id") REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE;
ALTER TABLE "phylonodeprop" ADD CONSTRAINT "phylonodeprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phylotree" ADD CONSTRAINT "phylotree_analysis_id_fk" FOREIGN KEY ("analysis_id") REFERENCES "analysis" ("analysis_id") ON DELETE CASCADE;
ALTER TABLE "phylotree" ADD CONSTRAINT "phylotree_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "phylotree" ADD CONSTRAINT "phylotree_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "phylotree_pub" ADD CONSTRAINT "phylotree_pub_phylotree_id_fk" FOREIGN KEY ("phylotree_id") REFERENCES "phylotree" ("phylotree_id") ON DELETE CASCADE;
ALTER TABLE "phylotree_pub" ADD CONSTRAINT "phylotree_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "project_contact" ADD CONSTRAINT "project_contact_contact_id_fk" FOREIGN KEY ("contact_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "project_contact" ADD CONSTRAINT "project_contact_project_id_fk" FOREIGN KEY ("project_id") REFERENCES "project" ("project_id") ON DELETE CASCADE;
ALTER TABLE "project_pub" ADD CONSTRAINT "project_pub_project_id_fk" FOREIGN KEY ("project_id") REFERENCES "project" ("project_id") ON DELETE CASCADE;
ALTER TABLE "project_pub" ADD CONSTRAINT "project_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "project_relationship" ADD CONSTRAINT "project_relationship_object_pr" FOREIGN KEY ("object_project_id") REFERENCES "project" ("project_id") ON DELETE CASCADE;
ALTER TABLE "project_relationship" ADD CONSTRAINT "project_relationship_subject_p" FOREIGN KEY ("subject_project_id") REFERENCES "project" ("project_id") ON DELETE CASCADE;
ALTER TABLE "project_relationship" ADD CONSTRAINT "project_relationship_type_id_f" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "projectprop" ADD CONSTRAINT "projectprop_project_id_fk" FOREIGN KEY ("project_id") REFERENCES "project" ("project_id") ON DELETE CASCADE;
ALTER TABLE "projectprop" ADD CONSTRAINT "projectprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "protocol" ADD CONSTRAINT "protocol_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "protocol" ADD CONSTRAINT "protocol_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "protocol" ADD CONSTRAINT "protocol_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "protocolparam" ADD CONSTRAINT "protocolparam_datatype_id_fk" FOREIGN KEY ("datatype_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "protocolparam" ADD CONSTRAINT "protocolparam_protocol_id_fk" FOREIGN KEY ("protocol_id") REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE;
ALTER TABLE "protocolparam" ADD CONSTRAINT "protocolparam_unittype_id_fk" FOREIGN KEY ("unittype_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "pub" ADD CONSTRAINT "pub_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "pub_dbxref" ADD CONSTRAINT "pub_dbxref_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "pub_dbxref" ADD CONSTRAINT "pub_dbxref_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "pub_relationship" ADD CONSTRAINT "pub_relationship_object_id_fk" FOREIGN KEY ("object_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "pub_relationship" ADD CONSTRAINT "pub_relationship_subject_id_fk" FOREIGN KEY ("subject_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "pub_relationship" ADD CONSTRAINT "pub_relationship_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "pubauthor" ADD CONSTRAINT "pubauthor_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "pubprop" ADD CONSTRAINT "pubprop_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "pubprop" ADD CONSTRAINT "pubprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "quantification" ADD CONSTRAINT "quantification_acquisition_id_" FOREIGN KEY ("acquisition_id") REFERENCES "acquisition" ("acquisition_id") ON DELETE CASCADE;
ALTER TABLE "quantification" ADD CONSTRAINT "quantification_analysis_id_fk" FOREIGN KEY ("analysis_id") REFERENCES "analysis" ("analysis_id") ON DELETE CASCADE;
ALTER TABLE "quantification" ADD CONSTRAINT "quantification_operator_id_fk" FOREIGN KEY ("operator_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "quantification" ADD CONSTRAINT "quantification_protocol_id_fk" FOREIGN KEY ("protocol_id") REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE;
ALTER TABLE "quantification_relationship" ADD CONSTRAINT "quantification_relationship_ob" FOREIGN KEY ("object_id") REFERENCES "quantification" ("quantification_id") ON DELETE CASCADE;
ALTER TABLE "quantification_relationship" ADD CONSTRAINT "quantification_relationship_su" FOREIGN KEY ("subject_id") REFERENCES "quantification" ("quantification_id") ON DELETE CASCADE;
ALTER TABLE "quantification_relationship" ADD CONSTRAINT "quantification_relationship_ty" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "quantificationprop" ADD CONSTRAINT "quantificationprop_quantificat" FOREIGN KEY ("quantification_id") REFERENCES "quantification" ("quantification_id") ON DELETE CASCADE;
ALTER TABLE "quantificationprop" ADD CONSTRAINT "quantificationprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stock" ADD CONSTRAINT "stock_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "stock" ADD CONSTRAINT "stock_organism_id_fk" FOREIGN KEY ("organism_id") REFERENCES "organism" ("organism_id") ON DELETE CASCADE;
ALTER TABLE "stock" ADD CONSTRAINT "stock_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stock_cvterm" ADD CONSTRAINT "stock_cvterm_cvterm_id_fk" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stock_cvterm" ADD CONSTRAINT "stock_cvterm_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "stock_cvterm" ADD CONSTRAINT "stock_cvterm_stock_id_fk" FOREIGN KEY ("stock_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "stock_cvtermprop" ADD CONSTRAINT "stock_cvtermprop_stock_cvterm_" FOREIGN KEY ("stock_cvterm_id") REFERENCES "stock_cvterm" ("stock_cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stock_cvtermprop" ADD CONSTRAINT "stock_cvtermprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stock_dbxref" ADD CONSTRAINT "stock_dbxref_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "stock_dbxref" ADD CONSTRAINT "stock_dbxref_stock_id_fk" FOREIGN KEY ("stock_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "stock_dbxrefprop" ADD CONSTRAINT "stock_dbxrefprop_stock_dbxref_" FOREIGN KEY ("stock_dbxref_id") REFERENCES "stock_dbxref" ("stock_dbxref_id") ON DELETE CASCADE;
ALTER TABLE "stock_dbxrefprop" ADD CONSTRAINT "stock_dbxrefprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stock_genotype" ADD CONSTRAINT "stock_genotype_genotype_id_fk" FOREIGN KEY ("genotype_id") REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE;
ALTER TABLE "stock_genotype" ADD CONSTRAINT "stock_genotype_stock_id_fk" FOREIGN KEY ("stock_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "stock_pub" ADD CONSTRAINT "stock_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "stock_pub" ADD CONSTRAINT "stock_pub_stock_id_fk" FOREIGN KEY ("stock_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "stock_relationship" ADD CONSTRAINT "stock_relationship_object_id_f" FOREIGN KEY ("object_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "stock_relationship" ADD CONSTRAINT "stock_relationship_subject_id_" FOREIGN KEY ("subject_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "stock_relationship" ADD CONSTRAINT "stock_relationship_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stock_relationship_cvterm" ADD CONSTRAINT "stock_relationship_cvterm_cvte" FOREIGN KEY ("cvterm_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stock_relationship_cvterm" ADD CONSTRAINT "stock_relationship_cvterm_pub_" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "stock_relationship_cvterm" ADD CONSTRAINT "stock_relationship_cvterm_stoc" FOREIGN KEY ("stock_relationship_id") REFERENCES "stock_relationship" ("stock_relationship_id") ON DELETE CASCADE;
ALTER TABLE "stock_relationship_pub" ADD CONSTRAINT "stock_relationship_pub_pub_id_" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "stock_relationship_pub" ADD CONSTRAINT "stock_relationship_pub_stock_r" FOREIGN KEY ("stock_relationship_id") REFERENCES "stock_relationship" ("stock_relationship_id") ON DELETE CASCADE;
ALTER TABLE "stockcollection" ADD CONSTRAINT "stockcollection_contact_id_fk" FOREIGN KEY ("contact_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "stockcollection" ADD CONSTRAINT "stockcollection_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stockcollection_stock" ADD CONSTRAINT "stockcollection_stock_stock_id" FOREIGN KEY ("stock_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "stockcollection_stock" ADD CONSTRAINT "stockcollection_stock_stockcol" FOREIGN KEY ("stockcollection_id") REFERENCES "stockcollection" ("stockcollection_id") ON DELETE CASCADE;
ALTER TABLE "stockcollectionprop" ADD CONSTRAINT "stockcollectionprop_stockcolle" FOREIGN KEY ("stockcollection_id") REFERENCES "stockcollection" ("stockcollection_id") ON DELETE CASCADE;
ALTER TABLE "stockcollectionprop" ADD CONSTRAINT "stockcollectionprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stockprop" ADD CONSTRAINT "stockprop_stock_id_fk" FOREIGN KEY ("stock_id") REFERENCES "stock" ("stock_id") ON DELETE CASCADE;
ALTER TABLE "stockprop" ADD CONSTRAINT "stockprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "stockprop_pub" ADD CONSTRAINT "stockprop_pub_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "stockprop_pub" ADD CONSTRAINT "stockprop_pub_stockprop_id_fk" FOREIGN KEY ("stockprop_id") REFERENCES "stockprop" ("stockprop_id") ON DELETE CASCADE;
ALTER TABLE "study" ADD CONSTRAINT "study_contact_id_fk" FOREIGN KEY ("contact_id") REFERENCES "contact" ("contact_id") ON DELETE CASCADE;
ALTER TABLE "study" ADD CONSTRAINT "study_dbxref_id_fk" FOREIGN KEY ("dbxref_id") REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE;
ALTER TABLE "study" ADD CONSTRAINT "study_pub_id_fk" FOREIGN KEY ("pub_id") REFERENCES "pub" ("pub_id") ON DELETE CASCADE;
ALTER TABLE "study_assay" ADD CONSTRAINT "study_assay_assay_id_fk" FOREIGN KEY ("assay_id") REFERENCES "assay" ("assay_id") ON DELETE CASCADE;
ALTER TABLE "study_assay" ADD CONSTRAINT "study_assay_study_id_fk" FOREIGN KEY ("study_id") REFERENCES "study" ("study_id") ON DELETE CASCADE;
ALTER TABLE "studydesign" ADD CONSTRAINT "studydesign_study_id_fk" FOREIGN KEY ("study_id") REFERENCES "study" ("study_id") ON DELETE CASCADE;
ALTER TABLE "studydesignprop" ADD CONSTRAINT "studydesignprop_studydesign_id" FOREIGN KEY ("studydesign_id") REFERENCES "studydesign" ("studydesign_id") ON DELETE CASCADE;
ALTER TABLE "studydesignprop" ADD CONSTRAINT "studydesignprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "studyfactor" ADD CONSTRAINT "studyfactor_studydesign_id_fk" FOREIGN KEY ("studydesign_id") REFERENCES "studydesign" ("studydesign_id") ON DELETE CASCADE;
ALTER TABLE "studyfactor" ADD CONSTRAINT "studyfactor_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "studyfactorvalue" ADD CONSTRAINT "studyfactorvalue_assay_id_fk" FOREIGN KEY ("assay_id") REFERENCES "assay" ("assay_id") ON DELETE CASCADE;
ALTER TABLE "studyfactorvalue" ADD CONSTRAINT "studyfactorvalue_studyfactor_i" FOREIGN KEY ("studyfactor_id") REFERENCES "studyfactor" ("studyfactor_id") ON DELETE CASCADE;
ALTER TABLE "studyprop" ADD CONSTRAINT "studyprop_study_id_fk" FOREIGN KEY ("study_id") REFERENCES "study" ("study_id") ON DELETE CASCADE;
ALTER TABLE "studyprop" ADD CONSTRAINT "studyprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "studyprop_feature" ADD CONSTRAINT "studyprop_feature_feature_id_f" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
ALTER TABLE "studyprop_feature" ADD CONSTRAINT "studyprop_feature_studyprop_id" FOREIGN KEY ("studyprop_id") REFERENCES "studyprop" ("studyprop_id") ON DELETE CASCADE;
ALTER TABLE "studyprop_feature" ADD CONSTRAINT "studyprop_feature_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "synonym_" ADD CONSTRAINT "synonym__type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "treatment" ADD CONSTRAINT "treatment_biomaterial_id_fk" FOREIGN KEY ("biomaterial_id") REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE;
ALTER TABLE "treatment" ADD CONSTRAINT "treatment_protocol_id_fk" FOREIGN KEY ("protocol_id") REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE;
ALTER TABLE "treatment" ADD CONSTRAINT "treatment_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE;
ALTER TABLE "featureprop" ADD CONSTRAINT "featureprop_type_id_fk" FOREIGN KEY ("type_id") REFERENCES "cvterm" ("cvterm_id");
ALTER TABLE "featureprop" ADD CONSTRAINT "featureprop_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "feature" ("feature_id") ON DELETE CASCADE;
CREATE OR REPLACE TRIGGER "ai_acquisition_acquisition_id"
BEFORE INSERT ON "acquisition"
FOR EACH ROW WHEN (
 new."acquisition_id" IS NULL OR new."acquisition_id" = 0
)
BEGIN
 SELECT "sq_acquisition_acquisition_id".nextval
 INTO :new."acquisition_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_acquisition_acquisitiondate"
BEFORE INSERT OR UPDATE ON "acquisition"
FOR EACH ROW WHEN (new."acquisitiondate" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."acquisitiondate" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_acquisition_relationship_ac"
BEFORE INSERT ON "acquisition_relationship"
FOR EACH ROW WHEN (
 new."acquisition_relationship_id" IS NULL OR new."acquisition_relationship_id" = 0
)
BEGIN
 SELECT "sq_acquisition_relationship_ac".nextval
 INTO :new."acquisition_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_acquisitionprop_acquisition"
BEFORE INSERT ON "acquisitionprop"
FOR EACH ROW WHEN (
 new."acquisitionprop_id" IS NULL OR new."acquisitionprop_id" = 0
)
BEGIN
 SELECT "sq_acquisitionprop_acquisition".nextval
 INTO :new."acquisitionprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_analysis_analysis_id"
BEFORE INSERT ON "analysis"
FOR EACH ROW WHEN (
 new."analysis_id" IS NULL OR new."analysis_id" = 0
)
BEGIN
 SELECT "sq_analysis_analysis_id".nextval
 INTO :new."analysis_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_analysis_timeexecuted"
BEFORE INSERT OR UPDATE ON "analysis"
FOR EACH ROW WHEN (new."timeexecuted" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timeexecuted" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_analysisfeature_analysisfea"
BEFORE INSERT ON "analysisfeature"
FOR EACH ROW WHEN (
 new."analysisfeature_id" IS NULL OR new."analysisfeature_id" = 0
)
BEGIN
 SELECT "sq_analysisfeature_analysisfea".nextval
 INTO :new."analysisfeature_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_analysisfeatureprop_analysi"
BEFORE INSERT ON "analysisfeatureprop"
FOR EACH ROW WHEN (
 new."analysisfeatureprop_id" IS NULL OR new."analysisfeatureprop_id" = 0
)
BEGIN
 SELECT "sq_analysisfeatureprop_analysi".nextval
 INTO :new."analysisfeatureprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_analysisprop_analysisprop_i"
BEFORE INSERT ON "analysisprop"
FOR EACH ROW WHEN (
 new."analysisprop_id" IS NULL OR new."analysisprop_id" = 0
)
BEGIN
 SELECT "sq_analysisprop_analysisprop_i".nextval
 INTO :new."analysisprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_arraydesign_arraydesign_id"
BEFORE INSERT ON "arraydesign"
FOR EACH ROW WHEN (
 new."arraydesign_id" IS NULL OR new."arraydesign_id" = 0
)
BEGIN
 SELECT "sq_arraydesign_arraydesign_id".nextval
 INTO :new."arraydesign_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_arraydesignprop_arraydesign"
BEFORE INSERT ON "arraydesignprop"
FOR EACH ROW WHEN (
 new."arraydesignprop_id" IS NULL OR new."arraydesignprop_id" = 0
)
BEGIN
 SELECT "sq_arraydesignprop_arraydesign".nextval
 INTO :new."arraydesignprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_assay_assay_id"
BEFORE INSERT ON "assay"
FOR EACH ROW WHEN (
 new."assay_id" IS NULL OR new."assay_id" = 0
)
BEGIN
 SELECT "sq_assay_assay_id".nextval
 INTO :new."assay_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_assay_assaydate"
BEFORE INSERT OR UPDATE ON "assay"
FOR EACH ROW WHEN (new."assaydate" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."assaydate" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_assay_biomaterial_assay_bio"
BEFORE INSERT ON "assay_biomaterial"
FOR EACH ROW WHEN (
 new."assay_biomaterial_id" IS NULL OR new."assay_biomaterial_id" = 0
)
BEGIN
 SELECT "sq_assay_biomaterial_assay_bio".nextval
 INTO :new."assay_biomaterial_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_assay_project_assay_project"
BEFORE INSERT ON "assay_project"
FOR EACH ROW WHEN (
 new."assay_project_id" IS NULL OR new."assay_project_id" = 0
)
BEGIN
 SELECT "sq_assay_project_assay_project".nextval
 INTO :new."assay_project_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_assayprop_assayprop_id"
BEFORE INSERT ON "assayprop"
FOR EACH ROW WHEN (
 new."assayprop_id" IS NULL OR new."assayprop_id" = 0
)
BEGIN
 SELECT "sq_assayprop_assayprop_id".nextval
 INTO :new."assayprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_biomaterial_biomaterial_id"
BEFORE INSERT ON "biomaterial"
FOR EACH ROW WHEN (
 new."biomaterial_id" IS NULL OR new."biomaterial_id" = 0
)
BEGIN
 SELECT "sq_biomaterial_biomaterial_id".nextval
 INTO :new."biomaterial_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_biomaterial_dbxref_biomater"
BEFORE INSERT ON "biomaterial_dbxref"
FOR EACH ROW WHEN (
 new."biomaterial_dbxref_id" IS NULL OR new."biomaterial_dbxref_id" = 0
)
BEGIN
 SELECT "sq_biomaterial_dbxref_biomater".nextval
 INTO :new."biomaterial_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_biomaterial_relationship_bi"
BEFORE INSERT ON "biomaterial_relationship"
FOR EACH ROW WHEN (
 new."biomaterial_relationship_id" IS NULL OR new."biomaterial_relationship_id" = 0
)
BEGIN
 SELECT "sq_biomaterial_relationship_bi".nextval
 INTO :new."biomaterial_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_biomaterial_treatment_bioma"
BEFORE INSERT ON "biomaterial_treatment"
FOR EACH ROW WHEN (
 new."biomaterial_treatment_id" IS NULL OR new."biomaterial_treatment_id" = 0
)
BEGIN
 SELECT "sq_biomaterial_treatment_bioma".nextval
 INTO :new."biomaterial_treatment_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_biomaterialprop_biomaterial"
BEFORE INSERT ON "biomaterialprop"
FOR EACH ROW WHEN (
 new."biomaterialprop_id" IS NULL OR new."biomaterialprop_id" = 0
)
BEGIN
 SELECT "sq_biomaterialprop_biomaterial".nextval
 INTO :new."biomaterialprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_cell_line_id"
BEFORE INSERT ON "cell_line"
FOR EACH ROW WHEN (
 new."cell_line_id" IS NULL OR new."cell_line_id" = 0
)
BEGIN
 SELECT "sq_cell_line_cell_line_id".nextval
 INTO :new."cell_line_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_cell_line_timeaccessioned"
BEFORE INSERT OR UPDATE ON "cell_line"
FOR EACH ROW WHEN (new."timeaccessioned" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timeaccessioned" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_cell_line_timelastmodified"
BEFORE INSERT OR UPDATE ON "cell_line"
FOR EACH ROW WHEN (new."timelastmodified" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timelastmodified" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_cvterm_cell_line_"
BEFORE INSERT ON "cell_line_cvterm"
FOR EACH ROW WHEN (
 new."cell_line_cvterm_id" IS NULL OR new."cell_line_cvterm_id" = 0
)
BEGIN
 SELECT "sq_cell_line_cvterm_cell_line_".nextval
 INTO :new."cell_line_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_cvtermprop_cell_l"
BEFORE INSERT ON "cell_line_cvtermprop"
FOR EACH ROW WHEN (
 new."cell_line_cvtermprop_id" IS NULL OR new."cell_line_cvtermprop_id" = 0
)
BEGIN
 SELECT "sq_cell_line_cvtermprop_cell_l".nextval
 INTO :new."cell_line_cvtermprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_dbxref_cell_line_"
BEFORE INSERT ON "cell_line_dbxref"
FOR EACH ROW WHEN (
 new."cell_line_dbxref_id" IS NULL OR new."cell_line_dbxref_id" = 0
)
BEGIN
 SELECT "sq_cell_line_dbxref_cell_line_".nextval
 INTO :new."cell_line_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_feature_cell_line"
BEFORE INSERT ON "cell_line_feature"
FOR EACH ROW WHEN (
 new."cell_line_feature_id" IS NULL OR new."cell_line_feature_id" = 0
)
BEGIN
 SELECT "sq_cell_line_feature_cell_line".nextval
 INTO :new."cell_line_feature_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_library_cell_line"
BEFORE INSERT ON "cell_line_library"
FOR EACH ROW WHEN (
 new."cell_line_library_id" IS NULL OR new."cell_line_library_id" = 0
)
BEGIN
 SELECT "sq_cell_line_library_cell_line".nextval
 INTO :new."cell_line_library_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_pub_cell_line_pub"
BEFORE INSERT ON "cell_line_pub"
FOR EACH ROW WHEN (
 new."cell_line_pub_id" IS NULL OR new."cell_line_pub_id" = 0
)
BEGIN
 SELECT "sq_cell_line_pub_cell_line_pub".nextval
 INTO :new."cell_line_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_relationship_cell"
BEFORE INSERT ON "cell_line_relationship"
FOR EACH ROW WHEN (
 new."cell_line_relationship_id" IS NULL OR new."cell_line_relationship_id" = 0
)
BEGIN
 SELECT "sq_cell_line_relationship_cell".nextval
 INTO :new."cell_line_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_line_synonym_cell_line"
BEFORE INSERT ON "cell_line_synonym"
FOR EACH ROW WHEN (
 new."cell_line_synonym_id" IS NULL OR new."cell_line_synonym_id" = 0
)
BEGIN
 SELECT "sq_cell_line_synonym_cell_line".nextval
 INTO :new."cell_line_synonym_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_lineprop_cell_lineprop"
BEFORE INSERT ON "cell_lineprop"
FOR EACH ROW WHEN (
 new."cell_lineprop_id" IS NULL OR new."cell_lineprop_id" = 0
)
BEGIN
 SELECT "sq_cell_lineprop_cell_lineprop".nextval
 INTO :new."cell_lineprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cell_lineprop_pub_cell_line"
BEFORE INSERT ON "cell_lineprop_pub"
FOR EACH ROW WHEN (
 new."cell_lineprop_pub_id" IS NULL OR new."cell_lineprop_pub_id" = 0
)
BEGIN
 SELECT "sq_cell_lineprop_pub_cell_line".nextval
 INTO :new."cell_lineprop_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_channel_channel_id"
BEFORE INSERT ON "channel"
FOR EACH ROW WHEN (
 new."channel_id" IS NULL OR new."channel_id" = 0
)
BEGIN
 SELECT "sq_channel_channel_id".nextval
 INTO :new."channel_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_contact_contact_id"
BEFORE INSERT ON "contact"
FOR EACH ROW WHEN (
 new."contact_id" IS NULL OR new."contact_id" = 0
)
BEGIN
 SELECT "sq_contact_contact_id".nextval
 INTO :new."contact_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_contact_relationship_contac"
BEFORE INSERT ON "contact_relationship"
FOR EACH ROW WHEN (
 new."contact_relationship_id" IS NULL OR new."contact_relationship_id" = 0
)
BEGIN
 SELECT "sq_contact_relationship_contac".nextval
 INTO :new."contact_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_control_control_id"
BEFORE INSERT ON "control"
FOR EACH ROW WHEN (
 new."control_id" IS NULL OR new."control_id" = 0
)
BEGIN
 SELECT "sq_control_control_id".nextval
 INTO :new."control_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cv_cv_id"
BEFORE INSERT ON "cv"
FOR EACH ROW WHEN (
 new."cv_id" IS NULL OR new."cv_id" = 0
)
BEGIN
 SELECT "sq_cv_cv_id".nextval
 INTO :new."cv_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cvprop_cvprop_id"
BEFORE INSERT ON "cvprop"
FOR EACH ROW WHEN (
 new."cvprop_id" IS NULL OR new."cvprop_id" = 0
)
BEGIN
 SELECT "sq_cvprop_cvprop_id".nextval
 INTO :new."cvprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cvterm_cvterm_id"
BEFORE INSERT ON "cvterm"
FOR EACH ROW WHEN (
 new."cvterm_id" IS NULL OR new."cvterm_id" = 0
)
BEGIN
 SELECT "sq_cvterm_cvterm_id".nextval
 INTO :new."cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cvterm_dbxref_cvterm_dbxref"
BEFORE INSERT ON "cvterm_dbxref"
FOR EACH ROW WHEN (
 new."cvterm_dbxref_id" IS NULL OR new."cvterm_dbxref_id" = 0
)
BEGIN
 SELECT "sq_cvterm_dbxref_cvterm_dbxref".nextval
 INTO :new."cvterm_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cvterm_relationship_cvterm_"
BEFORE INSERT ON "cvterm_relationship"
FOR EACH ROW WHEN (
 new."cvterm_relationship_id" IS NULL OR new."cvterm_relationship_id" = 0
)
BEGIN
 SELECT "sq_cvterm_relationship_cvterm_".nextval
 INTO :new."cvterm_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cvtermpath_cvtermpath_id"
BEFORE INSERT ON "cvtermpath"
FOR EACH ROW WHEN (
 new."cvtermpath_id" IS NULL OR new."cvtermpath_id" = 0
)
BEGIN
 SELECT "sq_cvtermpath_cvtermpath_id".nextval
 INTO :new."cvtermpath_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cvtermprop_cvtermprop_id"
BEFORE INSERT ON "cvtermprop"
FOR EACH ROW WHEN (
 new."cvtermprop_id" IS NULL OR new."cvtermprop_id" = 0
)
BEGIN
 SELECT "sq_cvtermprop_cvtermprop_id".nextval
 INTO :new."cvtermprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_cvtermsynonym_cvtermsynonym"
BEFORE INSERT ON "cvtermsynonym"
FOR EACH ROW WHEN (
 new."cvtermsynonym_id" IS NULL OR new."cvtermsynonym_id" = 0
)
BEGIN
 SELECT "sq_cvtermsynonym_cvtermsynonym".nextval
 INTO :new."cvtermsynonym_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_db_db_id"
BEFORE INSERT ON "db"
FOR EACH ROW WHEN (
 new."db_id" IS NULL OR new."db_id" = 0
)
BEGIN
 SELECT "sq_db_db_id".nextval
 INTO :new."db_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_dbxref_dbxref_id"
BEFORE INSERT ON "dbxref"
FOR EACH ROW WHEN (
 new."dbxref_id" IS NULL OR new."dbxref_id" = 0
)
BEGIN
 SELECT "sq_dbxref_dbxref_id".nextval
 INTO :new."dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_dbxrefprop_dbxrefprop_id"
BEFORE INSERT ON "dbxrefprop"
FOR EACH ROW WHEN (
 new."dbxrefprop_id" IS NULL OR new."dbxrefprop_id" = 0
)
BEGIN
 SELECT "sq_dbxrefprop_dbxrefprop_id".nextval
 INTO :new."dbxrefprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_eimage_eimage_id"
BEFORE INSERT ON "eimage"
FOR EACH ROW WHEN (
 new."eimage_id" IS NULL OR new."eimage_id" = 0
)
BEGIN
 SELECT "sq_eimage_eimage_id".nextval
 INTO :new."eimage_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_element_element_id"
BEFORE INSERT ON "element"
FOR EACH ROW WHEN (
 new."element_id" IS NULL OR new."element_id" = 0
)
BEGIN
 SELECT "sq_element_element_id".nextval
 INTO :new."element_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_element_relationship_elemen"
BEFORE INSERT ON "element_relationship"
FOR EACH ROW WHEN (
 new."element_relationship_id" IS NULL OR new."element_relationship_id" = 0
)
BEGIN
 SELECT "sq_element_relationship_elemen".nextval
 INTO :new."element_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_elementresult_elementresult"
BEFORE INSERT ON "elementresult"
FOR EACH ROW WHEN (
 new."elementresult_id" IS NULL OR new."elementresult_id" = 0
)
BEGIN
 SELECT "sq_elementresult_elementresult".nextval
 INTO :new."elementresult_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_elementresult_relationship_"
BEFORE INSERT ON "elementresult_relationship"
FOR EACH ROW WHEN (
 new."elementresult_relationship_id" IS NULL OR new."elementresult_relationship_id" = 0
)
BEGIN
 SELECT "sq_elementresult_relationship_".nextval
 INTO :new."elementresult_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_environment_environment_id"
BEFORE INSERT ON "environment"
FOR EACH ROW WHEN (
 new."environment_id" IS NULL OR new."environment_id" = 0
)
BEGIN
 SELECT "sq_environment_environment_id".nextval
 INTO :new."environment_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_environment_cvterm_environm"
BEFORE INSERT ON "environment_cvterm"
FOR EACH ROW WHEN (
 new."environment_cvterm_id" IS NULL OR new."environment_cvterm_id" = 0
)
BEGIN
 SELECT "sq_environment_cvterm_environm".nextval
 INTO :new."environment_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_expression_expression_id"
BEFORE INSERT ON "expression"
FOR EACH ROW WHEN (
 new."expression_id" IS NULL OR new."expression_id" = 0
)
BEGIN
 SELECT "sq_expression_expression_id".nextval
 INTO :new."expression_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_expression_cvterm_expressio"
BEFORE INSERT ON "expression_cvterm"
FOR EACH ROW WHEN (
 new."expression_cvterm_id" IS NULL OR new."expression_cvterm_id" = 0
)
BEGIN
 SELECT "sq_expression_cvterm_expressio".nextval
 INTO :new."expression_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_expression_cvtermprop_expre"
BEFORE INSERT ON "expression_cvtermprop"
FOR EACH ROW WHEN (
 new."expression_cvtermprop_id" IS NULL OR new."expression_cvtermprop_id" = 0
)
BEGIN
 SELECT "sq_expression_cvtermprop_expre".nextval
 INTO :new."expression_cvtermprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_expression_image_expression"
BEFORE INSERT ON "expression_image"
FOR EACH ROW WHEN (
 new."expression_image_id" IS NULL OR new."expression_image_id" = 0
)
BEGIN
 SELECT "sq_expression_image_expression".nextval
 INTO :new."expression_image_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_expression_pub_expression_p"
BEFORE INSERT ON "expression_pub"
FOR EACH ROW WHEN (
 new."expression_pub_id" IS NULL OR new."expression_pub_id" = 0
)
BEGIN
 SELECT "sq_expression_pub_expression_p".nextval
 INTO :new."expression_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_expressionprop_expressionpr"
BEFORE INSERT ON "expressionprop"
FOR EACH ROW WHEN (
 new."expressionprop_id" IS NULL OR new."expressionprop_id" = 0
)
BEGIN
 SELECT "sq_expressionprop_expressionpr".nextval
 INTO :new."expressionprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_f_type_timeaccessioned"
BEFORE INSERT OR UPDATE ON "f_type"
FOR EACH ROW WHEN (new."timeaccessioned" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timeaccessioned" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_f_type_timelastmodified"
BEFORE INSERT OR UPDATE ON "f_type"
FOR EACH ROW WHEN (new."timelastmodified" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timelastmodified" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_feature_id"
BEFORE INSERT ON "feature"
FOR EACH ROW WHEN (
 new."feature_id" IS NULL OR new."feature_id" = 0
)
BEGIN
 SELECT "sq_feature_feature_id".nextval
 INTO :new."feature_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_feature_timeaccessioned"
BEFORE INSERT OR UPDATE ON "feature"
FOR EACH ROW WHEN (new."timeaccessioned" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timeaccessioned" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_feature_timelastmodified"
BEFORE INSERT OR UPDATE ON "feature"
FOR EACH ROW WHEN (new."timelastmodified" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timelastmodified" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_cvterm_feature_cvte"
BEFORE INSERT ON "feature_cvterm"
FOR EACH ROW WHEN (
 new."feature_cvterm_id" IS NULL OR new."feature_cvterm_id" = 0
)
BEGIN
 SELECT "sq_feature_cvterm_feature_cvte".nextval
 INTO :new."feature_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_cvterm_dbxref_featu"
BEFORE INSERT ON "feature_cvterm_dbxref"
FOR EACH ROW WHEN (
 new."feature_cvterm_dbxref_id" IS NULL OR new."feature_cvterm_dbxref_id" = 0
)
BEGIN
 SELECT "sq_feature_cvterm_dbxref_featu".nextval
 INTO :new."feature_cvterm_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_cvterm_pub_feature_"
BEFORE INSERT ON "feature_cvterm_pub"
FOR EACH ROW WHEN (
 new."feature_cvterm_pub_id" IS NULL OR new."feature_cvterm_pub_id" = 0
)
BEGIN
 SELECT "sq_feature_cvterm_pub_feature_".nextval
 INTO :new."feature_cvterm_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_cvtermprop_feature_"
BEFORE INSERT ON "feature_cvtermprop"
FOR EACH ROW WHEN (
 new."feature_cvtermprop_id" IS NULL OR new."feature_cvtermprop_id" = 0
)
BEGIN
 SELECT "sq_feature_cvtermprop_feature_".nextval
 INTO :new."feature_cvtermprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_dbxref_feature_dbxr"
BEFORE INSERT ON "feature_dbxref"
FOR EACH ROW WHEN (
 new."feature_dbxref_id" IS NULL OR new."feature_dbxref_id" = 0
)
BEGIN
 SELECT "sq_feature_dbxref_feature_dbxr".nextval
 INTO :new."feature_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_expression_feature_"
BEFORE INSERT ON "feature_expression"
FOR EACH ROW WHEN (
 new."feature_expression_id" IS NULL OR new."feature_expression_id" = 0
)
BEGIN
 SELECT "sq_feature_expression_feature_".nextval
 INTO :new."feature_expression_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_expressionprop_feat"
BEFORE INSERT ON "feature_expressionprop"
FOR EACH ROW WHEN (
 new."feature_expressionprop_id" IS NULL OR new."feature_expressionprop_id" = 0
)
BEGIN
 SELECT "sq_feature_expressionprop_feat".nextval
 INTO :new."feature_expressionprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_genotype_feature_ge"
BEFORE INSERT ON "feature_genotype"
FOR EACH ROW WHEN (
 new."feature_genotype_id" IS NULL OR new."feature_genotype_id" = 0
)
BEGIN
 SELECT "sq_feature_genotype_feature_ge".nextval
 INTO :new."feature_genotype_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_phenotype_feature_p"
BEFORE INSERT ON "feature_phenotype"
FOR EACH ROW WHEN (
 new."feature_phenotype_id" IS NULL OR new."feature_phenotype_id" = 0
)
BEGIN
 SELECT "sq_feature_phenotype_feature_p".nextval
 INTO :new."feature_phenotype_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_pub_feature_pub_id"
BEFORE INSERT ON "feature_pub"
FOR EACH ROW WHEN (
 new."feature_pub_id" IS NULL OR new."feature_pub_id" = 0
)
BEGIN
 SELECT "sq_feature_pub_feature_pub_id".nextval
 INTO :new."feature_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_pubprop_feature_pub"
BEFORE INSERT ON "feature_pubprop"
FOR EACH ROW WHEN (
 new."feature_pubprop_id" IS NULL OR new."feature_pubprop_id" = 0
)
BEGIN
 SELECT "sq_feature_pubprop_feature_pub".nextval
 INTO :new."feature_pubprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_relationship_featur"
BEFORE INSERT ON "feature_relationship"
FOR EACH ROW WHEN (
 new."feature_relationship_id" IS NULL OR new."feature_relationship_id" = 0
)
BEGIN
 SELECT "sq_feature_relationship_featur".nextval
 INTO :new."feature_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_relationship_pub_fe"
BEFORE INSERT ON "feature_relationship_pub"
FOR EACH ROW WHEN (
 new."feature_relationship_pub_id" IS NULL OR new."feature_relationship_pub_id" = 0
)
BEGIN
 SELECT "sq_feature_relationship_pub_fe".nextval
 INTO :new."feature_relationship_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_relationshipprop_fe"
BEFORE INSERT ON "feature_relationshipprop"
FOR EACH ROW WHEN (
 new."feature_relationshipprop_id" IS NULL OR new."feature_relationshipprop_id" = 0
)
BEGIN
 SELECT "sq_feature_relationshipprop_fe".nextval
 INTO :new."feature_relationshipprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_relationshipprop_pu"
BEFORE INSERT ON "feature_relationshipprop_pub"
FOR EACH ROW WHEN (
 new."feature_relationshipprop_pub_i" IS NULL OR new."feature_relationshipprop_pub_i" = 0
)
BEGIN
 SELECT "sq_feature_relationshipprop_pu".nextval
 INTO :new."feature_relationshipprop_pub_i"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_feature_synonym_feature_syn"
BEFORE INSERT ON "feature_synonym"
FOR EACH ROW WHEN (
 new."feature_synonym_id" IS NULL OR new."feature_synonym_id" = 0
)
BEGIN
 SELECT "sq_feature_synonym_feature_syn".nextval
 INTO :new."feature_synonym_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featureloc_featureloc_id"
BEFORE INSERT ON "featureloc"
FOR EACH ROW WHEN (
 new."featureloc_id" IS NULL OR new."featureloc_id" = 0
)
BEGIN
 SELECT "sq_featureloc_featureloc_id".nextval
 INTO :new."featureloc_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featureloc_pub_featureloc_p"
BEFORE INSERT ON "featureloc_pub"
FOR EACH ROW WHEN (
 new."featureloc_pub_id" IS NULL OR new."featureloc_pub_id" = 0
)
BEGIN
 SELECT "sq_featureloc_pub_featureloc_p".nextval
 INTO :new."featureloc_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featuremap_featuremap_id"
BEFORE INSERT ON "featuremap"
FOR EACH ROW WHEN (
 new."featuremap_id" IS NULL OR new."featuremap_id" = 0
)
BEGIN
 SELECT "sq_featuremap_featuremap_id".nextval
 INTO :new."featuremap_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featuremap_pub_featuremap_p"
BEFORE INSERT ON "featuremap_pub"
FOR EACH ROW WHEN (
 new."featuremap_pub_id" IS NULL OR new."featuremap_pub_id" = 0
)
BEGIN
 SELECT "sq_featuremap_pub_featuremap_p".nextval
 INTO :new."featuremap_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featurepos_featurepos_id"
BEFORE INSERT ON "featurepos"
FOR EACH ROW WHEN (
 new."featurepos_id" IS NULL OR new."featurepos_id" = 0
)
BEGIN
 SELECT "sq_featurepos_featurepos_id".nextval
 INTO :new."featurepos_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featurepos_featuremap_id"
BEFORE INSERT ON "featurepos"
FOR EACH ROW WHEN (
 new."featuremap_id" IS NULL OR new."featuremap_id" = 0
)
BEGIN
 SELECT "sq_featurepos_featuremap_id".nextval
 INTO :new."featuremap_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featureprop_pub_featureprop"
BEFORE INSERT ON "featureprop_pub"
FOR EACH ROW WHEN (
 new."featureprop_pub_id" IS NULL OR new."featureprop_pub_id" = 0
)
BEGIN
 SELECT "sq_featureprop_pub_featureprop".nextval
 INTO :new."featureprop_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featurerange_featurerange_i"
BEFORE INSERT ON "featurerange"
FOR EACH ROW WHEN (
 new."featurerange_id" IS NULL OR new."featurerange_id" = 0
)
BEGIN
 SELECT "sq_featurerange_featurerange_i".nextval
 INTO :new."featurerange_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_fnr_type_timeaccessioned"
BEFORE INSERT OR UPDATE ON "fnr_type"
FOR EACH ROW WHEN (new."timeaccessioned" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timeaccessioned" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_fnr_type_timelastmodified"
BEFORE INSERT OR UPDATE ON "fnr_type"
FOR EACH ROW WHEN (new."timelastmodified" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timelastmodified" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_genotype_genotype_id"
BEFORE INSERT ON "genotype"
FOR EACH ROW WHEN (
 new."genotype_id" IS NULL OR new."genotype_id" = 0
)
BEGIN
 SELECT "sq_genotype_genotype_id".nextval
 INTO :new."genotype_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_genotypeprop_genotypeprop_i"
BEFORE INSERT ON "genotypeprop"
FOR EACH ROW WHEN (
 new."genotypeprop_id" IS NULL OR new."genotypeprop_id" = 0
)
BEGIN
 SELECT "sq_genotypeprop_genotypeprop_i".nextval
 INTO :new."genotypeprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_library_library_id"
BEFORE INSERT ON "library"
FOR EACH ROW WHEN (
 new."library_id" IS NULL OR new."library_id" = 0
)
BEGIN
 SELECT "sq_library_library_id".nextval
 INTO :new."library_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_library_timeaccessioned"
BEFORE INSERT OR UPDATE ON "library"
FOR EACH ROW WHEN (new."timeaccessioned" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timeaccessioned" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_library_timelastmodified"
BEFORE INSERT OR UPDATE ON "library"
FOR EACH ROW WHEN (new."timelastmodified" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timelastmodified" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_library_cvterm_library_cvte"
BEFORE INSERT ON "library_cvterm"
FOR EACH ROW WHEN (
 new."library_cvterm_id" IS NULL OR new."library_cvterm_id" = 0
)
BEGIN
 SELECT "sq_library_cvterm_library_cvte".nextval
 INTO :new."library_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_library_dbxref_library_dbxr"
BEFORE INSERT ON "library_dbxref"
FOR EACH ROW WHEN (
 new."library_dbxref_id" IS NULL OR new."library_dbxref_id" = 0
)
BEGIN
 SELECT "sq_library_dbxref_library_dbxr".nextval
 INTO :new."library_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_library_feature_library_fea"
BEFORE INSERT ON "library_feature"
FOR EACH ROW WHEN (
 new."library_feature_id" IS NULL OR new."library_feature_id" = 0
)
BEGIN
 SELECT "sq_library_feature_library_fea".nextval
 INTO :new."library_feature_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_library_pub_library_pub_id"
BEFORE INSERT ON "library_pub"
FOR EACH ROW WHEN (
 new."library_pub_id" IS NULL OR new."library_pub_id" = 0
)
BEGIN
 SELECT "sq_library_pub_library_pub_id".nextval
 INTO :new."library_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_library_synonym_library_syn"
BEFORE INSERT ON "library_synonym"
FOR EACH ROW WHEN (
 new."library_synonym_id" IS NULL OR new."library_synonym_id" = 0
)
BEGIN
 SELECT "sq_library_synonym_library_syn".nextval
 INTO :new."library_synonym_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_libraryprop_libraryprop_id"
BEFORE INSERT ON "libraryprop"
FOR EACH ROW WHEN (
 new."libraryprop_id" IS NULL OR new."libraryprop_id" = 0
)
BEGIN
 SELECT "sq_libraryprop_libraryprop_id".nextval
 INTO :new."libraryprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_libraryprop_pub_libraryprop"
BEFORE INSERT ON "libraryprop_pub"
FOR EACH ROW WHEN (
 new."libraryprop_pub_id" IS NULL OR new."libraryprop_pub_id" = 0
)
BEGIN
 SELECT "sq_libraryprop_pub_libraryprop".nextval
 INTO :new."libraryprop_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_magedocumentation_magedocum"
BEFORE INSERT ON "magedocumentation"
FOR EACH ROW WHEN (
 new."magedocumentation_id" IS NULL OR new."magedocumentation_id" = 0
)
BEGIN
 SELECT "sq_magedocumentation_magedocum".nextval
 INTO :new."magedocumentation_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_mageml_mageml_id"
BEFORE INSERT ON "mageml"
FOR EACH ROW WHEN (
 new."mageml_id" IS NULL OR new."mageml_id" = 0
)
BEGIN
 SELECT "sq_mageml_mageml_id".nextval
 INTO :new."mageml_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_nd_experiment"
BEFORE INSERT ON "nd_experiment"
FOR EACH ROW WHEN (
 new."nd_experiment_id" IS NULL OR new."nd_experiment_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_nd_experiment".nextval
 INTO :new."nd_experiment_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_contact_nd_ex"
BEFORE INSERT ON "nd_experiment_contact"
FOR EACH ROW WHEN (
 new."nd_experiment_contact_id" IS NULL OR new."nd_experiment_contact_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_contact_nd_ex".nextval
 INTO :new."nd_experiment_contact_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_dbxref_nd_exp"
BEFORE INSERT ON "nd_experiment_dbxref"
FOR EACH ROW WHEN (
 new."nd_experiment_dbxref_id" IS NULL OR new."nd_experiment_dbxref_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_dbxref_nd_exp".nextval
 INTO :new."nd_experiment_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_genotype_nd_e"
BEFORE INSERT ON "nd_experiment_genotype"
FOR EACH ROW WHEN (
 new."nd_experiment_genotype_id" IS NULL OR new."nd_experiment_genotype_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_genotype_nd_e".nextval
 INTO :new."nd_experiment_genotype_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_phenotype_nd_"
BEFORE INSERT ON "nd_experiment_phenotype"
FOR EACH ROW WHEN (
 new."nd_experiment_phenotype_id" IS NULL OR new."nd_experiment_phenotype_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_phenotype_nd_".nextval
 INTO :new."nd_experiment_phenotype_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_project_nd_ex"
BEFORE INSERT ON "nd_experiment_project"
FOR EACH ROW WHEN (
 new."nd_experiment_project_id" IS NULL OR new."nd_experiment_project_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_project_nd_ex".nextval
 INTO :new."nd_experiment_project_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_protocol_nd_e"
BEFORE INSERT ON "nd_experiment_protocol"
FOR EACH ROW WHEN (
 new."nd_experiment_protocol_id" IS NULL OR new."nd_experiment_protocol_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_protocol_nd_e".nextval
 INTO :new."nd_experiment_protocol_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_pub_nd_experi"
BEFORE INSERT ON "nd_experiment_pub"
FOR EACH ROW WHEN (
 new."nd_experiment_pub_id" IS NULL OR new."nd_experiment_pub_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_pub_nd_experi".nextval
 INTO :new."nd_experiment_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_stock_nd_expe"
BEFORE INSERT ON "nd_experiment_stock"
FOR EACH ROW WHEN (
 new."nd_experiment_stock_id" IS NULL OR new."nd_experiment_stock_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_stock_nd_expe".nextval
 INTO :new."nd_experiment_stock_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_stock_dbxref_"
BEFORE INSERT ON "nd_experiment_stock_dbxref"
FOR EACH ROW WHEN (
 new."nd_experiment_stock_dbxref_id" IS NULL OR new."nd_experiment_stock_dbxref_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_stock_dbxref_".nextval
 INTO :new."nd_experiment_stock_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experiment_stockprop_nd_"
BEFORE INSERT ON "nd_experiment_stockprop"
FOR EACH ROW WHEN (
 new."nd_experiment_stockprop_id" IS NULL OR new."nd_experiment_stockprop_id" = 0
)
BEGIN
 SELECT "sq_nd_experiment_stockprop_nd_".nextval
 INTO :new."nd_experiment_stockprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_experimentprop_nd_experi"
BEFORE INSERT ON "nd_experimentprop"
FOR EACH ROW WHEN (
 new."nd_experimentprop_id" IS NULL OR new."nd_experimentprop_id" = 0
)
BEGIN
 SELECT "sq_nd_experimentprop_nd_experi".nextval
 INTO :new."nd_experimentprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_geolocation_nd_geolocati"
BEFORE INSERT ON "nd_geolocation"
FOR EACH ROW WHEN (
 new."nd_geolocation_id" IS NULL OR new."nd_geolocation_id" = 0
)
BEGIN
 SELECT "sq_nd_geolocation_nd_geolocati".nextval
 INTO :new."nd_geolocation_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_geolocationprop_nd_geolo"
BEFORE INSERT ON "nd_geolocationprop"
FOR EACH ROW WHEN (
 new."nd_geolocationprop_id" IS NULL OR new."nd_geolocationprop_id" = 0
)
BEGIN
 SELECT "sq_nd_geolocationprop_nd_geolo".nextval
 INTO :new."nd_geolocationprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_protocol_nd_protocol_id"
BEFORE INSERT ON "nd_protocol"
FOR EACH ROW WHEN (
 new."nd_protocol_id" IS NULL OR new."nd_protocol_id" = 0
)
BEGIN
 SELECT "sq_nd_protocol_nd_protocol_id".nextval
 INTO :new."nd_protocol_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_protocol_reagent_nd_prot"
BEFORE INSERT ON "nd_protocol_reagent"
FOR EACH ROW WHEN (
 new."nd_protocol_reagent_id" IS NULL OR new."nd_protocol_reagent_id" = 0
)
BEGIN
 SELECT "sq_nd_protocol_reagent_nd_prot".nextval
 INTO :new."nd_protocol_reagent_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_protocolprop_nd_protocol"
BEFORE INSERT ON "nd_protocolprop"
FOR EACH ROW WHEN (
 new."nd_protocolprop_id" IS NULL OR new."nd_protocolprop_id" = 0
)
BEGIN
 SELECT "sq_nd_protocolprop_nd_protocol".nextval
 INTO :new."nd_protocolprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_reagent_nd_reagent_id"
BEFORE INSERT ON "nd_reagent"
FOR EACH ROW WHEN (
 new."nd_reagent_id" IS NULL OR new."nd_reagent_id" = 0
)
BEGIN
 SELECT "sq_nd_reagent_nd_reagent_id".nextval
 INTO :new."nd_reagent_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_reagent_relationship_nd_"
BEFORE INSERT ON "nd_reagent_relationship"
FOR EACH ROW WHEN (
 new."nd_reagent_relationship_id" IS NULL OR new."nd_reagent_relationship_id" = 0
)
BEGIN
 SELECT "sq_nd_reagent_relationship_nd_".nextval
 INTO :new."nd_reagent_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_nd_reagentprop_nd_reagentpr"
BEFORE INSERT ON "nd_reagentprop"
FOR EACH ROW WHEN (
 new."nd_reagentprop_id" IS NULL OR new."nd_reagentprop_id" = 0
)
BEGIN
 SELECT "sq_nd_reagentprop_nd_reagentpr".nextval
 INTO :new."nd_reagentprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_organism_organism_id"
BEFORE INSERT ON "organism"
FOR EACH ROW WHEN (
 new."organism_id" IS NULL OR new."organism_id" = 0
)
BEGIN
 SELECT "sq_organism_organism_id".nextval
 INTO :new."organism_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_organism_dbxref_organism_db"
BEFORE INSERT ON "organism_dbxref"
FOR EACH ROW WHEN (
 new."organism_dbxref_id" IS NULL OR new."organism_dbxref_id" = 0
)
BEGIN
 SELECT "sq_organism_dbxref_organism_db".nextval
 INTO :new."organism_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_organismprop_organismprop_i"
BEFORE INSERT ON "organismprop"
FOR EACH ROW WHEN (
 new."organismprop_id" IS NULL OR new."organismprop_id" = 0
)
BEGIN
 SELECT "sq_organismprop_organismprop_i".nextval
 INTO :new."organismprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phendesc_phendesc_id"
BEFORE INSERT ON "phendesc"
FOR EACH ROW WHEN (
 new."phendesc_id" IS NULL OR new."phendesc_id" = 0
)
BEGIN
 SELECT "sq_phendesc_phendesc_id".nextval
 INTO :new."phendesc_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phenotype_phenotype_id"
BEFORE INSERT ON "phenotype"
FOR EACH ROW WHEN (
 new."phenotype_id" IS NULL OR new."phenotype_id" = 0
)
BEGIN
 SELECT "sq_phenotype_phenotype_id".nextval
 INTO :new."phenotype_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phenotype_comparison_phenot"
BEFORE INSERT ON "phenotype_comparison"
FOR EACH ROW WHEN (
 new."phenotype_comparison_id" IS NULL OR new."phenotype_comparison_id" = 0
)
BEGIN
 SELECT "sq_phenotype_comparison_phenot".nextval
 INTO :new."phenotype_comparison_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phenotype_comparison_cvterm"
BEFORE INSERT ON "phenotype_comparison_cvterm"
FOR EACH ROW WHEN (
 new."phenotype_comparison_cvterm_id" IS NULL OR new."phenotype_comparison_cvterm_id" = 0
)
BEGIN
 SELECT "sq_phenotype_comparison_cvterm".nextval
 INTO :new."phenotype_comparison_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phenotype_cvterm_phenotype_"
BEFORE INSERT ON "phenotype_cvterm"
FOR EACH ROW WHEN (
 new."phenotype_cvterm_id" IS NULL OR new."phenotype_cvterm_id" = 0
)
BEGIN
 SELECT "sq_phenotype_cvterm_phenotype_".nextval
 INTO :new."phenotype_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phenstatement_phenstatement"
BEFORE INSERT ON "phenstatement"
FOR EACH ROW WHEN (
 new."phenstatement_id" IS NULL OR new."phenstatement_id" = 0
)
BEGIN
 SELECT "sq_phenstatement_phenstatement".nextval
 INTO :new."phenstatement_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phylonode_phylonode_id"
BEFORE INSERT ON "phylonode"
FOR EACH ROW WHEN (
 new."phylonode_id" IS NULL OR new."phylonode_id" = 0
)
BEGIN
 SELECT "sq_phylonode_phylonode_id".nextval
 INTO :new."phylonode_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phylonode_dbxref_phylonode_"
BEFORE INSERT ON "phylonode_dbxref"
FOR EACH ROW WHEN (
 new."phylonode_dbxref_id" IS NULL OR new."phylonode_dbxref_id" = 0
)
BEGIN
 SELECT "sq_phylonode_dbxref_phylonode_".nextval
 INTO :new."phylonode_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phylonode_organism_phylonod"
BEFORE INSERT ON "phylonode_organism"
FOR EACH ROW WHEN (
 new."phylonode_organism_id" IS NULL OR new."phylonode_organism_id" = 0
)
BEGIN
 SELECT "sq_phylonode_organism_phylonod".nextval
 INTO :new."phylonode_organism_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phylonode_pub_phylonode_pub"
BEFORE INSERT ON "phylonode_pub"
FOR EACH ROW WHEN (
 new."phylonode_pub_id" IS NULL OR new."phylonode_pub_id" = 0
)
BEGIN
 SELECT "sq_phylonode_pub_phylonode_pub".nextval
 INTO :new."phylonode_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phylonode_relationship_phyl"
BEFORE INSERT ON "phylonode_relationship"
FOR EACH ROW WHEN (
 new."phylonode_relationship_id" IS NULL OR new."phylonode_relationship_id" = 0
)
BEGIN
 SELECT "sq_phylonode_relationship_phyl".nextval
 INTO :new."phylonode_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phylonodeprop_phylonodeprop"
BEFORE INSERT ON "phylonodeprop"
FOR EACH ROW WHEN (
 new."phylonodeprop_id" IS NULL OR new."phylonodeprop_id" = 0
)
BEGIN
 SELECT "sq_phylonodeprop_phylonodeprop".nextval
 INTO :new."phylonodeprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phylotree_phylotree_id"
BEFORE INSERT ON "phylotree"
FOR EACH ROW WHEN (
 new."phylotree_id" IS NULL OR new."phylotree_id" = 0
)
BEGIN
 SELECT "sq_phylotree_phylotree_id".nextval
 INTO :new."phylotree_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_phylotree_pub_phylotree_pub"
BEFORE INSERT ON "phylotree_pub"
FOR EACH ROW WHEN (
 new."phylotree_pub_id" IS NULL OR new."phylotree_pub_id" = 0
)
BEGIN
 SELECT "sq_phylotree_pub_phylotree_pub".nextval
 INTO :new."phylotree_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_project_project_id"
BEFORE INSERT ON "project"
FOR EACH ROW WHEN (
 new."project_id" IS NULL OR new."project_id" = 0
)
BEGIN
 SELECT "sq_project_project_id".nextval
 INTO :new."project_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_project_contact_project_con"
BEFORE INSERT ON "project_contact"
FOR EACH ROW WHEN (
 new."project_contact_id" IS NULL OR new."project_contact_id" = 0
)
BEGIN
 SELECT "sq_project_contact_project_con".nextval
 INTO :new."project_contact_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_project_pub_project_pub_id"
BEFORE INSERT ON "project_pub"
FOR EACH ROW WHEN (
 new."project_pub_id" IS NULL OR new."project_pub_id" = 0
)
BEGIN
 SELECT "sq_project_pub_project_pub_id".nextval
 INTO :new."project_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_project_relationship_projec"
BEFORE INSERT ON "project_relationship"
FOR EACH ROW WHEN (
 new."project_relationship_id" IS NULL OR new."project_relationship_id" = 0
)
BEGIN
 SELECT "sq_project_relationship_projec".nextval
 INTO :new."project_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_projectprop_projectprop_id"
BEFORE INSERT ON "projectprop"
FOR EACH ROW WHEN (
 new."projectprop_id" IS NULL OR new."projectprop_id" = 0
)
BEGIN
 SELECT "sq_projectprop_projectprop_id".nextval
 INTO :new."projectprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_protein_coding_gene_timeacc"
BEFORE INSERT OR UPDATE ON "protein_coding_gene"
FOR EACH ROW WHEN (new."timeaccessioned" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timeaccessioned" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_protein_coding_gene_timelas"
BEFORE INSERT OR UPDATE ON "protein_coding_gene"
FOR EACH ROW WHEN (new."timelastmodified" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."timelastmodified" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_protocol_protocol_id"
BEFORE INSERT ON "protocol"
FOR EACH ROW WHEN (
 new."protocol_id" IS NULL OR new."protocol_id" = 0
)
BEGIN
 SELECT "sq_protocol_protocol_id".nextval
 INTO :new."protocol_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_protocolparam_protocolparam"
BEFORE INSERT ON "protocolparam"
FOR EACH ROW WHEN (
 new."protocolparam_id" IS NULL OR new."protocolparam_id" = 0
)
BEGIN
 SELECT "sq_protocolparam_protocolparam".nextval
 INTO :new."protocolparam_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_pub_pub_id"
BEFORE INSERT ON "pub"
FOR EACH ROW WHEN (
 new."pub_id" IS NULL OR new."pub_id" = 0
)
BEGIN
 SELECT "sq_pub_pub_id".nextval
 INTO :new."pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_pub_dbxref_pub_dbxref_id"
BEFORE INSERT ON "pub_dbxref"
FOR EACH ROW WHEN (
 new."pub_dbxref_id" IS NULL OR new."pub_dbxref_id" = 0
)
BEGIN
 SELECT "sq_pub_dbxref_pub_dbxref_id".nextval
 INTO :new."pub_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_pub_relationship_pub_relati"
BEFORE INSERT ON "pub_relationship"
FOR EACH ROW WHEN (
 new."pub_relationship_id" IS NULL OR new."pub_relationship_id" = 0
)
BEGIN
 SELECT "sq_pub_relationship_pub_relati".nextval
 INTO :new."pub_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_pubauthor_pubauthor_id"
BEFORE INSERT ON "pubauthor"
FOR EACH ROW WHEN (
 new."pubauthor_id" IS NULL OR new."pubauthor_id" = 0
)
BEGIN
 SELECT "sq_pubauthor_pubauthor_id".nextval
 INTO :new."pubauthor_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_pubprop_pubprop_id"
BEFORE INSERT ON "pubprop"
FOR EACH ROW WHEN (
 new."pubprop_id" IS NULL OR new."pubprop_id" = 0
)
BEGIN
 SELECT "sq_pubprop_pubprop_id".nextval
 INTO :new."pubprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_quantification_quantificati"
BEFORE INSERT ON "quantification"
FOR EACH ROW WHEN (
 new."quantification_id" IS NULL OR new."quantification_id" = 0
)
BEGIN
 SELECT "sq_quantification_quantificati".nextval
 INTO :new."quantification_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ts_quantification_quantificati"
BEFORE INSERT OR UPDATE ON "quantification"
FOR EACH ROW WHEN (new."quantificationdate" IS NULL)
BEGIN 
 SELECT sysdate INTO :new."quantificationdate" FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_quantification_relationship"
BEFORE INSERT ON "quantification_relationship"
FOR EACH ROW WHEN (
 new."quantification_relationship_id" IS NULL OR new."quantification_relationship_id" = 0
)
BEGIN
 SELECT "sq_quantification_relationship".nextval
 INTO :new."quantification_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_quantificationprop_quantifi"
BEFORE INSERT ON "quantificationprop"
FOR EACH ROW WHEN (
 new."quantificationprop_id" IS NULL OR new."quantificationprop_id" = 0
)
BEGIN
 SELECT "sq_quantificationprop_quantifi".nextval
 INTO :new."quantificationprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_stock_id"
BEFORE INSERT ON "stock"
FOR EACH ROW WHEN (
 new."stock_id" IS NULL OR new."stock_id" = 0
)
BEGIN
 SELECT "sq_stock_stock_id".nextval
 INTO :new."stock_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_cvterm_stock_cvterm_i"
BEFORE INSERT ON "stock_cvterm"
FOR EACH ROW WHEN (
 new."stock_cvterm_id" IS NULL OR new."stock_cvterm_id" = 0
)
BEGIN
 SELECT "sq_stock_cvterm_stock_cvterm_i".nextval
 INTO :new."stock_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_cvtermprop_stock_cvte"
BEFORE INSERT ON "stock_cvtermprop"
FOR EACH ROW WHEN (
 new."stock_cvtermprop_id" IS NULL OR new."stock_cvtermprop_id" = 0
)
BEGIN
 SELECT "sq_stock_cvtermprop_stock_cvte".nextval
 INTO :new."stock_cvtermprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_dbxref_stock_dbxref_i"
BEFORE INSERT ON "stock_dbxref"
FOR EACH ROW WHEN (
 new."stock_dbxref_id" IS NULL OR new."stock_dbxref_id" = 0
)
BEGIN
 SELECT "sq_stock_dbxref_stock_dbxref_i".nextval
 INTO :new."stock_dbxref_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_dbxrefprop_stock_dbxr"
BEFORE INSERT ON "stock_dbxrefprop"
FOR EACH ROW WHEN (
 new."stock_dbxrefprop_id" IS NULL OR new."stock_dbxrefprop_id" = 0
)
BEGIN
 SELECT "sq_stock_dbxrefprop_stock_dbxr".nextval
 INTO :new."stock_dbxrefprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_genotype_stock_genoty"
BEFORE INSERT ON "stock_genotype"
FOR EACH ROW WHEN (
 new."stock_genotype_id" IS NULL OR new."stock_genotype_id" = 0
)
BEGIN
 SELECT "sq_stock_genotype_stock_genoty".nextval
 INTO :new."stock_genotype_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_pub_stock_pub_id"
BEFORE INSERT ON "stock_pub"
FOR EACH ROW WHEN (
 new."stock_pub_id" IS NULL OR new."stock_pub_id" = 0
)
BEGIN
 SELECT "sq_stock_pub_stock_pub_id".nextval
 INTO :new."stock_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_relationship_stock_re"
BEFORE INSERT ON "stock_relationship"
FOR EACH ROW WHEN (
 new."stock_relationship_id" IS NULL OR new."stock_relationship_id" = 0
)
BEGIN
 SELECT "sq_stock_relationship_stock_re".nextval
 INTO :new."stock_relationship_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_relationship_cvterm_s"
BEFORE INSERT ON "stock_relationship_cvterm"
FOR EACH ROW WHEN (
 new."stock_relationship_cvterm_id" IS NULL OR new."stock_relationship_cvterm_id" = 0
)
BEGIN
 SELECT "sq_stock_relationship_cvterm_s".nextval
 INTO :new."stock_relationship_cvterm_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stock_relationship_pub_stoc"
BEFORE INSERT ON "stock_relationship_pub"
FOR EACH ROW WHEN (
 new."stock_relationship_pub_id" IS NULL OR new."stock_relationship_pub_id" = 0
)
BEGIN
 SELECT "sq_stock_relationship_pub_stoc".nextval
 INTO :new."stock_relationship_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stockcollection_stockcollec"
BEFORE INSERT ON "stockcollection"
FOR EACH ROW WHEN (
 new."stockcollection_id" IS NULL OR new."stockcollection_id" = 0
)
BEGIN
 SELECT "sq_stockcollection_stockcollec".nextval
 INTO :new."stockcollection_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stockcollection_stock_stock"
BEFORE INSERT ON "stockcollection_stock"
FOR EACH ROW WHEN (
 new."stockcollection_stock_id" IS NULL OR new."stockcollection_stock_id" = 0
)
BEGIN
 SELECT "sq_stockcollection_stock_stock".nextval
 INTO :new."stockcollection_stock_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stockcollectionprop_stockco"
BEFORE INSERT ON "stockcollectionprop"
FOR EACH ROW WHEN (
 new."stockcollectionprop_id" IS NULL OR new."stockcollectionprop_id" = 0
)
BEGIN
 SELECT "sq_stockcollectionprop_stockco".nextval
 INTO :new."stockcollectionprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stockprop_stockprop_id"
BEFORE INSERT ON "stockprop"
FOR EACH ROW WHEN (
 new."stockprop_id" IS NULL OR new."stockprop_id" = 0
)
BEGIN
 SELECT "sq_stockprop_stockprop_id".nextval
 INTO :new."stockprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_stockprop_pub_stockprop_pub"
BEFORE INSERT ON "stockprop_pub"
FOR EACH ROW WHEN (
 new."stockprop_pub_id" IS NULL OR new."stockprop_pub_id" = 0
)
BEGIN
 SELECT "sq_stockprop_pub_stockprop_pub".nextval
 INTO :new."stockprop_pub_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_study_study_id"
BEFORE INSERT ON "study"
FOR EACH ROW WHEN (
 new."study_id" IS NULL OR new."study_id" = 0
)
BEGIN
 SELECT "sq_study_study_id".nextval
 INTO :new."study_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_study_assay_study_assay_id"
BEFORE INSERT ON "study_assay"
FOR EACH ROW WHEN (
 new."study_assay_id" IS NULL OR new."study_assay_id" = 0
)
BEGIN
 SELECT "sq_study_assay_study_assay_id".nextval
 INTO :new."study_assay_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_studydesign_studydesign_id"
BEFORE INSERT ON "studydesign"
FOR EACH ROW WHEN (
 new."studydesign_id" IS NULL OR new."studydesign_id" = 0
)
BEGIN
 SELECT "sq_studydesign_studydesign_id".nextval
 INTO :new."studydesign_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_studydesignprop_studydesign"
BEFORE INSERT ON "studydesignprop"
FOR EACH ROW WHEN (
 new."studydesignprop_id" IS NULL OR new."studydesignprop_id" = 0
)
BEGIN
 SELECT "sq_studydesignprop_studydesign".nextval
 INTO :new."studydesignprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_studyfactor_studyfactor_id"
BEFORE INSERT ON "studyfactor"
FOR EACH ROW WHEN (
 new."studyfactor_id" IS NULL OR new."studyfactor_id" = 0
)
BEGIN
 SELECT "sq_studyfactor_studyfactor_id".nextval
 INTO :new."studyfactor_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_studyfactorvalue_studyfacto"
BEFORE INSERT ON "studyfactorvalue"
FOR EACH ROW WHEN (
 new."studyfactorvalue_id" IS NULL OR new."studyfactorvalue_id" = 0
)
BEGIN
 SELECT "sq_studyfactorvalue_studyfacto".nextval
 INTO :new."studyfactorvalue_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_studyprop_studyprop_id"
BEFORE INSERT ON "studyprop"
FOR EACH ROW WHEN (
 new."studyprop_id" IS NULL OR new."studyprop_id" = 0
)
BEGIN
 SELECT "sq_studyprop_studyprop_id".nextval
 INTO :new."studyprop_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_studyprop_feature_studyprop"
BEFORE INSERT ON "studyprop_feature"
FOR EACH ROW WHEN (
 new."studyprop_feature_id" IS NULL OR new."studyprop_feature_id" = 0
)
BEGIN
 SELECT "sq_studyprop_feature_studyprop".nextval
 INTO :new."studyprop_feature_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_synonym__synonym_id"
BEFORE INSERT ON "synonym_"
FOR EACH ROW WHEN (
 new."synonym_id" IS NULL OR new."synonym_id" = 0
)
BEGIN
 SELECT "sq_synonym__synonym_id".nextval
 INTO :new."synonym_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_tableinfo_tableinfo_id"
BEFORE INSERT ON "tableinfo"
FOR EACH ROW WHEN (
 new."tableinfo_id" IS NULL OR new."tableinfo_id" = 0
)
BEGIN
 SELECT "sq_tableinfo_tableinfo_id".nextval
 INTO :new."tableinfo_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_treatment_treatment_id"
BEFORE INSERT ON "treatment"
FOR EACH ROW WHEN (
 new."treatment_id" IS NULL OR new."treatment_id" = 0
)
BEGIN
 SELECT "sq_treatment_treatment_id".nextval
 INTO :new."treatment_id"
 FROM dual;
END;
;
CREATE OR REPLACE TRIGGER "ai_featureprop_featureprop_id"
BEFORE INSERT ON "featureprop"
FOR EACH ROW WHEN (
 new."featureprop_id" IS NULL OR new."featureprop_id" = 0
)
BEGIN
 SELECT "sq_featureprop_featureprop_id".nextval
 INTO :new."featureprop_id"
 FROM dual;
END;
;
CREATE INDEX "acquisition_idx_assay_id" on "acquisition" ("assay_id");
CREATE INDEX "acquisition_idx_channel_id" on "acquisition" ("channel_id");
CREATE INDEX "acquisition_idx_protocol_id" on "acquisition" ("protocol_id");
CREATE INDEX "acquisition_relationship_idx_o" on "acquisition_relationship" ("object_id");
CREATE INDEX "acquisition_relationship_idx_s" on "acquisition_relationship" ("subject_id");
CREATE INDEX "acquisition_relationship_idx_t" on "acquisition_relationship" ("type_id");
CREATE INDEX "acquisitionprop_idx_acquisitio" on "acquisitionprop" ("acquisition_id");
CREATE INDEX "acquisitionprop_idx_type_id" on "acquisitionprop" ("type_id");
CREATE INDEX "analysisfeature_idx_analysis_i" on "analysisfeature" ("analysis_id");
CREATE INDEX "analysisfeature_idx_feature_id" on "analysisfeature" ("feature_id");
CREATE INDEX "analysisfeatureprop_idx_analys" on "analysisfeatureprop" ("analysisfeature_id");
CREATE INDEX "analysisfeatureprop_idx_type_i" on "analysisfeatureprop" ("type_id");
CREATE INDEX "analysisprop_idx_analysis_id" on "analysisprop" ("analysis_id");
CREATE INDEX "analysisprop_idx_type_id" on "analysisprop" ("type_id");
CREATE INDEX "arraydesign_idx_dbxref_id" on "arraydesign" ("dbxref_id");
CREATE INDEX "arraydesign_idx_manufacturer_i" on "arraydesign" ("manufacturer_id");
CREATE INDEX "arraydesign_idx_platformtype_i" on "arraydesign" ("platformtype_id");
CREATE INDEX "arraydesign_idx_protocol_id" on "arraydesign" ("protocol_id");
CREATE INDEX "arraydesign_idx_substratetype_" on "arraydesign" ("substratetype_id");
CREATE INDEX "arraydesignprop_idx_arraydesig" on "arraydesignprop" ("arraydesign_id");
CREATE INDEX "arraydesignprop_idx_type_id" on "arraydesignprop" ("type_id");
CREATE INDEX "assay_idx_arraydesign_id" on "assay" ("arraydesign_id");
CREATE INDEX "assay_idx_dbxref_id" on "assay" ("dbxref_id");
CREATE INDEX "assay_idx_operator_id" on "assay" ("operator_id");
CREATE INDEX "assay_idx_protocol_id" on "assay" ("protocol_id");
CREATE INDEX "assay_biomaterial_idx_assay_id" on "assay_biomaterial" ("assay_id");
CREATE INDEX "assay_biomaterial_idx_biomater" on "assay_biomaterial" ("biomaterial_id");
CREATE INDEX "assay_biomaterial_idx_channel_" on "assay_biomaterial" ("channel_id");
CREATE INDEX "assay_project_idx_assay_id" on "assay_project" ("assay_id");
CREATE INDEX "assay_project_idx_project_id" on "assay_project" ("project_id");
CREATE INDEX "assayprop_idx_assay_id" on "assayprop" ("assay_id");
CREATE INDEX "assayprop_idx_type_id" on "assayprop" ("type_id");
CREATE INDEX "biomaterial_idx_biosourceprovi" on "biomaterial" ("biosourceprovider_id");
CREATE INDEX "biomaterial_idx_dbxref_id" on "biomaterial" ("dbxref_id");
CREATE INDEX "biomaterial_idx_taxon_id" on "biomaterial" ("taxon_id");
CREATE INDEX "biomaterial_dbxref_idx_biomate" on "biomaterial_dbxref" ("biomaterial_id");
CREATE INDEX "biomaterial_dbxref_idx_dbxref_" on "biomaterial_dbxref" ("dbxref_id");
CREATE INDEX "biomaterial_relationship_idx_o" on "biomaterial_relationship" ("object_id");
CREATE INDEX "biomaterial_relationship_idx_s" on "biomaterial_relationship" ("subject_id");
CREATE INDEX "biomaterial_relationship_idx_t" on "biomaterial_relationship" ("type_id");
CREATE INDEX "biomaterial_treatment_idx_biom" on "biomaterial_treatment" ("biomaterial_id");
CREATE INDEX "biomaterial_treatment_idx_trea" on "biomaterial_treatment" ("treatment_id");
CREATE INDEX "biomaterial_treatment_idx_unit" on "biomaterial_treatment" ("unittype_id");
CREATE INDEX "biomaterialprop_idx_biomateria" on "biomaterialprop" ("biomaterial_id");
CREATE INDEX "biomaterialprop_idx_type_id" on "biomaterialprop" ("type_id");
CREATE INDEX "cell_line_idx_organism_id" on "cell_line" ("organism_id");
CREATE INDEX "cell_line_cvterm_idx_cell_line" on "cell_line_cvterm" ("cell_line_id");
CREATE INDEX "cell_line_cvterm_idx_cvterm_id" on "cell_line_cvterm" ("cvterm_id");
CREATE INDEX "cell_line_cvterm_idx_pub_id" on "cell_line_cvterm" ("pub_id");
CREATE INDEX "cell_line_cvtermprop_idx_cell_" on "cell_line_cvtermprop" ("cell_line_cvterm_id");
CREATE INDEX "cell_line_cvtermprop_idx_type_" on "cell_line_cvtermprop" ("type_id");
CREATE INDEX "cell_line_dbxref_idx_cell_line" on "cell_line_dbxref" ("cell_line_id");
CREATE INDEX "cell_line_dbxref_idx_dbxref_id" on "cell_line_dbxref" ("dbxref_id");
CREATE INDEX "cell_line_feature_idx_cell_lin" on "cell_line_feature" ("cell_line_id");
CREATE INDEX "cell_line_feature_idx_feature_" on "cell_line_feature" ("feature_id");
CREATE INDEX "cell_line_feature_idx_pub_id" on "cell_line_feature" ("pub_id");
CREATE INDEX "cell_line_library_idx_cell_lin" on "cell_line_library" ("cell_line_id");
CREATE INDEX "cell_line_library_idx_library_" on "cell_line_library" ("library_id");
CREATE INDEX "cell_line_library_idx_pub_id" on "cell_line_library" ("pub_id");
CREATE INDEX "cell_line_pub_idx_cell_line_id" on "cell_line_pub" ("cell_line_id");
CREATE INDEX "cell_line_pub_idx_pub_id" on "cell_line_pub" ("pub_id");
CREATE INDEX "cell_line_relationship_idx_obj" on "cell_line_relationship" ("object_id");
CREATE INDEX "cell_line_relationship_idx_sub" on "cell_line_relationship" ("subject_id");
CREATE INDEX "cell_line_relationship_idx_typ" on "cell_line_relationship" ("type_id");
CREATE INDEX "cell_line_synonym_idx_cell_lin" on "cell_line_synonym" ("cell_line_id");
CREATE INDEX "cell_line_synonym_idx_pub_id" on "cell_line_synonym" ("pub_id");
CREATE INDEX "cell_line_synonym_idx_synonym_" on "cell_line_synonym" ("synonym_id");
CREATE INDEX "cell_lineprop_idx_cell_line_id" on "cell_lineprop" ("cell_line_id");
CREATE INDEX "cell_lineprop_idx_type_id" on "cell_lineprop" ("type_id");
CREATE INDEX "cell_lineprop_pub_idx_cell_lin" on "cell_lineprop_pub" ("cell_lineprop_id");
CREATE INDEX "cell_lineprop_pub_idx_pub_id" on "cell_lineprop_pub" ("pub_id");
CREATE INDEX "contact_idx_type_id" on "contact" ("type_id");
CREATE INDEX "contact_relationship_idx_objec" on "contact_relationship" ("object_id");
CREATE INDEX "contact_relationship_idx_subje" on "contact_relationship" ("subject_id");
CREATE INDEX "contact_relationship_idx_type_" on "contact_relationship" ("type_id");
CREATE INDEX "control_idx_assay_id" on "control" ("assay_id");
CREATE INDEX "control_idx_tableinfo_id" on "control" ("tableinfo_id");
CREATE INDEX "control_idx_type_id" on "control" ("type_id");
CREATE INDEX "cvprop_idx_cv_id" on "cvprop" ("cv_id");
CREATE INDEX "cvprop_idx_type_id" on "cvprop" ("type_id");
CREATE INDEX "cvterm_idx_cv_id" on "cvterm" ("cv_id");
CREATE INDEX "cvterm_idx_dbxref_id" on "cvterm" ("dbxref_id");
CREATE INDEX "cvterm_dbxref_idx_cvterm_id" on "cvterm_dbxref" ("cvterm_id");
CREATE INDEX "cvterm_dbxref_idx_dbxref_id" on "cvterm_dbxref" ("dbxref_id");
CREATE INDEX "cvterm_relationship_idx_object" on "cvterm_relationship" ("object_id");
CREATE INDEX "cvterm_relationship_idx_subjec" on "cvterm_relationship" ("subject_id");
CREATE INDEX "cvterm_relationship_idx_type_i" on "cvterm_relationship" ("type_id");
CREATE INDEX "cvtermpath_idx_cv_id" on "cvtermpath" ("cv_id");
CREATE INDEX "cvtermpath_idx_object_id" on "cvtermpath" ("object_id");
CREATE INDEX "cvtermpath_idx_subject_id" on "cvtermpath" ("subject_id");
CREATE INDEX "cvtermpath_idx_type_id" on "cvtermpath" ("type_id");
CREATE INDEX "cvtermprop_idx_cvterm_id" on "cvtermprop" ("cvterm_id");
CREATE INDEX "cvtermprop_idx_type_id" on "cvtermprop" ("type_id");
CREATE INDEX "cvtermsynonym_idx_cvterm_id" on "cvtermsynonym" ("cvterm_id");
CREATE INDEX "cvtermsynonym_idx_type_id" on "cvtermsynonym" ("type_id");
CREATE INDEX "dbxref_idx_db_id" on "dbxref" ("db_id");
CREATE INDEX "dbxrefprop_idx_dbxref_id" on "dbxrefprop" ("dbxref_id");
CREATE INDEX "dbxrefprop_idx_type_id" on "dbxrefprop" ("type_id");
CREATE INDEX "element_idx_arraydesign_id" on "element" ("arraydesign_id");
CREATE INDEX "element_idx_dbxref_id" on "element" ("dbxref_id");
CREATE INDEX "element_idx_feature_id" on "element" ("feature_id");
CREATE INDEX "element_idx_type_id" on "element" ("type_id");
CREATE INDEX "element_relationship_idx_objec" on "element_relationship" ("object_id");
CREATE INDEX "element_relationship_idx_subje" on "element_relationship" ("subject_id");
CREATE INDEX "element_relationship_idx_type_" on "element_relationship" ("type_id");
CREATE INDEX "elementresult_idx_element_id" on "elementresult" ("element_id");
CREATE INDEX "elementresult_idx_quantificati" on "elementresult" ("quantification_id");
CREATE INDEX "elementresult_relationship_idx" on "elementresult_relationship" ("object_id");
CREATE INDEX "elementresult_relationship_i01" on "elementresult_relationship" ("subject_id");
CREATE INDEX "elementresult_relationship_i02" on "elementresult_relationship" ("type_id");
CREATE INDEX "environment_cvterm_idx_cvterm_" on "environment_cvterm" ("cvterm_id");
CREATE INDEX "environment_cvterm_idx_environ" on "environment_cvterm" ("environment_id");
CREATE INDEX "expression_cvterm_idx_cvterm_i" on "expression_cvterm" ("cvterm_id");
CREATE INDEX "expression_cvterm_idx_cvterm_t" on "expression_cvterm" ("cvterm_type_id");
CREATE INDEX "expression_cvterm_idx_expressi" on "expression_cvterm" ("expression_id");
CREATE INDEX "expression_cvtermprop_idx_expr" on "expression_cvtermprop" ("expression_cvterm_id");
CREATE INDEX "expression_cvtermprop_idx_type" on "expression_cvtermprop" ("type_id");
CREATE INDEX "expression_image_idx_eimage_id" on "expression_image" ("eimage_id");
CREATE INDEX "expression_image_idx_expressio" on "expression_image" ("expression_id");
CREATE INDEX "expression_pub_idx_expression_" on "expression_pub" ("expression_id");
CREATE INDEX "expression_pub_idx_pub_id" on "expression_pub" ("pub_id");
CREATE INDEX "expressionprop_idx_expression_" on "expressionprop" ("expression_id");
CREATE INDEX "expressionprop_idx_type_id" on "expressionprop" ("type_id");
CREATE INDEX "feature_idx_dbxref_id" on "feature" ("dbxref_id");
CREATE INDEX "feature_idx_organism_id" on "feature" ("organism_id");
CREATE INDEX "feature_idx_type_id" on "feature" ("type_id");
CREATE INDEX "feature_cvterm_idx_cvterm_id" on "feature_cvterm" ("cvterm_id");
CREATE INDEX "feature_cvterm_idx_feature_id" on "feature_cvterm" ("feature_id");
CREATE INDEX "feature_cvterm_idx_pub_id" on "feature_cvterm" ("pub_id");
CREATE INDEX "feature_cvterm_dbxref_idx_dbxr" on "feature_cvterm_dbxref" ("dbxref_id");
CREATE INDEX "feature_cvterm_dbxref_idx_feat" on "feature_cvterm_dbxref" ("feature_cvterm_id");
CREATE INDEX "feature_cvterm_pub_idx_feature" on "feature_cvterm_pub" ("feature_cvterm_id");
CREATE INDEX "feature_cvterm_pub_idx_pub_id" on "feature_cvterm_pub" ("pub_id");
CREATE INDEX "feature_cvtermprop_idx_feature" on "feature_cvtermprop" ("feature_cvterm_id");
CREATE INDEX "feature_cvtermprop_idx_type_id" on "feature_cvtermprop" ("type_id");
CREATE INDEX "feature_dbxref_idx_dbxref_id" on "feature_dbxref" ("dbxref_id");
CREATE INDEX "feature_dbxref_idx_feature_id" on "feature_dbxref" ("feature_id");
CREATE INDEX "feature_expression_idx_express" on "feature_expression" ("expression_id");
CREATE INDEX "feature_expression_idx_feature" on "feature_expression" ("feature_id");
CREATE INDEX "feature_expression_idx_pub_id" on "feature_expression" ("pub_id");
CREATE INDEX "feature_expressionprop_idx_fea" on "feature_expressionprop" ("feature_expression_id");
CREATE INDEX "feature_expressionprop_idx_typ" on "feature_expressionprop" ("type_id");
CREATE INDEX "feature_genotype_idx_chromosom" on "feature_genotype" ("chromosome_id");
CREATE INDEX "feature_genotype_idx_cvterm_id" on "feature_genotype" ("cvterm_id");
CREATE INDEX "feature_genotype_idx_feature_i" on "feature_genotype" ("feature_id");
CREATE INDEX "feature_genotype_idx_genotype_" on "feature_genotype" ("genotype_id");
CREATE INDEX "feature_phenotype_idx_feature_" on "feature_phenotype" ("feature_id");
CREATE INDEX "feature_phenotype_idx_phenotyp" on "feature_phenotype" ("phenotype_id");
CREATE INDEX "feature_pub_idx_feature_id" on "feature_pub" ("feature_id");
CREATE INDEX "feature_pub_idx_pub_id" on "feature_pub" ("pub_id");
CREATE INDEX "feature_pubprop_idx_feature_pu" on "feature_pubprop" ("feature_pub_id");
CREATE INDEX "feature_pubprop_idx_type_id" on "feature_pubprop" ("type_id");
CREATE INDEX "feature_relationship_idx_objec" on "feature_relationship" ("object_id");
CREATE INDEX "feature_relationship_idx_subje" on "feature_relationship" ("subject_id");
CREATE INDEX "feature_relationship_idx_type_" on "feature_relationship" ("type_id");
CREATE INDEX "feature_relationship_pub_idx_f" on "feature_relationship_pub" ("feature_relationship_id");
CREATE INDEX "feature_relationship_pub_idx_p" on "feature_relationship_pub" ("pub_id");
CREATE INDEX "feature_relationshipprop_idx_f" on "feature_relationshipprop" ("feature_relationship_id");
CREATE INDEX "feature_relationshipprop_idx_t" on "feature_relationshipprop" ("type_id");
CREATE INDEX "feature_relationshipprop_pub_i" on "feature_relationshipprop_pub" ("feature_relationshipprop_id");
CREATE INDEX "feature_relationshipprop_pub01" on "feature_relationshipprop_pub" ("pub_id");
CREATE INDEX "feature_synonym_idx_feature_id" on "feature_synonym" ("feature_id");
CREATE INDEX "feature_synonym_idx_pub_id" on "feature_synonym" ("pub_id");
CREATE INDEX "feature_synonym_idx_synonym_id" on "feature_synonym" ("synonym_id");
CREATE INDEX "featureloc_idx_feature_id" on "featureloc" ("feature_id");
CREATE INDEX "featureloc_idx_srcfeature_id" on "featureloc" ("srcfeature_id");
CREATE INDEX "featureloc_pub_idx_featureloc_" on "featureloc_pub" ("featureloc_id");
CREATE INDEX "featureloc_pub_idx_pub_id" on "featureloc_pub" ("pub_id");
CREATE INDEX "featuremap_idx_unittype_id" on "featuremap" ("unittype_id");
CREATE INDEX "featuremap_pub_idx_featuremap_" on "featuremap_pub" ("featuremap_id");
CREATE INDEX "featuremap_pub_idx_pub_id" on "featuremap_pub" ("pub_id");
CREATE INDEX "featurepos_idx_feature_id" on "featurepos" ("feature_id");
CREATE INDEX "featurepos_idx_featuremap_id" on "featurepos" ("featuremap_id");
CREATE INDEX "featurepos_idx_map_feature_id" on "featurepos" ("map_feature_id");
CREATE INDEX "featureprop_pub_idx_featurepro" on "featureprop_pub" ("featureprop_id");
CREATE INDEX "featureprop_pub_idx_pub_id" on "featureprop_pub" ("pub_id");
CREATE INDEX "featurerange_idx_feature_id" on "featurerange" ("feature_id");
CREATE INDEX "featurerange_idx_featuremap_id" on "featurerange" ("featuremap_id");
CREATE INDEX "featurerange_idx_leftendf_id" on "featurerange" ("leftendf_id");
CREATE INDEX "featurerange_idx_leftstartf_id" on "featurerange" ("leftstartf_id");
CREATE INDEX "featurerange_idx_rightendf_id" on "featurerange" ("rightendf_id");
CREATE INDEX "featurerange_idx_rightstartf_i" on "featurerange" ("rightstartf_id");
CREATE INDEX "genotype_idx_type_id" on "genotype" ("type_id");
CREATE INDEX "genotypeprop_idx_genotype_id" on "genotypeprop" ("genotype_id");
CREATE INDEX "genotypeprop_idx_type_id" on "genotypeprop" ("type_id");
CREATE INDEX "library_idx_organism_id" on "library" ("organism_id");
CREATE INDEX "library_idx_type_id" on "library" ("type_id");
CREATE INDEX "library_cvterm_idx_cvterm_id" on "library_cvterm" ("cvterm_id");
CREATE INDEX "library_cvterm_idx_library_id" on "library_cvterm" ("library_id");
CREATE INDEX "library_cvterm_idx_pub_id" on "library_cvterm" ("pub_id");
CREATE INDEX "library_dbxref_idx_dbxref_id" on "library_dbxref" ("dbxref_id");
CREATE INDEX "library_dbxref_idx_library_id" on "library_dbxref" ("library_id");
CREATE INDEX "library_feature_idx_feature_id" on "library_feature" ("feature_id");
CREATE INDEX "library_feature_idx_library_id" on "library_feature" ("library_id");
CREATE INDEX "library_pub_idx_library_id" on "library_pub" ("library_id");
CREATE INDEX "library_pub_idx_pub_id" on "library_pub" ("pub_id");
CREATE INDEX "library_synonym_idx_library_id" on "library_synonym" ("library_id");
CREATE INDEX "library_synonym_idx_pub_id" on "library_synonym" ("pub_id");
CREATE INDEX "library_synonym_idx_synonym_id" on "library_synonym" ("synonym_id");
CREATE INDEX "libraryprop_idx_library_id" on "libraryprop" ("library_id");
CREATE INDEX "libraryprop_idx_type_id" on "libraryprop" ("type_id");
CREATE INDEX "libraryprop_pub_idx_librarypro" on "libraryprop_pub" ("libraryprop_id");
CREATE INDEX "libraryprop_pub_idx_pub_id" on "libraryprop_pub" ("pub_id");
CREATE INDEX "magedocumentation_idx_mageml_i" on "magedocumentation" ("mageml_id");
CREATE INDEX "magedocumentation_idx_tableinf" on "magedocumentation" ("tableinfo_id");
CREATE INDEX "nd_experiment_idx_nd_geolocati" on "nd_experiment" ("nd_geolocation_id");
CREATE INDEX "nd_experiment_idx_type_id" on "nd_experiment" ("type_id");
CREATE INDEX "nd_experiment_contact_idx_cont" on "nd_experiment_contact" ("contact_id");
CREATE INDEX "nd_experiment_contact_idx_nd_e" on "nd_experiment_contact" ("nd_experiment_id");
CREATE INDEX "nd_experiment_dbxref_idx_dbxre" on "nd_experiment_dbxref" ("dbxref_id");
CREATE INDEX "nd_experiment_dbxref_idx_nd_ex" on "nd_experiment_dbxref" ("nd_experiment_id");
CREATE INDEX "nd_experiment_genotype_idx_gen" on "nd_experiment_genotype" ("genotype_id");
CREATE INDEX "nd_experiment_genotype_idx_nd_" on "nd_experiment_genotype" ("nd_experiment_id");
CREATE INDEX "nd_experiment_phenotype_idx_nd" on "nd_experiment_phenotype" ("nd_experiment_id");
CREATE INDEX "nd_experiment_phenotype_idx_ph" on "nd_experiment_phenotype" ("phenotype_id");
CREATE INDEX "nd_experiment_project_idx_nd_e" on "nd_experiment_project" ("nd_experiment_id");
CREATE INDEX "nd_experiment_project_idx_proj" on "nd_experiment_project" ("project_id");
CREATE INDEX "nd_experiment_protocol_idx_nd_" on "nd_experiment_protocol" ("nd_experiment_id");
CREATE INDEX "nd_experiment_protocol_idx_n01" on "nd_experiment_protocol" ("nd_protocol_id");
CREATE INDEX "nd_experiment_pub_idx_nd_exper" on "nd_experiment_pub" ("nd_experiment_id");
CREATE INDEX "nd_experiment_pub_idx_pub_id" on "nd_experiment_pub" ("pub_id");
CREATE INDEX "nd_experiment_stock_idx_nd_exp" on "nd_experiment_stock" ("nd_experiment_id");
CREATE INDEX "nd_experiment_stock_idx_stock_" on "nd_experiment_stock" ("stock_id");
CREATE INDEX "nd_experiment_stock_idx_type_i" on "nd_experiment_stock" ("type_id");
CREATE INDEX "nd_experiment_stock_dbxref_idx" on "nd_experiment_stock_dbxref" ("dbxref_id");
CREATE INDEX "nd_experiment_stock_dbxref_i01" on "nd_experiment_stock_dbxref" ("nd_experiment_stock_id");
CREATE INDEX "nd_experiment_stockprop_idx_nd" on "nd_experiment_stockprop" ("nd_experiment_stock_id");
CREATE INDEX "nd_experiment_stockprop_idx_ty" on "nd_experiment_stockprop" ("type_id");
CREATE INDEX "nd_experimentprop_idx_nd_exper" on "nd_experimentprop" ("nd_experiment_id");
CREATE INDEX "nd_experimentprop_idx_type_id" on "nd_experimentprop" ("type_id");
CREATE INDEX "nd_geolocationprop_idx_nd_geol" on "nd_geolocationprop" ("nd_geolocation_id");
CREATE INDEX "nd_geolocationprop_idx_type_id" on "nd_geolocationprop" ("type_id");
CREATE INDEX "nd_protocol_idx_type_id" on "nd_protocol" ("type_id");
CREATE INDEX "nd_protocol_reagent_idx_nd_pro" on "nd_protocol_reagent" ("nd_protocol_id");
CREATE INDEX "nd_protocol_reagent_idx_reagen" on "nd_protocol_reagent" ("reagent_id");
CREATE INDEX "nd_protocol_reagent_idx_type_i" on "nd_protocol_reagent" ("type_id");
CREATE INDEX "nd_protocolprop_idx_nd_protoco" on "nd_protocolprop" ("nd_protocol_id");
CREATE INDEX "nd_protocolprop_idx_type_id" on "nd_protocolprop" ("type_id");
CREATE INDEX "nd_reagent_idx_type_id" on "nd_reagent" ("type_id");
CREATE INDEX "nd_reagent_relationship_idx_ob" on "nd_reagent_relationship" ("object_reagent_id");
CREATE INDEX "nd_reagent_relationship_idx_su" on "nd_reagent_relationship" ("subject_reagent_id");
CREATE INDEX "nd_reagent_relationship_idx_ty" on "nd_reagent_relationship" ("type_id");
CREATE INDEX "nd_reagentprop_idx_nd_reagent_" on "nd_reagentprop" ("nd_reagent_id");
CREATE INDEX "nd_reagentprop_idx_type_id" on "nd_reagentprop" ("type_id");
CREATE INDEX "organism_dbxref_idx_dbxref_id" on "organism_dbxref" ("dbxref_id");
CREATE INDEX "organism_dbxref_idx_organism_i" on "organism_dbxref" ("organism_id");
CREATE INDEX "organismprop_idx_organism_id" on "organismprop" ("organism_id");
CREATE INDEX "organismprop_idx_type_id" on "organismprop" ("type_id");
CREATE INDEX "phendesc_idx_environment_id" on "phendesc" ("environment_id");
CREATE INDEX "phendesc_idx_genotype_id" on "phendesc" ("genotype_id");
CREATE INDEX "phendesc_idx_pub_id" on "phendesc" ("pub_id");
CREATE INDEX "phendesc_idx_type_id" on "phendesc" ("type_id");
CREATE INDEX "phenotype_idx_assay_id" on "phenotype" ("assay_id");
CREATE INDEX "phenotype_idx_attr_id" on "phenotype" ("attr_id");
CREATE INDEX "phenotype_idx_cvalue_id" on "phenotype" ("cvalue_id");
CREATE INDEX "phenotype_idx_observable_id" on "phenotype" ("observable_id");
CREATE INDEX "phenotype_comparison_idx_envir" on "phenotype_comparison" ("environment1_id");
CREATE INDEX "phenotype_comparison_idx_env01" on "phenotype_comparison" ("environment2_id");
CREATE INDEX "phenotype_comparison_idx_genot" on "phenotype_comparison" ("genotype1_id");
CREATE INDEX "phenotype_comparison_idx_gen01" on "phenotype_comparison" ("genotype2_id");
CREATE INDEX "phenotype_comparison_idx_organ" on "phenotype_comparison" ("organism_id");
CREATE INDEX "phenotype_comparison_idx_pheno" on "phenotype_comparison" ("phenotype1_id");
CREATE INDEX "phenotype_comparison_idx_phe01" on "phenotype_comparison" ("phenotype2_id");
CREATE INDEX "phenotype_comparison_idx_pub_i" on "phenotype_comparison" ("pub_id");
CREATE INDEX "phenotype_comparison_cvterm_id" on "phenotype_comparison_cvterm" ("cvterm_id");
CREATE INDEX "phenotype_comparison_cvterm_01" on "phenotype_comparison_cvterm" ("phenotype_comparison_id");
CREATE INDEX "phenotype_comparison_cvterm_02" on "phenotype_comparison_cvterm" ("pub_id");
CREATE INDEX "phenotype_cvterm_idx_cvterm_id" on "phenotype_cvterm" ("cvterm_id");
CREATE INDEX "phenotype_cvterm_idx_phenotype" on "phenotype_cvterm" ("phenotype_id");
CREATE INDEX "phenstatement_idx_environment_" on "phenstatement" ("environment_id");
CREATE INDEX "phenstatement_idx_genotype_id" on "phenstatement" ("genotype_id");
CREATE INDEX "phenstatement_idx_phenotype_id" on "phenstatement" ("phenotype_id");
CREATE INDEX "phenstatement_idx_pub_id" on "phenstatement" ("pub_id");
CREATE INDEX "phenstatement_idx_type_id" on "phenstatement" ("type_id");
CREATE INDEX "phylonode_idx_feature_id" on "phylonode" ("feature_id");
CREATE INDEX "phylonode_idx_phylotree_id" on "phylonode" ("phylotree_id");
CREATE INDEX "phylonode_idx_parent_phylonode" on "phylonode" ("parent_phylonode_id");
CREATE INDEX "phylonode_idx_type_id" on "phylonode" ("type_id");
CREATE INDEX "phylonode_dbxref_idx_dbxref_id" on "phylonode_dbxref" ("dbxref_id");
CREATE INDEX "phylonode_dbxref_idx_phylonode" on "phylonode_dbxref" ("phylonode_id");
CREATE INDEX "phylonode_organism_idx_organis" on "phylonode_organism" ("organism_id");
CREATE INDEX "phylonode_organism_idx_phylono" on "phylonode_organism" ("phylonode_id");
CREATE INDEX "phylonode_pub_idx_phylonode_id" on "phylonode_pub" ("phylonode_id");
CREATE INDEX "phylonode_pub_idx_pub_id" on "phylonode_pub" ("pub_id");
CREATE INDEX "phylonode_relationship_idx_obj" on "phylonode_relationship" ("object_id");
CREATE INDEX "phylonode_relationship_idx_phy" on "phylonode_relationship" ("phylotree_id");
CREATE INDEX "phylonode_relationship_idx_sub" on "phylonode_relationship" ("subject_id");
CREATE INDEX "phylonode_relationship_idx_typ" on "phylonode_relationship" ("type_id");
CREATE INDEX "phylonodeprop_idx_phylonode_id" on "phylonodeprop" ("phylonode_id");
CREATE INDEX "phylonodeprop_idx_type_id" on "phylonodeprop" ("type_id");
CREATE INDEX "phylotree_idx_analysis_id" on "phylotree" ("analysis_id");
CREATE INDEX "phylotree_idx_dbxref_id" on "phylotree" ("dbxref_id");
CREATE INDEX "phylotree_idx_type_id" on "phylotree" ("type_id");
CREATE INDEX "phylotree_pub_idx_phylotree_id" on "phylotree_pub" ("phylotree_id");
CREATE INDEX "phylotree_pub_idx_pub_id" on "phylotree_pub" ("pub_id");
CREATE INDEX "project_contact_idx_contact_id" on "project_contact" ("contact_id");
CREATE INDEX "project_contact_idx_project_id" on "project_contact" ("project_id");
CREATE INDEX "project_pub_idx_project_id" on "project_pub" ("project_id");
CREATE INDEX "project_pub_idx_pub_id" on "project_pub" ("pub_id");
CREATE INDEX "project_relationship_idx_objec" on "project_relationship" ("object_project_id");
CREATE INDEX "project_relationship_idx_subje" on "project_relationship" ("subject_project_id");
CREATE INDEX "project_relationship_idx_type_" on "project_relationship" ("type_id");
CREATE INDEX "projectprop_idx_project_id" on "projectprop" ("project_id");
CREATE INDEX "projectprop_idx_type_id" on "projectprop" ("type_id");
CREATE INDEX "protocol_idx_dbxref_id" on "protocol" ("dbxref_id");
CREATE INDEX "protocol_idx_pub_id" on "protocol" ("pub_id");
CREATE INDEX "protocol_idx_type_id" on "protocol" ("type_id");
CREATE INDEX "protocolparam_idx_datatype_id" on "protocolparam" ("datatype_id");
CREATE INDEX "protocolparam_idx_protocol_id" on "protocolparam" ("protocol_id");
CREATE INDEX "protocolparam_idx_unittype_id" on "protocolparam" ("unittype_id");
CREATE INDEX "pub_idx_type_id" on "pub" ("type_id");
CREATE INDEX "pub_dbxref_idx_dbxref_id" on "pub_dbxref" ("dbxref_id");
CREATE INDEX "pub_dbxref_idx_pub_id" on "pub_dbxref" ("pub_id");
CREATE INDEX "pub_relationship_idx_object_id" on "pub_relationship" ("object_id");
CREATE INDEX "pub_relationship_idx_subject_i" on "pub_relationship" ("subject_id");
CREATE INDEX "pub_relationship_idx_type_id" on "pub_relationship" ("type_id");
CREATE INDEX "pubauthor_idx_pub_id" on "pubauthor" ("pub_id");
CREATE INDEX "pubprop_idx_pub_id" on "pubprop" ("pub_id");
CREATE INDEX "pubprop_idx_type_id" on "pubprop" ("type_id");
CREATE INDEX "quantification_idx_acquisition" on "quantification" ("acquisition_id");
CREATE INDEX "quantification_idx_analysis_id" on "quantification" ("analysis_id");
CREATE INDEX "quantification_idx_operator_id" on "quantification" ("operator_id");
CREATE INDEX "quantification_idx_protocol_id" on "quantification" ("protocol_id");
CREATE INDEX "quantification_relationship_id" on "quantification_relationship" ("object_id");
CREATE INDEX "quantification_relationship_01" on "quantification_relationship" ("subject_id");
CREATE INDEX "quantification_relationship_02" on "quantification_relationship" ("type_id");
CREATE INDEX "quantificationprop_idx_quantif" on "quantificationprop" ("quantification_id");
CREATE INDEX "quantificationprop_idx_type_id" on "quantificationprop" ("type_id");
CREATE INDEX "stock_idx_dbxref_id" on "stock" ("dbxref_id");
CREATE INDEX "stock_idx_organism_id" on "stock" ("organism_id");
CREATE INDEX "stock_idx_type_id" on "stock" ("type_id");
CREATE INDEX "stock_cvterm_idx_cvterm_id" on "stock_cvterm" ("cvterm_id");
CREATE INDEX "stock_cvterm_idx_pub_id" on "stock_cvterm" ("pub_id");
CREATE INDEX "stock_cvterm_idx_stock_id" on "stock_cvterm" ("stock_id");
CREATE INDEX "stock_cvtermprop_idx_stock_cvt" on "stock_cvtermprop" ("stock_cvterm_id");
CREATE INDEX "stock_cvtermprop_idx_type_id" on "stock_cvtermprop" ("type_id");
CREATE INDEX "stock_dbxref_idx_dbxref_id" on "stock_dbxref" ("dbxref_id");
CREATE INDEX "stock_dbxref_idx_stock_id" on "stock_dbxref" ("stock_id");
CREATE INDEX "stock_dbxrefprop_idx_stock_dbx" on "stock_dbxrefprop" ("stock_dbxref_id");
CREATE INDEX "stock_dbxrefprop_idx_type_id" on "stock_dbxrefprop" ("type_id");
CREATE INDEX "stock_genotype_idx_genotype_id" on "stock_genotype" ("genotype_id");
CREATE INDEX "stock_genotype_idx_stock_id" on "stock_genotype" ("stock_id");
CREATE INDEX "stock_pub_idx_pub_id" on "stock_pub" ("pub_id");
CREATE INDEX "stock_pub_idx_stock_id" on "stock_pub" ("stock_id");
CREATE INDEX "stock_relationship_idx_object_" on "stock_relationship" ("object_id");
CREATE INDEX "stock_relationship_idx_subject" on "stock_relationship" ("subject_id");
CREATE INDEX "stock_relationship_idx_type_id" on "stock_relationship" ("type_id");
CREATE INDEX "stock_relationship_cvterm_idx_" on "stock_relationship_cvterm" ("cvterm_id");
CREATE INDEX "stock_relationship_cvterm_id01" on "stock_relationship_cvterm" ("pub_id");
CREATE INDEX "stock_relationship_cvterm_id02" on "stock_relationship_cvterm" ("stock_relationship_id");
CREATE INDEX "stock_relationship_pub_idx_pub" on "stock_relationship_pub" ("pub_id");
CREATE INDEX "stock_relationship_pub_idx_sto" on "stock_relationship_pub" ("stock_relationship_id");
CREATE INDEX "stockcollection_idx_contact_id" on "stockcollection" ("contact_id");
CREATE INDEX "stockcollection_idx_type_id" on "stockcollection" ("type_id");
CREATE INDEX "stockcollection_stock_idx_stoc" on "stockcollection_stock" ("stock_id");
CREATE INDEX "stockcollection_stock_idx_st01" on "stockcollection_stock" ("stockcollection_id");
CREATE INDEX "stockcollectionprop_idx_stockc" on "stockcollectionprop" ("stockcollection_id");
CREATE INDEX "stockcollectionprop_idx_type_i" on "stockcollectionprop" ("type_id");
CREATE INDEX "stockprop_idx_stock_id" on "stockprop" ("stock_id");
CREATE INDEX "stockprop_idx_type_id" on "stockprop" ("type_id");
CREATE INDEX "stockprop_pub_idx_pub_id" on "stockprop_pub" ("pub_id");
CREATE INDEX "stockprop_pub_idx_stockprop_id" on "stockprop_pub" ("stockprop_id");
CREATE INDEX "study_idx_contact_id" on "study" ("contact_id");
CREATE INDEX "study_idx_dbxref_id" on "study" ("dbxref_id");
CREATE INDEX "study_idx_pub_id" on "study" ("pub_id");
CREATE INDEX "study_assay_idx_assay_id" on "study_assay" ("assay_id");
CREATE INDEX "study_assay_idx_study_id" on "study_assay" ("study_id");
CREATE INDEX "studydesign_idx_study_id" on "studydesign" ("study_id");
CREATE INDEX "studydesignprop_idx_studydesig" on "studydesignprop" ("studydesign_id");
CREATE INDEX "studydesignprop_idx_type_id" on "studydesignprop" ("type_id");
CREATE INDEX "studyfactor_idx_studydesign_id" on "studyfactor" ("studydesign_id");
CREATE INDEX "studyfactor_idx_type_id" on "studyfactor" ("type_id");
CREATE INDEX "studyfactorvalue_idx_assay_id" on "studyfactorvalue" ("assay_id");
CREATE INDEX "studyfactorvalue_idx_studyfact" on "studyfactorvalue" ("studyfactor_id");
CREATE INDEX "studyprop_idx_study_id" on "studyprop" ("study_id");
CREATE INDEX "studyprop_idx_type_id" on "studyprop" ("type_id");
CREATE INDEX "studyprop_feature_idx_feature_" on "studyprop_feature" ("feature_id");
CREATE INDEX "studyprop_feature_idx_studypro" on "studyprop_feature" ("studyprop_id");
CREATE INDEX "studyprop_feature_idx_type_id" on "studyprop_feature" ("type_id");
CREATE INDEX "synonym__idx_type_id" on "synonym_" ("type_id");
CREATE INDEX "treatment_idx_biomaterial_id" on "treatment" ("biomaterial_id");
CREATE INDEX "treatment_idx_protocol_id" on "treatment" ("protocol_id");
CREATE INDEX "treatment_idx_type_id" on "treatment" ("type_id");
CREATE INDEX "featureprop_idx_type_id" on "featureprop" ("type_id");
CREATE INDEX "featureprop_idx_feature_id" on "featureprop" ("feature_id")