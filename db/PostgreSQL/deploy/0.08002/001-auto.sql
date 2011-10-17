-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Mon Oct 17 12:50:55 2011
-- 
;
--
-- Table: acquisition
--
CREATE TABLE "acquisition" (
  "acquisition_id" serial NOT NULL,
  "assay_id" integer NOT NULL,
  "protocol_id" integer,
  "channel_id" integer,
  "acquisitiondate" timestamp DEFAULT current_timestamp,
  "name" text,
  "uri" text,
  PRIMARY KEY ("acquisition_id"),
  CONSTRAINT "acquisition_c1" UNIQUE ("name")
);
CREATE INDEX "acquisition_idx_assay_id" on "acquisition" ("assay_id");
CREATE INDEX "acquisition_idx_channel_id" on "acquisition" ("channel_id");
CREATE INDEX "acquisition_idx_protocol_id" on "acquisition" ("protocol_id");

;
--
-- Table: acquisition_relationship
--
CREATE TABLE "acquisition_relationship" (
  "acquisition_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("acquisition_relationship_id"),
  CONSTRAINT "acquisition_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
CREATE INDEX "acquisition_relationship_idx_object_id" on "acquisition_relationship" ("object_id");
CREATE INDEX "acquisition_relationship_idx_subject_id" on "acquisition_relationship" ("subject_id");
CREATE INDEX "acquisition_relationship_idx_type_id" on "acquisition_relationship" ("type_id");

;
--
-- Table: acquisitionprop
--
CREATE TABLE "acquisitionprop" (
  "acquisitionprop_id" serial NOT NULL,
  "acquisition_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("acquisitionprop_id"),
  CONSTRAINT "acquisitionprop_c1" UNIQUE ("acquisition_id", "type_id", "rank")
);
CREATE INDEX "acquisitionprop_idx_acquisition_id" on "acquisitionprop" ("acquisition_id");
CREATE INDEX "acquisitionprop_idx_type_id" on "acquisitionprop" ("type_id");

;
--
-- Table: all_feature_names
--
CREATE TABLE "all_feature_names" (
  "feature_id" integer,
  "name" character varying(255),
  "organism_id" integer
);

;
--
-- Table: analysis
--
CREATE TABLE "analysis" (
  "analysis_id" serial NOT NULL,
  "name" character varying(255),
  "description" text,
  "program" character varying(255) NOT NULL,
  "programversion" character varying(255) NOT NULL,
  "algorithm" character varying(255),
  "sourcename" character varying(255),
  "sourceversion" character varying(255),
  "sourceuri" text,
  "timeexecuted" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("analysis_id"),
  CONSTRAINT "analysis_c1" UNIQUE ("program", "programversion", "sourcename")
);

;
--
-- Table: analysisfeature
--
CREATE TABLE "analysisfeature" (
  "analysisfeature_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "analysis_id" integer NOT NULL,
  "rawscore" double precision,
  "normscore" double precision,
  "significance" double precision,
  "identity" double precision,
  PRIMARY KEY ("analysisfeature_id"),
  CONSTRAINT "analysisfeature_c1" UNIQUE ("feature_id", "analysis_id")
);
CREATE INDEX "analysisfeature_idx_analysis_id" on "analysisfeature" ("analysis_id");
CREATE INDEX "analysisfeature_idx_feature_id" on "analysisfeature" ("feature_id");

;
--
-- Table: analysisfeatureprop
--
CREATE TABLE "analysisfeatureprop" (
  "analysisfeatureprop_id" serial NOT NULL,
  "analysisfeature_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer NOT NULL,
  PRIMARY KEY ("analysisfeatureprop_id"),
  CONSTRAINT "analysisfeature_id_type_id_rank" UNIQUE ("analysisfeature_id", "type_id", "rank")
);
CREATE INDEX "analysisfeatureprop_idx_analysisfeature_id" on "analysisfeatureprop" ("analysisfeature_id");
CREATE INDEX "analysisfeatureprop_idx_type_id" on "analysisfeatureprop" ("type_id");

;
--
-- Table: analysisprop
--
CREATE TABLE "analysisprop" (
  "analysisprop_id" serial NOT NULL,
  "analysis_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("analysisprop_id"),
  CONSTRAINT "analysisprop_c1" UNIQUE ("analysis_id", "type_id", "rank")
);
CREATE INDEX "analysisprop_idx_analysis_id" on "analysisprop" ("analysis_id");
CREATE INDEX "analysisprop_idx_type_id" on "analysisprop" ("type_id");

;
--
-- Table: arraydesign
--
CREATE TABLE "arraydesign" (
  "arraydesign_id" serial NOT NULL,
  "manufacturer_id" integer NOT NULL,
  "platformtype_id" integer NOT NULL,
  "substratetype_id" integer,
  "protocol_id" integer,
  "dbxref_id" integer,
  "name" text NOT NULL,
  "version" text,
  "description" text,
  "array_dimensions" text,
  "element_dimensions" text,
  "num_of_elements" integer,
  "num_array_columns" integer,
  "num_array_rows" integer,
  "num_grid_columns" integer,
  "num_grid_rows" integer,
  "num_sub_columns" integer,
  "num_sub_rows" integer,
  PRIMARY KEY ("arraydesign_id"),
  CONSTRAINT "arraydesign_c1" UNIQUE ("name")
);
CREATE INDEX "arraydesign_idx_dbxref_id" on "arraydesign" ("dbxref_id");
CREATE INDEX "arraydesign_idx_manufacturer_id" on "arraydesign" ("manufacturer_id");
CREATE INDEX "arraydesign_idx_platformtype_id" on "arraydesign" ("platformtype_id");
CREATE INDEX "arraydesign_idx_protocol_id" on "arraydesign" ("protocol_id");
CREATE INDEX "arraydesign_idx_substratetype_id" on "arraydesign" ("substratetype_id");

;
--
-- Table: arraydesignprop
--
CREATE TABLE "arraydesignprop" (
  "arraydesignprop_id" serial NOT NULL,
  "arraydesign_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("arraydesignprop_id"),
  CONSTRAINT "arraydesignprop_c1" UNIQUE ("arraydesign_id", "type_id", "rank")
);
CREATE INDEX "arraydesignprop_idx_arraydesign_id" on "arraydesignprop" ("arraydesign_id");
CREATE INDEX "arraydesignprop_idx_type_id" on "arraydesignprop" ("type_id");

;
--
-- Table: assay
--
CREATE TABLE "assay" (
  "assay_id" serial NOT NULL,
  "arraydesign_id" integer NOT NULL,
  "protocol_id" integer,
  "assaydate" timestamp DEFAULT current_timestamp,
  "arrayidentifier" text,
  "arraybatchidentifier" text,
  "operator_id" integer NOT NULL,
  "dbxref_id" integer,
  "name" text,
  "description" text,
  PRIMARY KEY ("assay_id"),
  CONSTRAINT "assay_c1" UNIQUE ("name")
);
CREATE INDEX "assay_idx_arraydesign_id" on "assay" ("arraydesign_id");
CREATE INDEX "assay_idx_dbxref_id" on "assay" ("dbxref_id");
CREATE INDEX "assay_idx_operator_id" on "assay" ("operator_id");
CREATE INDEX "assay_idx_protocol_id" on "assay" ("protocol_id");

;
--
-- Table: assay_biomaterial
--
CREATE TABLE "assay_biomaterial" (
  "assay_biomaterial_id" serial NOT NULL,
  "assay_id" integer NOT NULL,
  "biomaterial_id" integer NOT NULL,
  "channel_id" integer,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("assay_biomaterial_id"),
  CONSTRAINT "assay_biomaterial_c1" UNIQUE ("assay_id", "biomaterial_id", "channel_id", "rank")
);
CREATE INDEX "assay_biomaterial_idx_assay_id" on "assay_biomaterial" ("assay_id");
CREATE INDEX "assay_biomaterial_idx_biomaterial_id" on "assay_biomaterial" ("biomaterial_id");
CREATE INDEX "assay_biomaterial_idx_channel_id" on "assay_biomaterial" ("channel_id");

;
--
-- Table: assay_project
--
CREATE TABLE "assay_project" (
  "assay_project_id" serial NOT NULL,
  "assay_id" integer NOT NULL,
  "project_id" integer NOT NULL,
  PRIMARY KEY ("assay_project_id"),
  CONSTRAINT "assay_project_c1" UNIQUE ("assay_id", "project_id")
);
CREATE INDEX "assay_project_idx_assay_id" on "assay_project" ("assay_id");
CREATE INDEX "assay_project_idx_project_id" on "assay_project" ("project_id");

;
--
-- Table: assayprop
--
CREATE TABLE "assayprop" (
  "assayprop_id" serial NOT NULL,
  "assay_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("assayprop_id"),
  CONSTRAINT "assayprop_c1" UNIQUE ("assay_id", "type_id", "rank")
);
CREATE INDEX "assayprop_idx_assay_id" on "assayprop" ("assay_id");
CREATE INDEX "assayprop_idx_type_id" on "assayprop" ("type_id");

;
--
-- Table: biomaterial
--
CREATE TABLE "biomaterial" (
  "biomaterial_id" serial NOT NULL,
  "taxon_id" integer,
  "biosourceprovider_id" integer,
  "dbxref_id" integer,
  "name" text,
  "description" text,
  PRIMARY KEY ("biomaterial_id"),
  CONSTRAINT "biomaterial_c1" UNIQUE ("name")
);
CREATE INDEX "biomaterial_idx_biosourceprovider_id" on "biomaterial" ("biosourceprovider_id");
CREATE INDEX "biomaterial_idx_dbxref_id" on "biomaterial" ("dbxref_id");
CREATE INDEX "biomaterial_idx_taxon_id" on "biomaterial" ("taxon_id");

;
--
-- Table: biomaterial_dbxref
--
CREATE TABLE "biomaterial_dbxref" (
  "biomaterial_dbxref_id" serial NOT NULL,
  "biomaterial_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  PRIMARY KEY ("biomaterial_dbxref_id"),
  CONSTRAINT "biomaterial_dbxref_c1" UNIQUE ("biomaterial_id", "dbxref_id")
);
CREATE INDEX "biomaterial_dbxref_idx_biomaterial_id" on "biomaterial_dbxref" ("biomaterial_id");
CREATE INDEX "biomaterial_dbxref_idx_dbxref_id" on "biomaterial_dbxref" ("dbxref_id");

;
--
-- Table: biomaterial_relationship
--
CREATE TABLE "biomaterial_relationship" (
  "biomaterial_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  PRIMARY KEY ("biomaterial_relationship_id"),
  CONSTRAINT "biomaterial_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
CREATE INDEX "biomaterial_relationship_idx_object_id" on "biomaterial_relationship" ("object_id");
CREATE INDEX "biomaterial_relationship_idx_subject_id" on "biomaterial_relationship" ("subject_id");
CREATE INDEX "biomaterial_relationship_idx_type_id" on "biomaterial_relationship" ("type_id");

;
--
-- Table: biomaterial_treatment
--
CREATE TABLE "biomaterial_treatment" (
  "biomaterial_treatment_id" serial NOT NULL,
  "biomaterial_id" integer NOT NULL,
  "treatment_id" integer NOT NULL,
  "unittype_id" integer,
  "value" numeric,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("biomaterial_treatment_id"),
  CONSTRAINT "biomaterial_treatment_c1" UNIQUE ("biomaterial_id", "treatment_id")
);
CREATE INDEX "biomaterial_treatment_idx_biomaterial_id" on "biomaterial_treatment" ("biomaterial_id");
CREATE INDEX "biomaterial_treatment_idx_treatment_id" on "biomaterial_treatment" ("treatment_id");
CREATE INDEX "biomaterial_treatment_idx_unittype_id" on "biomaterial_treatment" ("unittype_id");

;
--
-- Table: biomaterialprop
--
CREATE TABLE "biomaterialprop" (
  "biomaterialprop_id" serial NOT NULL,
  "biomaterial_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("biomaterialprop_id"),
  CONSTRAINT "biomaterialprop_c1" UNIQUE ("biomaterial_id", "type_id", "rank")
);
CREATE INDEX "biomaterialprop_idx_biomaterial_id" on "biomaterialprop" ("biomaterial_id");
CREATE INDEX "biomaterialprop_idx_type_id" on "biomaterialprop" ("type_id");

;
--
-- Table: cell_line
--
CREATE TABLE "cell_line" (
  "cell_line_id" serial NOT NULL,
  "name" character varying(255),
  "uniquename" character varying(255) NOT NULL,
  "organism_id" integer NOT NULL,
  "timeaccessioned" timestamp DEFAULT current_timestamp NOT NULL,
  "timelastmodified" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("cell_line_id"),
  CONSTRAINT "cell_line_c1" UNIQUE ("uniquename", "organism_id")
);
CREATE INDEX "cell_line_idx_organism_id" on "cell_line" ("organism_id");

;
--
-- Table: cell_line_cvterm
--
CREATE TABLE "cell_line_cvterm" (
  "cell_line_cvterm_id" serial NOT NULL,
  "cell_line_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("cell_line_cvterm_id"),
  CONSTRAINT "cell_line_cvterm_c1" UNIQUE ("cell_line_id", "cvterm_id", "pub_id", "rank")
);
CREATE INDEX "cell_line_cvterm_idx_cell_line_id" on "cell_line_cvterm" ("cell_line_id");
CREATE INDEX "cell_line_cvterm_idx_cvterm_id" on "cell_line_cvterm" ("cvterm_id");
CREATE INDEX "cell_line_cvterm_idx_pub_id" on "cell_line_cvterm" ("pub_id");

;
--
-- Table: cell_line_cvtermprop
--
CREATE TABLE "cell_line_cvtermprop" (
  "cell_line_cvtermprop_id" serial NOT NULL,
  "cell_line_cvterm_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("cell_line_cvtermprop_id"),
  CONSTRAINT "cell_line_cvtermprop_c1" UNIQUE ("cell_line_cvterm_id", "type_id", "rank")
);
CREATE INDEX "cell_line_cvtermprop_idx_cell_line_cvterm_id" on "cell_line_cvtermprop" ("cell_line_cvterm_id");
CREATE INDEX "cell_line_cvtermprop_idx_type_id" on "cell_line_cvtermprop" ("type_id");

;
--
-- Table: cell_line_dbxref
--
CREATE TABLE "cell_line_dbxref" (
  "cell_line_dbxref_id" serial NOT NULL,
  "cell_line_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  "is_current" boolean DEFAULT true NOT NULL,
  PRIMARY KEY ("cell_line_dbxref_id"),
  CONSTRAINT "cell_line_dbxref_c1" UNIQUE ("cell_line_id", "dbxref_id")
);
CREATE INDEX "cell_line_dbxref_idx_cell_line_id" on "cell_line_dbxref" ("cell_line_id");
CREATE INDEX "cell_line_dbxref_idx_dbxref_id" on "cell_line_dbxref" ("dbxref_id");

;
--
-- Table: cell_line_feature
--
CREATE TABLE "cell_line_feature" (
  "cell_line_feature_id" serial NOT NULL,
  "cell_line_id" integer NOT NULL,
  "feature_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("cell_line_feature_id"),
  CONSTRAINT "cell_line_feature_c1" UNIQUE ("cell_line_id", "feature_id", "pub_id")
);
CREATE INDEX "cell_line_feature_idx_cell_line_id" on "cell_line_feature" ("cell_line_id");
CREATE INDEX "cell_line_feature_idx_feature_id" on "cell_line_feature" ("feature_id");
CREATE INDEX "cell_line_feature_idx_pub_id" on "cell_line_feature" ("pub_id");

;
--
-- Table: cell_line_library
--
CREATE TABLE "cell_line_library" (
  "cell_line_library_id" serial NOT NULL,
  "cell_line_id" integer NOT NULL,
  "library_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("cell_line_library_id"),
  CONSTRAINT "cell_line_library_c1" UNIQUE ("cell_line_id", "library_id", "pub_id")
);
CREATE INDEX "cell_line_library_idx_cell_line_id" on "cell_line_library" ("cell_line_id");
CREATE INDEX "cell_line_library_idx_library_id" on "cell_line_library" ("library_id");
CREATE INDEX "cell_line_library_idx_pub_id" on "cell_line_library" ("pub_id");

;
--
-- Table: cell_line_pub
--
CREATE TABLE "cell_line_pub" (
  "cell_line_pub_id" serial NOT NULL,
  "cell_line_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("cell_line_pub_id"),
  CONSTRAINT "cell_line_pub_c1" UNIQUE ("cell_line_id", "pub_id")
);
CREATE INDEX "cell_line_pub_idx_cell_line_id" on "cell_line_pub" ("cell_line_id");
CREATE INDEX "cell_line_pub_idx_pub_id" on "cell_line_pub" ("pub_id");

;
--
-- Table: cell_line_relationship
--
CREATE TABLE "cell_line_relationship" (
  "cell_line_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  PRIMARY KEY ("cell_line_relationship_id"),
  CONSTRAINT "cell_line_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
CREATE INDEX "cell_line_relationship_idx_object_id" on "cell_line_relationship" ("object_id");
CREATE INDEX "cell_line_relationship_idx_subject_id" on "cell_line_relationship" ("subject_id");
CREATE INDEX "cell_line_relationship_idx_type_id" on "cell_line_relationship" ("type_id");

;
--
-- Table: cell_line_synonym
--
CREATE TABLE "cell_line_synonym" (
  "cell_line_synonym_id" serial NOT NULL,
  "cell_line_id" integer NOT NULL,
  "synonym_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  "is_current" boolean DEFAULT false NOT NULL,
  "is_internal" boolean DEFAULT false NOT NULL,
  PRIMARY KEY ("cell_line_synonym_id"),
  CONSTRAINT "cell_line_synonym_c1" UNIQUE ("synonym_id", "cell_line_id", "pub_id")
);
CREATE INDEX "cell_line_synonym_idx_cell_line_id" on "cell_line_synonym" ("cell_line_id");
CREATE INDEX "cell_line_synonym_idx_pub_id" on "cell_line_synonym" ("pub_id");
CREATE INDEX "cell_line_synonym_idx_synonym_id" on "cell_line_synonym" ("synonym_id");

;
--
-- Table: cell_lineprop
--
CREATE TABLE "cell_lineprop" (
  "cell_lineprop_id" serial NOT NULL,
  "cell_line_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("cell_lineprop_id"),
  CONSTRAINT "cell_lineprop_c1" UNIQUE ("cell_line_id", "type_id", "rank")
);
CREATE INDEX "cell_lineprop_idx_cell_line_id" on "cell_lineprop" ("cell_line_id");
CREATE INDEX "cell_lineprop_idx_type_id" on "cell_lineprop" ("type_id");

;
--
-- Table: cell_lineprop_pub
--
CREATE TABLE "cell_lineprop_pub" (
  "cell_lineprop_pub_id" serial NOT NULL,
  "cell_lineprop_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("cell_lineprop_pub_id"),
  CONSTRAINT "cell_lineprop_pub_c1" UNIQUE ("cell_lineprop_id", "pub_id")
);
CREATE INDEX "cell_lineprop_pub_idx_cell_lineprop_id" on "cell_lineprop_pub" ("cell_lineprop_id");
CREATE INDEX "cell_lineprop_pub_idx_pub_id" on "cell_lineprop_pub" ("pub_id");

;
--
-- Table: channel
--
CREATE TABLE "channel" (
  "channel_id" serial NOT NULL,
  "name" text NOT NULL,
  "definition" text NOT NULL,
  PRIMARY KEY ("channel_id"),
  CONSTRAINT "channel_c1" UNIQUE ("name")
);

;
--
-- Table: common_ancestor_cvterm
--
CREATE TABLE "common_ancestor_cvterm" (
  "cvterm1_id" integer,
  "cvterm2_id" integer,
  "ancestor_cvterm_id" integer,
  "pathdistance1" integer,
  "pathdistance2" integer,
  "total_pathdistance" integer
);

;
--
-- Table: common_descendant_cvterm
--
CREATE TABLE "common_descendant_cvterm" (
  "cvterm1_id" integer,
  "cvterm2_id" integer,
  "ancestor_cvterm_id" integer,
  "pathdistance1" integer,
  "pathdistance2" integer,
  "total_pathdistance" integer
);

;
--
-- Table: contact
--
CREATE TABLE "contact" (
  "contact_id" serial NOT NULL,
  "type_id" integer,
  "name" character varying(255) NOT NULL,
  "description" character varying(255),
  PRIMARY KEY ("contact_id"),
  CONSTRAINT "contact_c1" UNIQUE ("name")
);
CREATE INDEX "contact_idx_type_id" on "contact" ("type_id");

;
--
-- Table: contact_relationship
--
CREATE TABLE "contact_relationship" (
  "contact_relationship_id" serial NOT NULL,
  "type_id" integer NOT NULL,
  "subject_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  PRIMARY KEY ("contact_relationship_id"),
  CONSTRAINT "contact_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
CREATE INDEX "contact_relationship_idx_object_id" on "contact_relationship" ("object_id");
CREATE INDEX "contact_relationship_idx_subject_id" on "contact_relationship" ("subject_id");
CREATE INDEX "contact_relationship_idx_type_id" on "contact_relationship" ("type_id");

;
--
-- Table: control
--
CREATE TABLE "control" (
  "control_id" serial NOT NULL,
  "type_id" integer NOT NULL,
  "assay_id" integer NOT NULL,
  "tableinfo_id" integer NOT NULL,
  "row_id" integer NOT NULL,
  "name" text,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("control_id")
);
CREATE INDEX "control_idx_assay_id" on "control" ("assay_id");
CREATE INDEX "control_idx_tableinfo_id" on "control" ("tableinfo_id");
CREATE INDEX "control_idx_type_id" on "control" ("type_id");

;
--
-- Table: cv
--
CREATE TABLE "cv" (
  "cv_id" serial NOT NULL,
  "name" character varying(255) NOT NULL,
  "definition" text,
  PRIMARY KEY ("cv_id"),
  CONSTRAINT "cv_c1" UNIQUE ("name")
);

;
--
-- Table: cv_cvterm_count
--
CREATE TABLE "cv_cvterm_count" (
  "name" character varying(255),
  "num_terms_excl_obs" bigint
);

;
--
-- Table: cv_cvterm_count_with_obs
--
CREATE TABLE "cv_cvterm_count_with_obs" (
  "name" character varying(255),
  "num_terms_incl_obs" bigint
);

;
--
-- Table: cv_leaf
--
CREATE TABLE "cv_leaf" (
  "cv_id" integer,
  "cvterm_id" integer
);

;
--
-- Table: cv_link_count
--
CREATE TABLE "cv_link_count" (
  "cv_name" character varying(255),
  "relation_name" character varying(1024),
  "relation_cv_name" character varying(255),
  "num_links" bigint
);

;
--
-- Table: cv_path_count
--
CREATE TABLE "cv_path_count" (
  "cv_name" character varying(255),
  "relation_name" character varying(1024),
  "relation_cv_name" character varying(255),
  "num_paths" bigint
);

;
--
-- Table: cv_root
--
CREATE TABLE "cv_root" (
  "cv_id" integer,
  "root_cvterm_id" integer
);

;
--
-- Table: cvprop
--
CREATE TABLE "cvprop" (
  "cvprop_id" serial NOT NULL,
  "cv_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("cvprop_id"),
  CONSTRAINT "cvprop_c1" UNIQUE ("cv_id", "type_id", "rank")
);
CREATE INDEX "cvprop_idx_cv_id" on "cvprop" ("cv_id");
CREATE INDEX "cvprop_idx_type_id" on "cvprop" ("type_id");

;
--
-- Table: cvterm
--
CREATE TABLE "cvterm" (
  "cvterm_id" serial NOT NULL,
  "cv_id" integer NOT NULL,
  "name" character varying(1024) NOT NULL,
  "definition" text,
  "dbxref_id" integer NOT NULL,
  "is_obsolete" integer DEFAULT 0 NOT NULL,
  "is_relationshiptype" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("cvterm_id"),
  CONSTRAINT "cvterm_c1" UNIQUE ("name", "cv_id", "is_obsolete"),
  CONSTRAINT "cvterm_c2" UNIQUE ("dbxref_id")
);
CREATE INDEX "cvterm_idx_cv_id" on "cvterm" ("cv_id");
CREATE INDEX "cvterm_idx_dbxref_id" on "cvterm" ("dbxref_id");

;
--
-- Table: cvterm_dbxref
--
CREATE TABLE "cvterm_dbxref" (
  "cvterm_dbxref_id" serial NOT NULL,
  "cvterm_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  "is_for_definition" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("cvterm_dbxref_id"),
  CONSTRAINT "cvterm_dbxref_c1" UNIQUE ("cvterm_id", "dbxref_id")
);
CREATE INDEX "cvterm_dbxref_idx_cvterm_id" on "cvterm_dbxref" ("cvterm_id");
CREATE INDEX "cvterm_dbxref_idx_dbxref_id" on "cvterm_dbxref" ("dbxref_id");

;
--
-- Table: cvterm_relationship
--
CREATE TABLE "cvterm_relationship" (
  "cvterm_relationship_id" serial NOT NULL,
  "type_id" integer NOT NULL,
  "subject_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  PRIMARY KEY ("cvterm_relationship_id"),
  CONSTRAINT "cvterm_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
CREATE INDEX "cvterm_relationship_idx_object_id" on "cvterm_relationship" ("object_id");
CREATE INDEX "cvterm_relationship_idx_subject_id" on "cvterm_relationship" ("subject_id");
CREATE INDEX "cvterm_relationship_idx_type_id" on "cvterm_relationship" ("type_id");

;
--
-- Table: cvtermpath
--
CREATE TABLE "cvtermpath" (
  "cvtermpath_id" serial NOT NULL,
  "type_id" integer,
  "subject_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "cv_id" integer NOT NULL,
  "pathdistance" integer,
  PRIMARY KEY ("cvtermpath_id"),
  CONSTRAINT "cvtermpath_c1" UNIQUE ("subject_id", "object_id", "type_id", "pathdistance")
);
CREATE INDEX "cvtermpath_idx_cv_id" on "cvtermpath" ("cv_id");
CREATE INDEX "cvtermpath_idx_object_id" on "cvtermpath" ("object_id");
CREATE INDEX "cvtermpath_idx_subject_id" on "cvtermpath" ("subject_id");
CREATE INDEX "cvtermpath_idx_type_id" on "cvtermpath" ("type_id");

;
--
-- Table: cvtermprop
--
CREATE TABLE "cvtermprop" (
  "cvtermprop_id" serial NOT NULL,
  "cvterm_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text DEFAULT '' NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("cvtermprop_id"),
  CONSTRAINT "cvtermprop_cvterm_id_key" UNIQUE ("cvterm_id", "type_id", "value", "rank")
);
CREATE INDEX "cvtermprop_idx_cvterm_id" on "cvtermprop" ("cvterm_id");
CREATE INDEX "cvtermprop_idx_type_id" on "cvtermprop" ("type_id");

;
--
-- Table: cvtermsynonym
--
CREATE TABLE "cvtermsynonym" (
  "cvtermsynonym_id" serial NOT NULL,
  "cvterm_id" integer NOT NULL,
  "synonym" character varying(1024) NOT NULL,
  "type_id" integer,
  PRIMARY KEY ("cvtermsynonym_id"),
  CONSTRAINT "cvtermsynonym_c1" UNIQUE ("cvterm_id", "synonym")
);
CREATE INDEX "cvtermsynonym_idx_cvterm_id" on "cvtermsynonym" ("cvterm_id");
CREATE INDEX "cvtermsynonym_idx_type_id" on "cvtermsynonym" ("type_id");

;
--
-- Table: db
--
CREATE TABLE "db" (
  "db_id" serial NOT NULL,
  "name" character varying(255) NOT NULL,
  "description" character varying(255),
  "urlprefix" character varying(255),
  "url" character varying(255),
  PRIMARY KEY ("db_id"),
  CONSTRAINT "db_c1" UNIQUE ("name")
);

;
--
-- Table: db_dbxref_count
--
CREATE TABLE "db_dbxref_count" (
  "name" character varying(255),
  "num_dbxrefs" bigint
);

;
--
-- Table: dbxref
--
CREATE TABLE "dbxref" (
  "dbxref_id" serial NOT NULL,
  "db_id" integer NOT NULL,
  "accession" character varying(255) NOT NULL,
  "version" character varying(255) DEFAULT '' NOT NULL,
  "description" text,
  PRIMARY KEY ("dbxref_id"),
  CONSTRAINT "dbxref_c1" UNIQUE ("db_id", "accession", "version")
);
CREATE INDEX "dbxref_idx_db_id" on "dbxref" ("db_id");

;
--
-- Table: dbxrefprop
--
CREATE TABLE "dbxrefprop" (
  "dbxrefprop_id" serial NOT NULL,
  "dbxref_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text DEFAULT '' NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("dbxrefprop_id"),
  CONSTRAINT "dbxrefprop_c1" UNIQUE ("dbxref_id", "type_id", "rank")
);
CREATE INDEX "dbxrefprop_idx_dbxref_id" on "dbxrefprop" ("dbxref_id");
CREATE INDEX "dbxrefprop_idx_type_id" on "dbxrefprop" ("type_id");

;
--
-- Table: dfeatureloc
--
CREATE TABLE "dfeatureloc" (
  "featureloc_id" integer,
  "feature_id" integer,
  "srcfeature_id" integer,
  "nbeg" integer,
  "is_nbeg_partial" boolean,
  "nend" integer,
  "is_nend_partial" boolean,
  "strand" smallint,
  "phase" integer,
  "residue_info" text,
  "locgroup" integer,
  "rank" integer
);

;
--
-- Table: eimage
--
CREATE TABLE "eimage" (
  "eimage_id" serial NOT NULL,
  "eimage_data" text,
  "eimage_type" character varying(255) NOT NULL,
  "image_uri" character varying(255),
  PRIMARY KEY ("eimage_id")
);

;
--
-- Table: element
--
CREATE TABLE "element" (
  "element_id" serial NOT NULL,
  "feature_id" integer,
  "arraydesign_id" integer NOT NULL,
  "type_id" integer,
  "dbxref_id" integer,
  PRIMARY KEY ("element_id"),
  CONSTRAINT "element_c1" UNIQUE ("feature_id", "arraydesign_id")
);
CREATE INDEX "element_idx_arraydesign_id" on "element" ("arraydesign_id");
CREATE INDEX "element_idx_dbxref_id" on "element" ("dbxref_id");
CREATE INDEX "element_idx_feature_id" on "element" ("feature_id");
CREATE INDEX "element_idx_type_id" on "element" ("type_id");

;
--
-- Table: element_relationship
--
CREATE TABLE "element_relationship" (
  "element_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("element_relationship_id"),
  CONSTRAINT "element_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
CREATE INDEX "element_relationship_idx_object_id" on "element_relationship" ("object_id");
CREATE INDEX "element_relationship_idx_subject_id" on "element_relationship" ("subject_id");
CREATE INDEX "element_relationship_idx_type_id" on "element_relationship" ("type_id");

;
--
-- Table: elementresult
--
CREATE TABLE "elementresult" (
  "elementresult_id" serial NOT NULL,
  "element_id" integer NOT NULL,
  "quantification_id" integer NOT NULL,
  "signal" double precision NOT NULL,
  PRIMARY KEY ("elementresult_id"),
  CONSTRAINT "elementresult_c1" UNIQUE ("element_id", "quantification_id")
);
CREATE INDEX "elementresult_idx_element_id" on "elementresult" ("element_id");
CREATE INDEX "elementresult_idx_quantification_id" on "elementresult" ("quantification_id");

;
--
-- Table: elementresult_relationship
--
CREATE TABLE "elementresult_relationship" (
  "elementresult_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("elementresult_relationship_id"),
  CONSTRAINT "elementresult_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
CREATE INDEX "elementresult_relationship_idx_object_id" on "elementresult_relationship" ("object_id");
CREATE INDEX "elementresult_relationship_idx_subject_id" on "elementresult_relationship" ("subject_id");
CREATE INDEX "elementresult_relationship_idx_type_id" on "elementresult_relationship" ("type_id");

;
--
-- Table: environment
--
CREATE TABLE "environment" (
  "environment_id" serial NOT NULL,
  "uniquename" text NOT NULL,
  "description" text,
  PRIMARY KEY ("environment_id"),
  CONSTRAINT "environment_c1" UNIQUE ("uniquename")
);

;
--
-- Table: environment_cvterm
--
CREATE TABLE "environment_cvterm" (
  "environment_cvterm_id" serial NOT NULL,
  "environment_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  PRIMARY KEY ("environment_cvterm_id"),
  CONSTRAINT "environment_cvterm_c1" UNIQUE ("environment_id", "cvterm_id")
);
CREATE INDEX "environment_cvterm_idx_cvterm_id" on "environment_cvterm" ("cvterm_id");
CREATE INDEX "environment_cvterm_idx_environment_id" on "environment_cvterm" ("environment_id");

;
--
-- Table: expression
--
CREATE TABLE "expression" (
  "expression_id" serial NOT NULL,
  "uniquename" text NOT NULL,
  "md5checksum" character(32),
  "description" text,
  PRIMARY KEY ("expression_id"),
  CONSTRAINT "expression_c1" UNIQUE ("uniquename")
);

;
--
-- Table: expression_cvterm
--
CREATE TABLE "expression_cvterm" (
  "expression_cvterm_id" serial NOT NULL,
  "expression_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  "cvterm_type_id" integer NOT NULL,
  PRIMARY KEY ("expression_cvterm_id"),
  CONSTRAINT "expression_cvterm_c1" UNIQUE ("expression_id", "cvterm_id", "cvterm_type_id")
);
CREATE INDEX "expression_cvterm_idx_cvterm_id" on "expression_cvterm" ("cvterm_id");
CREATE INDEX "expression_cvterm_idx_cvterm_type_id" on "expression_cvterm" ("cvterm_type_id");
CREATE INDEX "expression_cvterm_idx_expression_id" on "expression_cvterm" ("expression_id");

;
--
-- Table: expression_cvtermprop
--
CREATE TABLE "expression_cvtermprop" (
  "expression_cvtermprop_id" serial NOT NULL,
  "expression_cvterm_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("expression_cvtermprop_id"),
  CONSTRAINT "expression_cvtermprop_c1" UNIQUE ("expression_cvterm_id", "type_id", "rank")
);
CREATE INDEX "expression_cvtermprop_idx_expression_cvterm_id" on "expression_cvtermprop" ("expression_cvterm_id");
CREATE INDEX "expression_cvtermprop_idx_type_id" on "expression_cvtermprop" ("type_id");

;
--
-- Table: expression_image
--
CREATE TABLE "expression_image" (
  "expression_image_id" serial NOT NULL,
  "expression_id" integer NOT NULL,
  "eimage_id" integer NOT NULL,
  PRIMARY KEY ("expression_image_id"),
  CONSTRAINT "expression_image_c1" UNIQUE ("expression_id", "eimage_id")
);
CREATE INDEX "expression_image_idx_eimage_id" on "expression_image" ("eimage_id");
CREATE INDEX "expression_image_idx_expression_id" on "expression_image" ("expression_id");

;
--
-- Table: expression_pub
--
CREATE TABLE "expression_pub" (
  "expression_pub_id" serial NOT NULL,
  "expression_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("expression_pub_id"),
  CONSTRAINT "expression_pub_c1" UNIQUE ("expression_id", "pub_id")
);
CREATE INDEX "expression_pub_idx_expression_id" on "expression_pub" ("expression_id");
CREATE INDEX "expression_pub_idx_pub_id" on "expression_pub" ("pub_id");

;
--
-- Table: expressionprop
--
CREATE TABLE "expressionprop" (
  "expressionprop_id" serial NOT NULL,
  "expression_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("expressionprop_id"),
  CONSTRAINT "expressionprop_c1" UNIQUE ("expression_id", "type_id", "rank")
);
CREATE INDEX "expressionprop_idx_expression_id" on "expressionprop" ("expression_id");
CREATE INDEX "expressionprop_idx_type_id" on "expressionprop" ("type_id");

;
--
-- Table: f_loc
--
CREATE TABLE "f_loc" (
  "feature_id" integer,
  "name" character varying(255),
  "dbxref_id" integer,
  "nbeg" integer,
  "nend" integer,
  "strand" smallint
);

;
--
-- Table: f_type
--
CREATE TABLE "f_type" (
  "feature_id" integer,
  "name" character varying(255),
  "dbxref_id" integer,
  "type" character varying(1024),
  "residues" text,
  "seqlen" integer,
  "md5checksum" character(32),
  "type_id" integer,
  "timeaccessioned" timestamp,
  "timelastmodified" timestamp
);

;
--
-- Table: feature
--
CREATE TABLE "feature" (
  "feature_id" serial NOT NULL,
  "dbxref_id" integer,
  "organism_id" integer NOT NULL,
  "name" character varying(255),
  "uniquename" text NOT NULL,
  "residues" text,
  "seqlen" integer,
  "md5checksum" character(32),
  "type_id" integer NOT NULL,
  "is_analysis" boolean DEFAULT false NOT NULL,
  "is_obsolete" boolean DEFAULT false NOT NULL,
  "timeaccessioned" timestamp DEFAULT current_timestamp NOT NULL,
  "timelastmodified" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("feature_id"),
  CONSTRAINT "feature_c1" UNIQUE ("organism_id", "uniquename", "type_id")
);
CREATE INDEX "feature_idx_dbxref_id" on "feature" ("dbxref_id");
CREATE INDEX "feature_idx_organism_id" on "feature" ("organism_id");
CREATE INDEX "feature_idx_type_id" on "feature" ("type_id");

;
--
-- Table: feature_contains
--
CREATE TABLE "feature_contains" (
  "subject_id" integer,
  "object_id" integer
);

;
--
-- Table: feature_cvterm
--
CREATE TABLE "feature_cvterm" (
  "feature_cvterm_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  "is_not" boolean DEFAULT false NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("feature_cvterm_id"),
  CONSTRAINT "feature_cvterm_c1" UNIQUE ("feature_id", "cvterm_id", "pub_id", "rank")
);
CREATE INDEX "feature_cvterm_idx_cvterm_id" on "feature_cvterm" ("cvterm_id");
CREATE INDEX "feature_cvterm_idx_feature_id" on "feature_cvterm" ("feature_id");
CREATE INDEX "feature_cvterm_idx_pub_id" on "feature_cvterm" ("pub_id");

;
--
-- Table: feature_cvterm_dbxref
--
CREATE TABLE "feature_cvterm_dbxref" (
  "feature_cvterm_dbxref_id" serial NOT NULL,
  "feature_cvterm_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  PRIMARY KEY ("feature_cvterm_dbxref_id"),
  CONSTRAINT "feature_cvterm_dbxref_c1" UNIQUE ("feature_cvterm_id", "dbxref_id")
);
CREATE INDEX "feature_cvterm_dbxref_idx_dbxref_id" on "feature_cvterm_dbxref" ("dbxref_id");
CREATE INDEX "feature_cvterm_dbxref_idx_feature_cvterm_id" on "feature_cvterm_dbxref" ("feature_cvterm_id");

;
--
-- Table: feature_cvterm_pub
--
CREATE TABLE "feature_cvterm_pub" (
  "feature_cvterm_pub_id" serial NOT NULL,
  "feature_cvterm_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("feature_cvterm_pub_id"),
  CONSTRAINT "feature_cvterm_pub_c1" UNIQUE ("feature_cvterm_id", "pub_id")
);
CREATE INDEX "feature_cvterm_pub_idx_feature_cvterm_id" on "feature_cvterm_pub" ("feature_cvterm_id");
CREATE INDEX "feature_cvterm_pub_idx_pub_id" on "feature_cvterm_pub" ("pub_id");

;
--
-- Table: feature_cvtermprop
--
CREATE TABLE "feature_cvtermprop" (
  "feature_cvtermprop_id" serial NOT NULL,
  "feature_cvterm_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("feature_cvtermprop_id"),
  CONSTRAINT "feature_cvtermprop_c1" UNIQUE ("feature_cvterm_id", "type_id", "rank")
);
CREATE INDEX "feature_cvtermprop_idx_feature_cvterm_id" on "feature_cvtermprop" ("feature_cvterm_id");
CREATE INDEX "feature_cvtermprop_idx_type_id" on "feature_cvtermprop" ("type_id");

;
--
-- Table: feature_dbxref
--
CREATE TABLE "feature_dbxref" (
  "feature_dbxref_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  "is_current" boolean DEFAULT true NOT NULL,
  PRIMARY KEY ("feature_dbxref_id"),
  CONSTRAINT "feature_dbxref_c1" UNIQUE ("feature_id", "dbxref_id")
);
CREATE INDEX "feature_dbxref_idx_dbxref_id" on "feature_dbxref" ("dbxref_id");
CREATE INDEX "feature_dbxref_idx_feature_id" on "feature_dbxref" ("feature_id");

;
--
-- Table: feature_difference
--
CREATE TABLE "feature_difference" (
  "subject_id" integer,
  "object_id" integer,
  "srcfeature_id" smallint,
  "fmin" integer,
  "fmax" integer,
  "strand" integer
);

;
--
-- Table: feature_disjoint
--
CREATE TABLE "feature_disjoint" (
  "subject_id" integer,
  "object_id" integer
);

;
--
-- Table: feature_distance
--
CREATE TABLE "feature_distance" (
  "subject_id" integer,
  "object_id" integer,
  "srcfeature_id" integer,
  "subject_strand" smallint,
  "object_strand" smallint,
  "distance" integer
);

;
--
-- Table: feature_expression
--
CREATE TABLE "feature_expression" (
  "feature_expression_id" serial NOT NULL,
  "expression_id" integer NOT NULL,
  "feature_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("feature_expression_id"),
  CONSTRAINT "feature_expression_c1" UNIQUE ("expression_id", "feature_id", "pub_id")
);
CREATE INDEX "feature_expression_idx_expression_id" on "feature_expression" ("expression_id");
CREATE INDEX "feature_expression_idx_feature_id" on "feature_expression" ("feature_id");
CREATE INDEX "feature_expression_idx_pub_id" on "feature_expression" ("pub_id");

;
--
-- Table: feature_expressionprop
--
CREATE TABLE "feature_expressionprop" (
  "feature_expressionprop_id" serial NOT NULL,
  "feature_expression_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("feature_expressionprop_id"),
  CONSTRAINT "feature_expressionprop_c1" UNIQUE ("feature_expression_id", "type_id", "rank")
);
CREATE INDEX "feature_expressionprop_idx_feature_expression_id" on "feature_expressionprop" ("feature_expression_id");
CREATE INDEX "feature_expressionprop_idx_type_id" on "feature_expressionprop" ("type_id");

;
--
-- Table: feature_genotype
--
CREATE TABLE "feature_genotype" (
  "feature_genotype_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "genotype_id" integer NOT NULL,
  "chromosome_id" integer,
  "rank" integer NOT NULL,
  "cgroup" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  PRIMARY KEY ("feature_genotype_id"),
  CONSTRAINT "feature_genotype_c1" UNIQUE ("feature_id", "genotype_id", "cvterm_id", "chromosome_id", "rank", "cgroup")
);
CREATE INDEX "feature_genotype_idx_chromosome_id" on "feature_genotype" ("chromosome_id");
CREATE INDEX "feature_genotype_idx_cvterm_id" on "feature_genotype" ("cvterm_id");
CREATE INDEX "feature_genotype_idx_feature_id" on "feature_genotype" ("feature_id");
CREATE INDEX "feature_genotype_idx_genotype_id" on "feature_genotype" ("genotype_id");

;
--
-- Table: feature_intersection
--
CREATE TABLE "feature_intersection" (
  "subject_id" integer,
  "object_id" integer,
  "srcfeature_id" integer,
  "subject_strand" smallint,
  "object_strand" smallint,
  "fmin" integer,
  "fmax" integer
);

;
--
-- Table: feature_meets
--
CREATE TABLE "feature_meets" (
  "subject_id" integer,
  "object_id" integer
);

;
--
-- Table: feature_meets_on_same_strand
--
CREATE TABLE "feature_meets_on_same_strand" (
  "subject_id" integer,
  "object_id" integer
);

;
--
-- Table: feature_phenotype
--
CREATE TABLE "feature_phenotype" (
  "feature_phenotype_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "phenotype_id" integer NOT NULL,
  PRIMARY KEY ("feature_phenotype_id"),
  CONSTRAINT "feature_phenotype_c1" UNIQUE ("feature_id", "phenotype_id")
);
CREATE INDEX "feature_phenotype_idx_feature_id" on "feature_phenotype" ("feature_id");
CREATE INDEX "feature_phenotype_idx_phenotype_id" on "feature_phenotype" ("phenotype_id");

;
--
-- Table: feature_pub
--
CREATE TABLE "feature_pub" (
  "feature_pub_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("feature_pub_id"),
  CONSTRAINT "feature_pub_c1" UNIQUE ("feature_id", "pub_id")
);
CREATE INDEX "feature_pub_idx_feature_id" on "feature_pub" ("feature_id");
CREATE INDEX "feature_pub_idx_pub_id" on "feature_pub" ("pub_id");

;
--
-- Table: feature_pubprop
--
CREATE TABLE "feature_pubprop" (
  "feature_pubprop_id" serial NOT NULL,
  "feature_pub_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("feature_pubprop_id"),
  CONSTRAINT "feature_pubprop_c1" UNIQUE ("feature_pub_id", "type_id", "rank")
);
CREATE INDEX "feature_pubprop_idx_feature_pub_id" on "feature_pubprop" ("feature_pub_id");
CREATE INDEX "feature_pubprop_idx_type_id" on "feature_pubprop" ("type_id");

;
--
-- Table: feature_relationship
--
CREATE TABLE "feature_relationship" (
  "feature_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("feature_relationship_id"),
  CONSTRAINT "feature_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
CREATE INDEX "feature_relationship_idx_object_id" on "feature_relationship" ("object_id");
CREATE INDEX "feature_relationship_idx_subject_id" on "feature_relationship" ("subject_id");
CREATE INDEX "feature_relationship_idx_type_id" on "feature_relationship" ("type_id");

;
--
-- Table: feature_relationship_pub
--
CREATE TABLE "feature_relationship_pub" (
  "feature_relationship_pub_id" serial NOT NULL,
  "feature_relationship_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("feature_relationship_pub_id"),
  CONSTRAINT "feature_relationship_pub_c1" UNIQUE ("feature_relationship_id", "pub_id")
);
CREATE INDEX "feature_relationship_pub_idx_feature_relationship_id" on "feature_relationship_pub" ("feature_relationship_id");
CREATE INDEX "feature_relationship_pub_idx_pub_id" on "feature_relationship_pub" ("pub_id");

;
--
-- Table: feature_relationshipprop
--
CREATE TABLE "feature_relationshipprop" (
  "feature_relationshipprop_id" serial NOT NULL,
  "feature_relationship_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("feature_relationshipprop_id"),
  CONSTRAINT "feature_relationshipprop_c1" UNIQUE ("feature_relationship_id", "type_id", "rank")
);
CREATE INDEX "feature_relationshipprop_idx_feature_relationship_id" on "feature_relationshipprop" ("feature_relationship_id");
CREATE INDEX "feature_relationshipprop_idx_type_id" on "feature_relationshipprop" ("type_id");

;
--
-- Table: feature_relationshipprop_pub
--
CREATE TABLE "feature_relationshipprop_pub" (
  "feature_relationshipprop_pub_id" serial NOT NULL,
  "feature_relationshipprop_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("feature_relationshipprop_pub_id"),
  CONSTRAINT "feature_relationshipprop_pub_c1" UNIQUE ("feature_relationshipprop_id", "pub_id")
);
CREATE INDEX "feature_relationshipprop_pub_idx_feature_relationshipprop_id" on "feature_relationshipprop_pub" ("feature_relationshipprop_id");
CREATE INDEX "feature_relationshipprop_pub_idx_pub_id" on "feature_relationshipprop_pub" ("pub_id");

;
--
-- Table: feature_synonym
--
CREATE TABLE "feature_synonym" (
  "feature_synonym_id" serial NOT NULL,
  "synonym_id" integer NOT NULL,
  "feature_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  "is_current" boolean DEFAULT false NOT NULL,
  "is_internal" boolean DEFAULT false NOT NULL,
  PRIMARY KEY ("feature_synonym_id"),
  CONSTRAINT "feature_synonym_c1" UNIQUE ("synonym_id", "feature_id", "pub_id")
);
CREATE INDEX "feature_synonym_idx_feature_id" on "feature_synonym" ("feature_id");
CREATE INDEX "feature_synonym_idx_pub_id" on "feature_synonym" ("pub_id");
CREATE INDEX "feature_synonym_idx_synonym_id" on "feature_synonym" ("synonym_id");

;
--
-- Table: feature_union
--
CREATE TABLE "feature_union" (
  "subject_id" integer,
  "object_id" integer,
  "srcfeature_id" integer,
  "subject_strand" smallint,
  "object_strand" smallint,
  "fmin" integer,
  "fmax" integer
);

;
--
-- Table: featureloc
--
CREATE TABLE "featureloc" (
  "featureloc_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "srcfeature_id" integer,
  "fmin" integer,
  "is_fmin_partial" boolean DEFAULT false NOT NULL,
  "fmax" integer,
  "is_fmax_partial" boolean DEFAULT false NOT NULL,
  "strand" smallint,
  "phase" integer,
  "residue_info" text,
  "locgroup" integer DEFAULT 0 NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("featureloc_id"),
  CONSTRAINT "featureloc_c1" UNIQUE ("feature_id", "locgroup", "rank")
);
CREATE INDEX "featureloc_idx_feature_id" on "featureloc" ("feature_id");
CREATE INDEX "featureloc_idx_srcfeature_id" on "featureloc" ("srcfeature_id");

;
--
-- Table: featureloc_pub
--
CREATE TABLE "featureloc_pub" (
  "featureloc_pub_id" serial NOT NULL,
  "featureloc_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("featureloc_pub_id"),
  CONSTRAINT "featureloc_pub_c1" UNIQUE ("featureloc_id", "pub_id")
);
CREATE INDEX "featureloc_pub_idx_featureloc_id" on "featureloc_pub" ("featureloc_id");
CREATE INDEX "featureloc_pub_idx_pub_id" on "featureloc_pub" ("pub_id");

;
--
-- Table: featuremap
--
CREATE TABLE "featuremap" (
  "featuremap_id" serial NOT NULL,
  "name" character varying(255),
  "description" text,
  "unittype_id" integer,
  PRIMARY KEY ("featuremap_id"),
  CONSTRAINT "featuremap_c1" UNIQUE ("name")
);
CREATE INDEX "featuremap_idx_unittype_id" on "featuremap" ("unittype_id");

;
--
-- Table: featuremap_pub
--
CREATE TABLE "featuremap_pub" (
  "featuremap_pub_id" serial NOT NULL,
  "featuremap_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("featuremap_pub_id")
);
CREATE INDEX "featuremap_pub_idx_featuremap_id" on "featuremap_pub" ("featuremap_id");
CREATE INDEX "featuremap_pub_idx_pub_id" on "featuremap_pub" ("pub_id");

;
--
-- Table: featurepos
--
CREATE TABLE "featurepos" (
  "featurepos_id" serial NOT NULL,
  "featuremap_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "map_feature_id" integer NOT NULL,
  "mappos" double precision NOT NULL,
  PRIMARY KEY ("featurepos_id")
);
CREATE INDEX "featurepos_idx_feature_id" on "featurepos" ("feature_id");
CREATE INDEX "featurepos_idx_featuremap_id" on "featurepos" ("featuremap_id");
CREATE INDEX "featurepos_idx_map_feature_id" on "featurepos" ("map_feature_id");

;
--
-- Table: featureprop_pub
--
CREATE TABLE "featureprop_pub" (
  "featureprop_pub_id" serial NOT NULL,
  "featureprop_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("featureprop_pub_id"),
  CONSTRAINT "featureprop_pub_c1" UNIQUE ("featureprop_id", "pub_id")
);
CREATE INDEX "featureprop_pub_idx_featureprop_id" on "featureprop_pub" ("featureprop_id");
CREATE INDEX "featureprop_pub_idx_pub_id" on "featureprop_pub" ("pub_id");

;
--
-- Table: featurerange
--
CREATE TABLE "featurerange" (
  "featurerange_id" serial NOT NULL,
  "featuremap_id" integer NOT NULL,
  "feature_id" integer NOT NULL,
  "leftstartf_id" integer NOT NULL,
  "leftendf_id" integer,
  "rightstartf_id" integer,
  "rightendf_id" integer NOT NULL,
  "rangestr" character varying(255),
  PRIMARY KEY ("featurerange_id")
);
CREATE INDEX "featurerange_idx_feature_id" on "featurerange" ("feature_id");
CREATE INDEX "featurerange_idx_featuremap_id" on "featurerange" ("featuremap_id");
CREATE INDEX "featurerange_idx_leftendf_id" on "featurerange" ("leftendf_id");
CREATE INDEX "featurerange_idx_leftstartf_id" on "featurerange" ("leftstartf_id");
CREATE INDEX "featurerange_idx_rightendf_id" on "featurerange" ("rightendf_id");
CREATE INDEX "featurerange_idx_rightstartf_id" on "featurerange" ("rightstartf_id");

;
--
-- Table: featureset_meets
--
CREATE TABLE "featureset_meets" (
  "subject_id" integer,
  "object_id" integer
);

;
--
-- Table: fnr_type
--
CREATE TABLE "fnr_type" (
  "feature_id" integer,
  "name" character varying(255),
  "dbxref_id" integer,
  "type" character varying(1024),
  "residues" text,
  "seqlen" integer,
  "md5checksum" character(32),
  "type_id" integer,
  "timeaccessioned" timestamp,
  "timelastmodified" timestamp
);

;
--
-- Table: fp_key
--
CREATE TABLE "fp_key" (
  "feature_id" integer,
  "pkey" character varying(1024),
  "value" text
);

;
--
-- Table: genotype
--
CREATE TABLE "genotype" (
  "genotype_id" serial NOT NULL,
  "name" text,
  "uniquename" text NOT NULL,
  "description" character varying(255),
  PRIMARY KEY ("genotype_id"),
  CONSTRAINT "genotype_c1" UNIQUE ("uniquename")
);

;
--
-- Table: gff3atts
--
CREATE TABLE "gff3atts" (
  "feature_id" integer,
  "type" text,
  "attribute" text
);

;
--
-- Table: gff3view
--
CREATE TABLE "gff3view" (
  "feature_id" integer,
  "ref" character varying(255),
  "source" character varying(255),
  "type" character varying(1024),
  "fstart" integer,
  "fend" integer,
  "score" double precision,
  "strand" text,
  "phase" integer,
  "seqlen" integer,
  "name" character varying(255),
  "organism_id" integer
);

;
--
-- Table: gffatts
--
CREATE TABLE "gffatts" (
  "feature_id" integer,
  "type" text,
  "attribute" text
);

;
--
-- Table: intron_combined_view
--
CREATE TABLE "intron_combined_view" (
  "exon1_id" integer,
  "exon2_id" integer,
  "fmin" integer,
  "fmax" integer,
  "strand" smallint,
  "srcfeature_id" integer,
  "intron_rank" integer,
  "transcript_id" integer
);

;
--
-- Table: intronloc_view
--
CREATE TABLE "intronloc_view" (
  "exon1_id" integer,
  "exon2_id" integer,
  "fmin" integer,
  "fmax" integer,
  "strand" smallint,
  "srcfeature_id" integer
);

;
--
-- Table: library
--
CREATE TABLE "library" (
  "library_id" serial NOT NULL,
  "organism_id" integer NOT NULL,
  "name" character varying(255),
  "uniquename" text NOT NULL,
  "type_id" integer NOT NULL,
  "is_obsolete" integer DEFAULT 0 NOT NULL,
  "timeaccessioned" timestamp DEFAULT current_timestamp NOT NULL,
  "timelastmodified" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("library_id"),
  CONSTRAINT "library_c1" UNIQUE ("organism_id", "uniquename", "type_id")
);
CREATE INDEX "library_idx_organism_id" on "library" ("organism_id");
CREATE INDEX "library_idx_type_id" on "library" ("type_id");

;
--
-- Table: library_cvterm
--
CREATE TABLE "library_cvterm" (
  "library_cvterm_id" serial NOT NULL,
  "library_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("library_cvterm_id"),
  CONSTRAINT "library_cvterm_c1" UNIQUE ("library_id", "cvterm_id", "pub_id")
);
CREATE INDEX "library_cvterm_idx_cvterm_id" on "library_cvterm" ("cvterm_id");
CREATE INDEX "library_cvterm_idx_library_id" on "library_cvterm" ("library_id");
CREATE INDEX "library_cvterm_idx_pub_id" on "library_cvterm" ("pub_id");

;
--
-- Table: library_dbxref
--
CREATE TABLE "library_dbxref" (
  "library_dbxref_id" serial NOT NULL,
  "library_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  "is_current" boolean DEFAULT true NOT NULL,
  PRIMARY KEY ("library_dbxref_id"),
  CONSTRAINT "library_dbxref_c1" UNIQUE ("library_id", "dbxref_id")
);
CREATE INDEX "library_dbxref_idx_dbxref_id" on "library_dbxref" ("dbxref_id");
CREATE INDEX "library_dbxref_idx_library_id" on "library_dbxref" ("library_id");

;
--
-- Table: library_feature
--
CREATE TABLE "library_feature" (
  "library_feature_id" serial NOT NULL,
  "library_id" integer NOT NULL,
  "feature_id" integer NOT NULL,
  PRIMARY KEY ("library_feature_id"),
  CONSTRAINT "library_feature_c1" UNIQUE ("library_id", "feature_id")
);
CREATE INDEX "library_feature_idx_feature_id" on "library_feature" ("feature_id");
CREATE INDEX "library_feature_idx_library_id" on "library_feature" ("library_id");

;
--
-- Table: library_pub
--
CREATE TABLE "library_pub" (
  "library_pub_id" serial NOT NULL,
  "library_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("library_pub_id"),
  CONSTRAINT "library_pub_c1" UNIQUE ("library_id", "pub_id")
);
CREATE INDEX "library_pub_idx_library_id" on "library_pub" ("library_id");
CREATE INDEX "library_pub_idx_pub_id" on "library_pub" ("pub_id");

;
--
-- Table: library_synonym
--
CREATE TABLE "library_synonym" (
  "library_synonym_id" serial NOT NULL,
  "synonym_id" integer NOT NULL,
  "library_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  "is_current" boolean DEFAULT true NOT NULL,
  "is_internal" boolean DEFAULT false NOT NULL,
  PRIMARY KEY ("library_synonym_id"),
  CONSTRAINT "library_synonym_c1" UNIQUE ("synonym_id", "library_id", "pub_id")
);
CREATE INDEX "library_synonym_idx_library_id" on "library_synonym" ("library_id");
CREATE INDEX "library_synonym_idx_pub_id" on "library_synonym" ("pub_id");
CREATE INDEX "library_synonym_idx_synonym_id" on "library_synonym" ("synonym_id");

;
--
-- Table: libraryprop
--
CREATE TABLE "libraryprop" (
  "libraryprop_id" serial NOT NULL,
  "library_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("libraryprop_id"),
  CONSTRAINT "libraryprop_c1" UNIQUE ("library_id", "type_id", "rank")
);
CREATE INDEX "libraryprop_idx_library_id" on "libraryprop" ("library_id");
CREATE INDEX "libraryprop_idx_type_id" on "libraryprop" ("type_id");

;
--
-- Table: libraryprop_pub
--
CREATE TABLE "libraryprop_pub" (
  "libraryprop_pub_id" serial NOT NULL,
  "libraryprop_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("libraryprop_pub_id"),
  CONSTRAINT "libraryprop_pub_c1" UNIQUE ("libraryprop_id", "pub_id")
);
CREATE INDEX "libraryprop_pub_idx_libraryprop_id" on "libraryprop_pub" ("libraryprop_id");
CREATE INDEX "libraryprop_pub_idx_pub_id" on "libraryprop_pub" ("pub_id");

;
--
-- Table: magedocumentation
--
CREATE TABLE "magedocumentation" (
  "magedocumentation_id" serial NOT NULL,
  "mageml_id" integer NOT NULL,
  "tableinfo_id" integer NOT NULL,
  "row_id" integer NOT NULL,
  "mageidentifier" text NOT NULL,
  PRIMARY KEY ("magedocumentation_id")
);
CREATE INDEX "magedocumentation_idx_mageml_id" on "magedocumentation" ("mageml_id");
CREATE INDEX "magedocumentation_idx_tableinfo_id" on "magedocumentation" ("tableinfo_id");

;
--
-- Table: mageml
--
CREATE TABLE "mageml" (
  "mageml_id" serial NOT NULL,
  "mage_package" text NOT NULL,
  "mage_ml" text NOT NULL,
  PRIMARY KEY ("mageml_id")
);

;
--
-- Table: nd_experiment
--
CREATE TABLE "nd_experiment" (
  "nd_experiment_id" serial NOT NULL,
  "nd_geolocation_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_id")
);
CREATE INDEX "nd_experiment_idx_nd_geolocation_id" on "nd_experiment" ("nd_geolocation_id");
CREATE INDEX "nd_experiment_idx_type_id" on "nd_experiment" ("type_id");

;
--
-- Table: nd_experiment_contact
--
CREATE TABLE "nd_experiment_contact" (
  "nd_experiment_contact_id" serial NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  "contact_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_contact_id")
);
CREATE INDEX "nd_experiment_contact_idx_contact_id" on "nd_experiment_contact" ("contact_id");
CREATE INDEX "nd_experiment_contact_idx_nd_experiment_id" on "nd_experiment_contact" ("nd_experiment_id");

;
--
-- Table: nd_experiment_dbxref
--
CREATE TABLE "nd_experiment_dbxref" (
  "nd_experiment_dbxref_id" serial NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_dbxref_id")
);
CREATE INDEX "nd_experiment_dbxref_idx_dbxref_id" on "nd_experiment_dbxref" ("dbxref_id");
CREATE INDEX "nd_experiment_dbxref_idx_nd_experiment_id" on "nd_experiment_dbxref" ("nd_experiment_id");

;
--
-- Table: nd_experiment_genotype
--
CREATE TABLE "nd_experiment_genotype" (
  "nd_experiment_genotype_id" serial NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  "genotype_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_genotype_id"),
  CONSTRAINT "nd_experiment_genotype_c1" UNIQUE ("nd_experiment_id", "genotype_id")
);
CREATE INDEX "nd_experiment_genotype_idx_genotype_id" on "nd_experiment_genotype" ("genotype_id");
CREATE INDEX "nd_experiment_genotype_idx_nd_experiment_id" on "nd_experiment_genotype" ("nd_experiment_id");

;
--
-- Table: nd_experiment_phenotype
--
CREATE TABLE "nd_experiment_phenotype" (
  "nd_experiment_phenotype_id" serial NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  "phenotype_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_phenotype_id"),
  CONSTRAINT "nd_experiment_phenotype_c1" UNIQUE ("nd_experiment_id", "phenotype_id")
);
CREATE INDEX "nd_experiment_phenotype_idx_nd_experiment_id" on "nd_experiment_phenotype" ("nd_experiment_id");
CREATE INDEX "nd_experiment_phenotype_idx_phenotype_id" on "nd_experiment_phenotype" ("phenotype_id");

;
--
-- Table: nd_experiment_project
--
CREATE TABLE "nd_experiment_project" (
  "nd_experiment_project_id" serial NOT NULL,
  "project_id" integer NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_project_id")
);
CREATE INDEX "nd_experiment_project_idx_nd_experiment_id" on "nd_experiment_project" ("nd_experiment_id");
CREATE INDEX "nd_experiment_project_idx_project_id" on "nd_experiment_project" ("project_id");

;
--
-- Table: nd_experiment_protocol
--
CREATE TABLE "nd_experiment_protocol" (
  "nd_experiment_protocol_id" serial NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  "nd_protocol_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_protocol_id")
);
CREATE INDEX "nd_experiment_protocol_idx_nd_experiment_id" on "nd_experiment_protocol" ("nd_experiment_id");
CREATE INDEX "nd_experiment_protocol_idx_nd_protocol_id" on "nd_experiment_protocol" ("nd_protocol_id");

;
--
-- Table: nd_experiment_pub
--
CREATE TABLE "nd_experiment_pub" (
  "nd_experiment_pub_id" serial NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_pub_id"),
  CONSTRAINT "nd_experiment_pub_c1" UNIQUE ("nd_experiment_id", "pub_id")
);
CREATE INDEX "nd_experiment_pub_idx_nd_experiment_id" on "nd_experiment_pub" ("nd_experiment_id");
CREATE INDEX "nd_experiment_pub_idx_pub_id" on "nd_experiment_pub" ("pub_id");

;
--
-- Table: nd_experiment_stock
--
CREATE TABLE "nd_experiment_stock" (
  "nd_experiment_stock_id" serial NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  "stock_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_stock_id")
);
CREATE INDEX "nd_experiment_stock_idx_nd_experiment_id" on "nd_experiment_stock" ("nd_experiment_id");
CREATE INDEX "nd_experiment_stock_idx_stock_id" on "nd_experiment_stock" ("stock_id");
CREATE INDEX "nd_experiment_stock_idx_type_id" on "nd_experiment_stock" ("type_id");

;
--
-- Table: nd_experiment_stock_dbxref
--
CREATE TABLE "nd_experiment_stock_dbxref" (
  "nd_experiment_stock_dbxref_id" serial NOT NULL,
  "nd_experiment_stock_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  PRIMARY KEY ("nd_experiment_stock_dbxref_id")
);
CREATE INDEX "nd_experiment_stock_dbxref_idx_dbxref_id" on "nd_experiment_stock_dbxref" ("dbxref_id");
CREATE INDEX "nd_experiment_stock_dbxref_idx_nd_experiment_stock_id" on "nd_experiment_stock_dbxref" ("nd_experiment_stock_id");

;
--
-- Table: nd_experiment_stockprop
--
CREATE TABLE "nd_experiment_stockprop" (
  "nd_experiment_stockprop_id" serial NOT NULL,
  "nd_experiment_stock_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" character varying(255),
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("nd_experiment_stockprop_id"),
  CONSTRAINT "nd_experiment_stockprop_c1" UNIQUE ("nd_experiment_stock_id", "type_id", "rank")
);
CREATE INDEX "nd_experiment_stockprop_idx_nd_experiment_stock_id" on "nd_experiment_stockprop" ("nd_experiment_stock_id");
CREATE INDEX "nd_experiment_stockprop_idx_type_id" on "nd_experiment_stockprop" ("type_id");

;
--
-- Table: nd_experimentprop
--
CREATE TABLE "nd_experimentprop" (
  "nd_experimentprop_id" serial NOT NULL,
  "nd_experiment_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" character varying(255) NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("nd_experimentprop_id"),
  CONSTRAINT "nd_experimentprop_c1" UNIQUE ("nd_experiment_id", "type_id", "rank")
);
CREATE INDEX "nd_experimentprop_idx_nd_experiment_id" on "nd_experimentprop" ("nd_experiment_id");
CREATE INDEX "nd_experimentprop_idx_type_id" on "nd_experimentprop" ("type_id");

;
--
-- Table: nd_geolocation
--
CREATE TABLE "nd_geolocation" (
  "nd_geolocation_id" serial NOT NULL,
  "description" character varying(255),
  "latitude" numeric,
  "longitude" numeric,
  "geodetic_datum" character varying(32),
  "altitude" numeric,
  PRIMARY KEY ("nd_geolocation_id")
);

;
--
-- Table: nd_geolocationprop
--
CREATE TABLE "nd_geolocationprop" (
  "nd_geolocationprop_id" serial NOT NULL,
  "nd_geolocation_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" character varying(250),
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("nd_geolocationprop_id"),
  CONSTRAINT "nd_geolocationprop_c1" UNIQUE ("nd_geolocation_id", "type_id", "rank")
);
CREATE INDEX "nd_geolocationprop_idx_nd_geolocation_id" on "nd_geolocationprop" ("nd_geolocation_id");
CREATE INDEX "nd_geolocationprop_idx_type_id" on "nd_geolocationprop" ("type_id");

;
--
-- Table: nd_protocol
--
CREATE TABLE "nd_protocol" (
  "nd_protocol_id" serial NOT NULL,
  "name" character varying(255) NOT NULL,
  PRIMARY KEY ("nd_protocol_id"),
  CONSTRAINT "nd_protocol_name_key" UNIQUE ("name")
);

;
--
-- Table: nd_protocol_reagent
--
CREATE TABLE "nd_protocol_reagent" (
  "nd_protocol_reagent_id" serial NOT NULL,
  "nd_protocol_id" integer NOT NULL,
  "reagent_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  PRIMARY KEY ("nd_protocol_reagent_id")
);
CREATE INDEX "nd_protocol_reagent_idx_nd_protocol_id" on "nd_protocol_reagent" ("nd_protocol_id");
CREATE INDEX "nd_protocol_reagent_idx_reagent_id" on "nd_protocol_reagent" ("reagent_id");
CREATE INDEX "nd_protocol_reagent_idx_type_id" on "nd_protocol_reagent" ("type_id");

;
--
-- Table: nd_protocolprop
--
CREATE TABLE "nd_protocolprop" (
  "nd_protocolprop_id" serial NOT NULL,
  "nd_protocol_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" character varying(255),
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("nd_protocolprop_id"),
  CONSTRAINT "nd_protocolprop_c1" UNIQUE ("nd_protocol_id", "type_id", "rank")
);
CREATE INDEX "nd_protocolprop_idx_nd_protocol_id" on "nd_protocolprop" ("nd_protocol_id");
CREATE INDEX "nd_protocolprop_idx_type_id" on "nd_protocolprop" ("type_id");

;
--
-- Table: nd_reagent
--
CREATE TABLE "nd_reagent" (
  "nd_reagent_id" serial NOT NULL,
  "name" character varying(80) NOT NULL,
  "type_id" integer NOT NULL,
  "feature_id" integer,
  PRIMARY KEY ("nd_reagent_id")
);
CREATE INDEX "nd_reagent_idx_type_id" on "nd_reagent" ("type_id");

;
--
-- Table: nd_reagent_relationship
--
CREATE TABLE "nd_reagent_relationship" (
  "nd_reagent_relationship_id" serial NOT NULL,
  "subject_reagent_id" integer NOT NULL,
  "object_reagent_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  PRIMARY KEY ("nd_reagent_relationship_id")
);
CREATE INDEX "nd_reagent_relationship_idx_object_reagent_id" on "nd_reagent_relationship" ("object_reagent_id");
CREATE INDEX "nd_reagent_relationship_idx_subject_reagent_id" on "nd_reagent_relationship" ("subject_reagent_id");
CREATE INDEX "nd_reagent_relationship_idx_type_id" on "nd_reagent_relationship" ("type_id");

;
--
-- Table: nd_reagentprop
--
CREATE TABLE "nd_reagentprop" (
  "nd_reagentprop_id" serial NOT NULL,
  "nd_reagent_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" character varying(255),
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("nd_reagentprop_id"),
  CONSTRAINT "nd_reagentprop_c1" UNIQUE ("nd_reagent_id", "type_id", "rank")
);
CREATE INDEX "nd_reagentprop_idx_nd_reagent_id" on "nd_reagentprop" ("nd_reagent_id");
CREATE INDEX "nd_reagentprop_idx_type_id" on "nd_reagentprop" ("type_id");

;
--
-- Table: organism
--
CREATE TABLE "organism" (
  "organism_id" serial NOT NULL,
  "abbreviation" character varying(255),
  "genus" character varying(255) NOT NULL,
  "species" character varying(255) NOT NULL,
  "common_name" character varying(255),
  "comment" text,
  PRIMARY KEY ("organism_id"),
  CONSTRAINT "organism_c1" UNIQUE ("genus", "species")
);

;
--
-- Table: organism_dbxref
--
CREATE TABLE "organism_dbxref" (
  "organism_dbxref_id" serial NOT NULL,
  "organism_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  PRIMARY KEY ("organism_dbxref_id"),
  CONSTRAINT "organism_dbxref_c1" UNIQUE ("organism_id", "dbxref_id")
);
CREATE INDEX "organism_dbxref_idx_dbxref_id" on "organism_dbxref" ("dbxref_id");
CREATE INDEX "organism_dbxref_idx_organism_id" on "organism_dbxref" ("organism_id");

;
--
-- Table: organismprop
--
CREATE TABLE "organismprop" (
  "organismprop_id" serial NOT NULL,
  "organism_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("organismprop_id"),
  CONSTRAINT "organismprop_c1" UNIQUE ("organism_id", "type_id", "rank")
);
CREATE INDEX "organismprop_idx_organism_id" on "organismprop" ("organism_id");
CREATE INDEX "organismprop_idx_type_id" on "organismprop" ("type_id");

;
--
-- Table: phendesc
--
CREATE TABLE "phendesc" (
  "phendesc_id" serial NOT NULL,
  "genotype_id" integer NOT NULL,
  "environment_id" integer NOT NULL,
  "description" text NOT NULL,
  "type_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("phendesc_id"),
  CONSTRAINT "phendesc_c1" UNIQUE ("genotype_id", "environment_id", "type_id", "pub_id")
);
CREATE INDEX "phendesc_idx_environment_id" on "phendesc" ("environment_id");
CREATE INDEX "phendesc_idx_genotype_id" on "phendesc" ("genotype_id");
CREATE INDEX "phendesc_idx_pub_id" on "phendesc" ("pub_id");
CREATE INDEX "phendesc_idx_type_id" on "phendesc" ("type_id");

;
--
-- Table: phenotype
--
CREATE TABLE "phenotype" (
  "phenotype_id" serial NOT NULL,
  "uniquename" text NOT NULL,
  "observable_id" integer,
  "attr_id" integer,
  "value" text,
  "cvalue_id" integer,
  "assay_id" integer,
  PRIMARY KEY ("phenotype_id"),
  CONSTRAINT "phenotype_c1" UNIQUE ("uniquename")
);
CREATE INDEX "phenotype_idx_assay_id" on "phenotype" ("assay_id");
CREATE INDEX "phenotype_idx_attr_id" on "phenotype" ("attr_id");
CREATE INDEX "phenotype_idx_cvalue_id" on "phenotype" ("cvalue_id");
CREATE INDEX "phenotype_idx_observable_id" on "phenotype" ("observable_id");

;
--
-- Table: phenotype_comparison
--
CREATE TABLE "phenotype_comparison" (
  "phenotype_comparison_id" serial NOT NULL,
  "genotype1_id" integer NOT NULL,
  "environment1_id" integer NOT NULL,
  "genotype2_id" integer NOT NULL,
  "environment2_id" integer NOT NULL,
  "phenotype1_id" integer NOT NULL,
  "phenotype2_id" integer,
  "pub_id" integer NOT NULL,
  "organism_id" integer NOT NULL,
  PRIMARY KEY ("phenotype_comparison_id"),
  CONSTRAINT "phenotype_comparison_c1" UNIQUE ("genotype1_id", "environment1_id", "genotype2_id", "environment2_id", "phenotype1_id", "pub_id")
);
CREATE INDEX "phenotype_comparison_idx_environment1_id" on "phenotype_comparison" ("environment1_id");
CREATE INDEX "phenotype_comparison_idx_environment2_id" on "phenotype_comparison" ("environment2_id");
CREATE INDEX "phenotype_comparison_idx_genotype1_id" on "phenotype_comparison" ("genotype1_id");
CREATE INDEX "phenotype_comparison_idx_genotype2_id" on "phenotype_comparison" ("genotype2_id");
CREATE INDEX "phenotype_comparison_idx_organism_id" on "phenotype_comparison" ("organism_id");
CREATE INDEX "phenotype_comparison_idx_phenotype1_id" on "phenotype_comparison" ("phenotype1_id");
CREATE INDEX "phenotype_comparison_idx_phenotype2_id" on "phenotype_comparison" ("phenotype2_id");
CREATE INDEX "phenotype_comparison_idx_pub_id" on "phenotype_comparison" ("pub_id");

;
--
-- Table: phenotype_comparison_cvterm
--
CREATE TABLE "phenotype_comparison_cvterm" (
  "phenotype_comparison_cvterm_id" serial NOT NULL,
  "phenotype_comparison_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("phenotype_comparison_cvterm_id"),
  CONSTRAINT "phenotype_comparison_cvterm_c1" UNIQUE ("phenotype_comparison_id", "cvterm_id")
);
CREATE INDEX "phenotype_comparison_cvterm_idx_cvterm_id" on "phenotype_comparison_cvterm" ("cvterm_id");
CREATE INDEX "phenotype_comparison_cvterm_idx_phenotype_comparison_id" on "phenotype_comparison_cvterm" ("phenotype_comparison_id");
CREATE INDEX "phenotype_comparison_cvterm_idx_pub_id" on "phenotype_comparison_cvterm" ("pub_id");

;
--
-- Table: phenotype_cvterm
--
CREATE TABLE "phenotype_cvterm" (
  "phenotype_cvterm_id" serial NOT NULL,
  "phenotype_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("phenotype_cvterm_id"),
  CONSTRAINT "phenotype_cvterm_c1" UNIQUE ("phenotype_id", "cvterm_id", "rank")
);
CREATE INDEX "phenotype_cvterm_idx_cvterm_id" on "phenotype_cvterm" ("cvterm_id");
CREATE INDEX "phenotype_cvterm_idx_phenotype_id" on "phenotype_cvterm" ("phenotype_id");

;
--
-- Table: phenstatement
--
CREATE TABLE "phenstatement" (
  "phenstatement_id" serial NOT NULL,
  "genotype_id" integer NOT NULL,
  "environment_id" integer NOT NULL,
  "phenotype_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("phenstatement_id"),
  CONSTRAINT "phenstatement_c1" UNIQUE ("genotype_id", "phenotype_id", "environment_id", "type_id", "pub_id")
);
CREATE INDEX "phenstatement_idx_environment_id" on "phenstatement" ("environment_id");
CREATE INDEX "phenstatement_idx_genotype_id" on "phenstatement" ("genotype_id");
CREATE INDEX "phenstatement_idx_phenotype_id" on "phenstatement" ("phenotype_id");
CREATE INDEX "phenstatement_idx_pub_id" on "phenstatement" ("pub_id");
CREATE INDEX "phenstatement_idx_type_id" on "phenstatement" ("type_id");

;
--
-- Table: phylonode
--
CREATE TABLE "phylonode" (
  "phylonode_id" serial NOT NULL,
  "phylotree_id" integer NOT NULL,
  "parent_phylonode_id" integer,
  "left_idx" integer NOT NULL,
  "right_idx" integer NOT NULL,
  "type_id" integer,
  "feature_id" integer,
  "label" character varying(255),
  "distance" double precision,
  PRIMARY KEY ("phylonode_id"),
  CONSTRAINT "phylonode_phylotree_id_key" UNIQUE ("phylotree_id", "left_idx"),
  CONSTRAINT "phylonode_phylotree_id_key1" UNIQUE ("phylotree_id", "right_idx")
);
CREATE INDEX "phylonode_idx_feature_id" on "phylonode" ("feature_id");
CREATE INDEX "phylonode_idx_phylotree_id" on "phylonode" ("phylotree_id");
CREATE INDEX "phylonode_idx_parent_phylonode_id" on "phylonode" ("parent_phylonode_id");
CREATE INDEX "phylonode_idx_type_id" on "phylonode" ("type_id");

;
--
-- Table: phylonode_dbxref
--
CREATE TABLE "phylonode_dbxref" (
  "phylonode_dbxref_id" serial NOT NULL,
  "phylonode_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  PRIMARY KEY ("phylonode_dbxref_id"),
  CONSTRAINT "phylonode_dbxref_phylonode_id_key" UNIQUE ("phylonode_id", "dbxref_id")
);
CREATE INDEX "phylonode_dbxref_idx_dbxref_id" on "phylonode_dbxref" ("dbxref_id");
CREATE INDEX "phylonode_dbxref_idx_phylonode_id" on "phylonode_dbxref" ("phylonode_id");

;
--
-- Table: phylonode_organism
--
CREATE TABLE "phylonode_organism" (
  "phylonode_organism_id" serial NOT NULL,
  "phylonode_id" integer NOT NULL,
  "organism_id" integer NOT NULL,
  PRIMARY KEY ("phylonode_organism_id"),
  CONSTRAINT "phylonode_organism_phylonode_id_key" UNIQUE ("phylonode_id")
);
CREATE INDEX "phylonode_organism_idx_organism_id" on "phylonode_organism" ("organism_id");
CREATE INDEX "phylonode_organism_idx_phylonode_id" on "phylonode_organism" ("phylonode_id");

;
--
-- Table: phylonode_pub
--
CREATE TABLE "phylonode_pub" (
  "phylonode_pub_id" serial NOT NULL,
  "phylonode_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("phylonode_pub_id"),
  CONSTRAINT "phylonode_pub_phylonode_id_key" UNIQUE ("phylonode_id", "pub_id")
);
CREATE INDEX "phylonode_pub_idx_phylonode_id" on "phylonode_pub" ("phylonode_id");
CREATE INDEX "phylonode_pub_idx_pub_id" on "phylonode_pub" ("pub_id");

;
--
-- Table: phylonode_relationship
--
CREATE TABLE "phylonode_relationship" (
  "phylonode_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "rank" integer,
  "phylotree_id" integer NOT NULL,
  PRIMARY KEY ("phylonode_relationship_id"),
  CONSTRAINT "phylonode_relationship_subject_id_key" UNIQUE ("subject_id", "object_id", "type_id")
);
CREATE INDEX "phylonode_relationship_idx_object_id" on "phylonode_relationship" ("object_id");
CREATE INDEX "phylonode_relationship_idx_phylotree_id" on "phylonode_relationship" ("phylotree_id");
CREATE INDEX "phylonode_relationship_idx_subject_id" on "phylonode_relationship" ("subject_id");
CREATE INDEX "phylonode_relationship_idx_type_id" on "phylonode_relationship" ("type_id");

;
--
-- Table: phylonodeprop
--
CREATE TABLE "phylonodeprop" (
  "phylonodeprop_id" serial NOT NULL,
  "phylonode_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text DEFAULT '' NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("phylonodeprop_id"),
  CONSTRAINT "phylonodeprop_phylonode_id_key" UNIQUE ("phylonode_id", "type_id", "value", "rank")
);
CREATE INDEX "phylonodeprop_idx_phylonode_id" on "phylonodeprop" ("phylonode_id");
CREATE INDEX "phylonodeprop_idx_type_id" on "phylonodeprop" ("type_id");

;
--
-- Table: phylotree
--
CREATE TABLE "phylotree" (
  "phylotree_id" serial NOT NULL,
  "dbxref_id" integer NOT NULL,
  "name" character varying(255),
  "type_id" integer,
  "analysis_id" integer,
  "comment" text,
  PRIMARY KEY ("phylotree_id")
);
CREATE INDEX "phylotree_idx_analysis_id" on "phylotree" ("analysis_id");
CREATE INDEX "phylotree_idx_dbxref_id" on "phylotree" ("dbxref_id");
CREATE INDEX "phylotree_idx_type_id" on "phylotree" ("type_id");

;
--
-- Table: phylotree_pub
--
CREATE TABLE "phylotree_pub" (
  "phylotree_pub_id" serial NOT NULL,
  "phylotree_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("phylotree_pub_id"),
  CONSTRAINT "phylotree_pub_phylotree_id_key" UNIQUE ("phylotree_id", "pub_id")
);
CREATE INDEX "phylotree_pub_idx_phylotree_id" on "phylotree_pub" ("phylotree_id");
CREATE INDEX "phylotree_pub_idx_pub_id" on "phylotree_pub" ("pub_id");

;
--
-- Table: project
--
CREATE TABLE "project" (
  "project_id" serial NOT NULL,
  "name" character varying(255) NOT NULL,
  "description" character varying(255) NOT NULL,
  PRIMARY KEY ("project_id"),
  CONSTRAINT "project_c1" UNIQUE ("name")
);

;
--
-- Table: project_contact
--
CREATE TABLE "project_contact" (
  "project_contact_id" serial NOT NULL,
  "project_id" integer NOT NULL,
  "contact_id" integer NOT NULL,
  PRIMARY KEY ("project_contact_id"),
  CONSTRAINT "project_contact_c1" UNIQUE ("project_id", "contact_id")
);
CREATE INDEX "project_contact_idx_contact_id" on "project_contact" ("contact_id");
CREATE INDEX "project_contact_idx_project_id" on "project_contact" ("project_id");

;
--
-- Table: project_pub
--
CREATE TABLE "project_pub" (
  "project_pub_id" serial NOT NULL,
  "project_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("project_pub_id"),
  CONSTRAINT "project_pub_c1" UNIQUE ("project_id", "pub_id")
);
CREATE INDEX "project_pub_idx_project_id" on "project_pub" ("project_id");
CREATE INDEX "project_pub_idx_pub_id" on "project_pub" ("pub_id");

;
--
-- Table: project_relationship
--
CREATE TABLE "project_relationship" (
  "project_relationship_id" serial NOT NULL,
  "subject_project_id" integer NOT NULL,
  "object_project_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  PRIMARY KEY ("project_relationship_id"),
  CONSTRAINT "project_relationship_c1" UNIQUE ("subject_project_id", "object_project_id", "type_id")
);
CREATE INDEX "project_relationship_idx_object_project_id" on "project_relationship" ("object_project_id");
CREATE INDEX "project_relationship_idx_subject_project_id" on "project_relationship" ("subject_project_id");
CREATE INDEX "project_relationship_idx_type_id" on "project_relationship" ("type_id");

;
--
-- Table: projectprop
--
CREATE TABLE "projectprop" (
  "projectprop_id" serial NOT NULL,
  "project_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("projectprop_id"),
  CONSTRAINT "projectprop_c1" UNIQUE ("project_id", "type_id", "rank")
);
CREATE INDEX "projectprop_idx_project_id" on "projectprop" ("project_id");
CREATE INDEX "projectprop_idx_type_id" on "projectprop" ("type_id");

;
--
-- Table: protein_coding_gene
--
CREATE TABLE "protein_coding_gene" (
  "feature_id" integer,
  "dbxref_id" integer,
  "organism_id" integer,
  "name" character varying(255),
  "uniquename" text,
  "residues" text,
  "seqlen" integer,
  "md5checksum" character(32),
  "type_id" integer,
  "is_analysis" boolean,
  "is_obsolete" boolean,
  "timeaccessioned" timestamp,
  "timelastmodified" timestamp
);

;
--
-- Table: protocol
--
CREATE TABLE "protocol" (
  "protocol_id" serial NOT NULL,
  "type_id" integer NOT NULL,
  "pub_id" integer,
  "dbxref_id" integer,
  "name" text NOT NULL,
  "uri" text,
  "protocoldescription" text,
  "hardwaredescription" text,
  "softwaredescription" text,
  PRIMARY KEY ("protocol_id"),
  CONSTRAINT "protocol_c1" UNIQUE ("name")
);
CREATE INDEX "protocol_idx_dbxref_id" on "protocol" ("dbxref_id");
CREATE INDEX "protocol_idx_pub_id" on "protocol" ("pub_id");
CREATE INDEX "protocol_idx_type_id" on "protocol" ("type_id");

;
--
-- Table: protocolparam
--
CREATE TABLE "protocolparam" (
  "protocolparam_id" serial NOT NULL,
  "protocol_id" integer NOT NULL,
  "name" text NOT NULL,
  "datatype_id" integer,
  "unittype_id" integer,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("protocolparam_id")
);
CREATE INDEX "protocolparam_idx_datatype_id" on "protocolparam" ("datatype_id");
CREATE INDEX "protocolparam_idx_protocol_id" on "protocolparam" ("protocol_id");
CREATE INDEX "protocolparam_idx_unittype_id" on "protocolparam" ("unittype_id");

;
--
-- Table: pub
--
CREATE TABLE "pub" (
  "pub_id" serial NOT NULL,
  "title" text,
  "volumetitle" text,
  "volume" character varying(255),
  "series_name" character varying(255),
  "issue" character varying(255),
  "pyear" character varying(255),
  "pages" character varying(255),
  "miniref" character varying(255),
  "uniquename" text NOT NULL,
  "type_id" integer NOT NULL,
  "is_obsolete" boolean DEFAULT false,
  "publisher" character varying(255),
  "pubplace" character varying(255),
  PRIMARY KEY ("pub_id"),
  CONSTRAINT "pub_c1" UNIQUE ("uniquename")
);
CREATE INDEX "pub_idx_type_id" on "pub" ("type_id");

;
--
-- Table: pub_dbxref
--
CREATE TABLE "pub_dbxref" (
  "pub_dbxref_id" serial NOT NULL,
  "pub_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  "is_current" boolean DEFAULT true NOT NULL,
  PRIMARY KEY ("pub_dbxref_id"),
  CONSTRAINT "pub_dbxref_c1" UNIQUE ("pub_id", "dbxref_id")
);
CREATE INDEX "pub_dbxref_idx_dbxref_id" on "pub_dbxref" ("dbxref_id");
CREATE INDEX "pub_dbxref_idx_pub_id" on "pub_dbxref" ("pub_id");

;
--
-- Table: pub_relationship
--
CREATE TABLE "pub_relationship" (
  "pub_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  PRIMARY KEY ("pub_relationship_id"),
  CONSTRAINT "pub_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
CREATE INDEX "pub_relationship_idx_object_id" on "pub_relationship" ("object_id");
CREATE INDEX "pub_relationship_idx_subject_id" on "pub_relationship" ("subject_id");
CREATE INDEX "pub_relationship_idx_type_id" on "pub_relationship" ("type_id");

;
--
-- Table: pubauthor
--
CREATE TABLE "pubauthor" (
  "pubauthor_id" serial NOT NULL,
  "pub_id" integer NOT NULL,
  "rank" integer NOT NULL,
  "editor" boolean DEFAULT false,
  "surname" character varying(100) NOT NULL,
  "givennames" character varying(100),
  "suffix" character varying(100),
  PRIMARY KEY ("pubauthor_id"),
  CONSTRAINT "pubauthor_c1" UNIQUE ("pub_id", "rank")
);
CREATE INDEX "pubauthor_idx_pub_id" on "pubauthor" ("pub_id");

;
--
-- Table: pubprop
--
CREATE TABLE "pubprop" (
  "pubprop_id" serial NOT NULL,
  "pub_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text NOT NULL,
  "rank" integer,
  PRIMARY KEY ("pubprop_id"),
  CONSTRAINT "pubprop_c1" UNIQUE ("pub_id", "type_id", "rank")
);
CREATE INDEX "pubprop_idx_pub_id" on "pubprop" ("pub_id");
CREATE INDEX "pubprop_idx_type_id" on "pubprop" ("type_id");

;
--
-- Table: quantification
--
CREATE TABLE "quantification" (
  "quantification_id" serial NOT NULL,
  "acquisition_id" integer NOT NULL,
  "operator_id" integer,
  "protocol_id" integer,
  "analysis_id" integer NOT NULL,
  "quantificationdate" timestamp DEFAULT current_timestamp,
  "name" text,
  "uri" text,
  PRIMARY KEY ("quantification_id"),
  CONSTRAINT "quantification_c1" UNIQUE ("name", "analysis_id")
);
CREATE INDEX "quantification_idx_acquisition_id" on "quantification" ("acquisition_id");
CREATE INDEX "quantification_idx_analysis_id" on "quantification" ("analysis_id");
CREATE INDEX "quantification_idx_operator_id" on "quantification" ("operator_id");
CREATE INDEX "quantification_idx_protocol_id" on "quantification" ("protocol_id");

;
--
-- Table: quantification_relationship
--
CREATE TABLE "quantification_relationship" (
  "quantification_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  PRIMARY KEY ("quantification_relationship_id"),
  CONSTRAINT "quantification_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id")
);
CREATE INDEX "quantification_relationship_idx_object_id" on "quantification_relationship" ("object_id");
CREATE INDEX "quantification_relationship_idx_subject_id" on "quantification_relationship" ("subject_id");
CREATE INDEX "quantification_relationship_idx_type_id" on "quantification_relationship" ("type_id");

;
--
-- Table: quantificationprop
--
CREATE TABLE "quantificationprop" (
  "quantificationprop_id" serial NOT NULL,
  "quantification_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("quantificationprop_id"),
  CONSTRAINT "quantificationprop_c1" UNIQUE ("quantification_id", "type_id", "rank")
);
CREATE INDEX "quantificationprop_idx_quantification_id" on "quantificationprop" ("quantification_id");
CREATE INDEX "quantificationprop_idx_type_id" on "quantificationprop" ("type_id");

;
--
-- Table: stats_paths_to_root
--
CREATE TABLE "stats_paths_to_root" (
  "cvterm_id" integer,
  "total_paths" bigint,
  "avg_distance" numeric,
  "min_distance" integer,
  "max_distance" integer
);

;
--
-- Table: stock
--
CREATE TABLE "stock" (
  "stock_id" serial NOT NULL,
  "dbxref_id" integer,
  "organism_id" integer,
  "name" character varying(255),
  "uniquename" text NOT NULL,
  "description" text,
  "type_id" integer NOT NULL,
  "is_obsolete" boolean DEFAULT false NOT NULL,
  PRIMARY KEY ("stock_id"),
  CONSTRAINT "stock_c1" UNIQUE ("organism_id", "uniquename", "type_id")
);
CREATE INDEX "stock_idx_dbxref_id" on "stock" ("dbxref_id");
CREATE INDEX "stock_idx_organism_id" on "stock" ("organism_id");
CREATE INDEX "stock_idx_type_id" on "stock" ("type_id");

;
--
-- Table: stock_cvterm
--
CREATE TABLE "stock_cvterm" (
  "stock_cvterm_id" serial NOT NULL,
  "stock_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("stock_cvterm_id"),
  CONSTRAINT "stock_cvterm_c1" UNIQUE ("stock_id", "cvterm_id", "pub_id")
);
CREATE INDEX "stock_cvterm_idx_cvterm_id" on "stock_cvterm" ("cvterm_id");
CREATE INDEX "stock_cvterm_idx_pub_id" on "stock_cvterm" ("pub_id");
CREATE INDEX "stock_cvterm_idx_stock_id" on "stock_cvterm" ("stock_id");

;
--
-- Table: stock_dbxref
--
CREATE TABLE "stock_dbxref" (
  "stock_dbxref_id" serial NOT NULL,
  "stock_id" integer NOT NULL,
  "dbxref_id" integer NOT NULL,
  "is_current" boolean DEFAULT true NOT NULL,
  PRIMARY KEY ("stock_dbxref_id"),
  CONSTRAINT "stock_dbxref_c1" UNIQUE ("stock_id", "dbxref_id")
);
CREATE INDEX "stock_dbxref_idx_dbxref_id" on "stock_dbxref" ("dbxref_id");
CREATE INDEX "stock_dbxref_idx_stock_id" on "stock_dbxref" ("stock_id");

;
--
-- Table: stock_dbxrefprop
--
CREATE TABLE "stock_dbxrefprop" (
  "stock_dbxrefprop_id" serial NOT NULL,
  "stock_dbxref_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("stock_dbxrefprop_id"),
  CONSTRAINT "stock_dbxrefprop_c1" UNIQUE ("stock_dbxref_id", "type_id", "rank")
);
CREATE INDEX "stock_dbxrefprop_idx_stock_dbxref_id" on "stock_dbxrefprop" ("stock_dbxref_id");
CREATE INDEX "stock_dbxrefprop_idx_type_id" on "stock_dbxrefprop" ("type_id");

;
--
-- Table: stock_genotype
--
CREATE TABLE "stock_genotype" (
  "stock_genotype_id" serial NOT NULL,
  "stock_id" integer NOT NULL,
  "genotype_id" integer NOT NULL,
  PRIMARY KEY ("stock_genotype_id"),
  CONSTRAINT "stock_genotype_c1" UNIQUE ("stock_id", "genotype_id")
);
CREATE INDEX "stock_genotype_idx_genotype_id" on "stock_genotype" ("genotype_id");
CREATE INDEX "stock_genotype_idx_stock_id" on "stock_genotype" ("stock_id");

;
--
-- Table: stock_pub
--
CREATE TABLE "stock_pub" (
  "stock_pub_id" serial NOT NULL,
  "stock_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("stock_pub_id"),
  CONSTRAINT "stock_pub_c1" UNIQUE ("stock_id", "pub_id")
);
CREATE INDEX "stock_pub_idx_pub_id" on "stock_pub" ("pub_id");
CREATE INDEX "stock_pub_idx_stock_id" on "stock_pub" ("stock_id");

;
--
-- Table: stock_relationship
--
CREATE TABLE "stock_relationship" (
  "stock_relationship_id" serial NOT NULL,
  "subject_id" integer NOT NULL,
  "object_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("stock_relationship_id"),
  CONSTRAINT "stock_relationship_c1" UNIQUE ("subject_id", "object_id", "type_id", "rank")
);
CREATE INDEX "stock_relationship_idx_object_id" on "stock_relationship" ("object_id");
CREATE INDEX "stock_relationship_idx_subject_id" on "stock_relationship" ("subject_id");
CREATE INDEX "stock_relationship_idx_type_id" on "stock_relationship" ("type_id");

;
--
-- Table: stock_relationship_cvterm
--
CREATE TABLE "stock_relationship_cvterm" (
  "stock_relationship_cvterm_id" serial NOT NULL,
  "stock_relatiohship_id" integer NOT NULL,
  "cvterm_id" integer NOT NULL,
  "pub_id" integer,
  PRIMARY KEY ("stock_relationship_cvterm_id")
);
CREATE INDEX "stock_relationship_cvterm_idx_cvterm_id" on "stock_relationship_cvterm" ("cvterm_id");
CREATE INDEX "stock_relationship_cvterm_idx_pub_id" on "stock_relationship_cvterm" ("pub_id");

;
--
-- Table: stock_relationship_pub
--
CREATE TABLE "stock_relationship_pub" (
  "stock_relationship_pub_id" serial NOT NULL,
  "stock_relationship_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("stock_relationship_pub_id"),
  CONSTRAINT "stock_relationship_pub_c1" UNIQUE ("stock_relationship_id", "pub_id")
);
CREATE INDEX "stock_relationship_pub_idx_pub_id" on "stock_relationship_pub" ("pub_id");
CREATE INDEX "stock_relationship_pub_idx_stock_relationship_id" on "stock_relationship_pub" ("stock_relationship_id");

;
--
-- Table: stockcollection
--
CREATE TABLE "stockcollection" (
  "stockcollection_id" serial NOT NULL,
  "type_id" integer NOT NULL,
  "contact_id" integer,
  "name" character varying(255),
  "uniquename" text NOT NULL,
  PRIMARY KEY ("stockcollection_id"),
  CONSTRAINT "stockcollection_c1" UNIQUE ("uniquename", "type_id")
);
CREATE INDEX "stockcollection_idx_contact_id" on "stockcollection" ("contact_id");
CREATE INDEX "stockcollection_idx_type_id" on "stockcollection" ("type_id");

;
--
-- Table: stockcollection_stock
--
CREATE TABLE "stockcollection_stock" (
  "stockcollection_stock_id" serial NOT NULL,
  "stockcollection_id" integer NOT NULL,
  "stock_id" integer NOT NULL,
  PRIMARY KEY ("stockcollection_stock_id"),
  CONSTRAINT "stockcollection_stock_c1" UNIQUE ("stockcollection_id", "stock_id")
);
CREATE INDEX "stockcollection_stock_idx_stock_id" on "stockcollection_stock" ("stock_id");
CREATE INDEX "stockcollection_stock_idx_stockcollection_id" on "stockcollection_stock" ("stockcollection_id");

;
--
-- Table: stockcollectionprop
--
CREATE TABLE "stockcollectionprop" (
  "stockcollectionprop_id" serial NOT NULL,
  "stockcollection_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("stockcollectionprop_id"),
  CONSTRAINT "stockcollectionprop_c1" UNIQUE ("stockcollection_id", "type_id", "rank")
);
CREATE INDEX "stockcollectionprop_idx_stockcollection_id" on "stockcollectionprop" ("stockcollection_id");
CREATE INDEX "stockcollectionprop_idx_type_id" on "stockcollectionprop" ("type_id");

;
--
-- Table: stockprop
--
CREATE TABLE "stockprop" (
  "stockprop_id" serial NOT NULL,
  "stock_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("stockprop_id"),
  CONSTRAINT "stockprop_c1" UNIQUE ("stock_id", "type_id", "rank")
);
CREATE INDEX "stockprop_idx_stock_id" on "stockprop" ("stock_id");
CREATE INDEX "stockprop_idx_type_id" on "stockprop" ("type_id");

;
--
-- Table: stockprop_pub
--
CREATE TABLE "stockprop_pub" (
  "stockprop_pub_id" serial NOT NULL,
  "stockprop_id" integer NOT NULL,
  "pub_id" integer NOT NULL,
  PRIMARY KEY ("stockprop_pub_id"),
  CONSTRAINT "stockprop_pub_c1" UNIQUE ("stockprop_id", "pub_id")
);
CREATE INDEX "stockprop_pub_idx_pub_id" on "stockprop_pub" ("pub_id");
CREATE INDEX "stockprop_pub_idx_stockprop_id" on "stockprop_pub" ("stockprop_id");

;
--
-- Table: study
--
CREATE TABLE "study" (
  "study_id" serial NOT NULL,
  "contact_id" integer NOT NULL,
  "pub_id" integer,
  "dbxref_id" integer,
  "name" text NOT NULL,
  "description" text,
  PRIMARY KEY ("study_id"),
  CONSTRAINT "study_c1" UNIQUE ("name")
);
CREATE INDEX "study_idx_contact_id" on "study" ("contact_id");
CREATE INDEX "study_idx_dbxref_id" on "study" ("dbxref_id");
CREATE INDEX "study_idx_pub_id" on "study" ("pub_id");

;
--
-- Table: study_assay
--
CREATE TABLE "study_assay" (
  "study_assay_id" serial NOT NULL,
  "study_id" integer NOT NULL,
  "assay_id" integer NOT NULL,
  PRIMARY KEY ("study_assay_id"),
  CONSTRAINT "study_assay_c1" UNIQUE ("study_id", "assay_id")
);
CREATE INDEX "study_assay_idx_assay_id" on "study_assay" ("assay_id");
CREATE INDEX "study_assay_idx_study_id" on "study_assay" ("study_id");

;
--
-- Table: studydesign
--
CREATE TABLE "studydesign" (
  "studydesign_id" serial NOT NULL,
  "study_id" integer NOT NULL,
  "description" text,
  PRIMARY KEY ("studydesign_id")
);
CREATE INDEX "studydesign_idx_study_id" on "studydesign" ("study_id");

;
--
-- Table: studydesignprop
--
CREATE TABLE "studydesignprop" (
  "studydesignprop_id" serial NOT NULL,
  "studydesign_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("studydesignprop_id"),
  CONSTRAINT "studydesignprop_c1" UNIQUE ("studydesign_id", "type_id", "rank")
);
CREATE INDEX "studydesignprop_idx_studydesign_id" on "studydesignprop" ("studydesign_id");
CREATE INDEX "studydesignprop_idx_type_id" on "studydesignprop" ("type_id");

;
--
-- Table: studyfactor
--
CREATE TABLE "studyfactor" (
  "studyfactor_id" serial NOT NULL,
  "studydesign_id" integer NOT NULL,
  "type_id" integer,
  "name" text NOT NULL,
  "description" text,
  PRIMARY KEY ("studyfactor_id")
);
CREATE INDEX "studyfactor_idx_studydesign_id" on "studyfactor" ("studydesign_id");
CREATE INDEX "studyfactor_idx_type_id" on "studyfactor" ("type_id");

;
--
-- Table: studyfactorvalue
--
CREATE TABLE "studyfactorvalue" (
  "studyfactorvalue_id" serial NOT NULL,
  "studyfactor_id" integer NOT NULL,
  "assay_id" integer NOT NULL,
  "factorvalue" text,
  "name" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("studyfactorvalue_id")
);
CREATE INDEX "studyfactorvalue_idx_assay_id" on "studyfactorvalue" ("assay_id");
CREATE INDEX "studyfactorvalue_idx_studyfactor_id" on "studyfactorvalue" ("studyfactor_id");

;
--
-- Table: studyprop
--
CREATE TABLE "studyprop" (
  "studyprop_id" serial NOT NULL,
  "study_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("studyprop_id"),
  CONSTRAINT "studyprop_study_id_key" UNIQUE ("study_id", "type_id", "rank")
);
CREATE INDEX "studyprop_idx_study_id" on "studyprop" ("study_id");
CREATE INDEX "studyprop_idx_type_id" on "studyprop" ("type_id");

;
--
-- Table: studyprop_feature
--
CREATE TABLE "studyprop_feature" (
  "studyprop_feature_id" serial NOT NULL,
  "studyprop_id" integer NOT NULL,
  "feature_id" integer NOT NULL,
  "type_id" integer,
  PRIMARY KEY ("studyprop_feature_id"),
  CONSTRAINT "studyprop_feature_studyprop_id_key" UNIQUE ("studyprop_id", "feature_id")
);
CREATE INDEX "studyprop_feature_idx_feature_id" on "studyprop_feature" ("feature_id");
CREATE INDEX "studyprop_feature_idx_studyprop_id" on "studyprop_feature" ("studyprop_id");
CREATE INDEX "studyprop_feature_idx_type_id" on "studyprop_feature" ("type_id");

;
--
-- Table: synonym
--
CREATE TABLE "synonym" (
  "synonym_id" serial NOT NULL,
  "name" character varying(255) NOT NULL,
  "type_id" integer NOT NULL,
  "synonym_sgml" character varying(255) NOT NULL,
  PRIMARY KEY ("synonym_id"),
  CONSTRAINT "synonym_c1" UNIQUE ("name", "type_id")
);
CREATE INDEX "synonym_idx_type_id" on "synonym" ("type_id");

;
--
-- Table: tableinfo
--
CREATE TABLE "tableinfo" (
  "tableinfo_id" serial NOT NULL,
  "name" character varying(30) NOT NULL,
  "primary_key_column" character varying(30),
  "is_view" integer DEFAULT 0 NOT NULL,
  "view_on_table_id" integer,
  "superclass_table_id" integer,
  "is_updateable" integer DEFAULT 1 NOT NULL,
  "modification_date" date DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("tableinfo_id"),
  CONSTRAINT "tableinfo_c1" UNIQUE ("name")
);

;
--
-- Table: treatment
--
CREATE TABLE "treatment" (
  "treatment_id" serial NOT NULL,
  "rank" integer DEFAULT 0 NOT NULL,
  "biomaterial_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "protocol_id" integer,
  "name" text,
  PRIMARY KEY ("treatment_id")
);
CREATE INDEX "treatment_idx_biomaterial_id" on "treatment" ("biomaterial_id");
CREATE INDEX "treatment_idx_protocol_id" on "treatment" ("protocol_id");
CREATE INDEX "treatment_idx_type_id" on "treatment" ("type_id");

;
--
-- Table: type_feature_count
--
CREATE TABLE "type_feature_count" (
  "type" character varying(1024),
  "num_features" bigint
);

;
--
-- Table: featureprop
--
CREATE TABLE "featureprop" (
  "featureprop_id" serial NOT NULL,
  "feature_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("featureprop_id"),
  CONSTRAINT "featureprop_c1" UNIQUE ("feature_id", "type_id", "rank")
);
CREATE INDEX "featureprop_idx_type_id" on "featureprop" ("type_id");
CREATE INDEX "featureprop_idx_feature_id" on "featureprop" ("feature_id");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "acquisition" ADD FOREIGN KEY ("assay_id")
  REFERENCES "assay" ("assay_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "acquisition" ADD FOREIGN KEY ("channel_id")
  REFERENCES "channel" ("channel_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "acquisition" ADD FOREIGN KEY ("protocol_id")
  REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "acquisition_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "acquisition" ("acquisition_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "acquisition_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "acquisition" ("acquisition_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "acquisition_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "acquisitionprop" ADD FOREIGN KEY ("acquisition_id")
  REFERENCES "acquisition" ("acquisition_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "acquisitionprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "analysisfeature" ADD FOREIGN KEY ("analysis_id")
  REFERENCES "analysis" ("analysis_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "analysisfeature" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "analysisfeatureprop" ADD FOREIGN KEY ("analysisfeature_id")
  REFERENCES "analysisfeature" ("analysisfeature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "analysisfeatureprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "analysisprop" ADD FOREIGN KEY ("analysis_id")
  REFERENCES "analysis" ("analysis_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "analysisprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "arraydesign" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "arraydesign" ADD FOREIGN KEY ("manufacturer_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "arraydesign" ADD FOREIGN KEY ("platformtype_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "arraydesign" ADD FOREIGN KEY ("protocol_id")
  REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "arraydesign" ADD FOREIGN KEY ("substratetype_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "arraydesignprop" ADD FOREIGN KEY ("arraydesign_id")
  REFERENCES "arraydesign" ("arraydesign_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "arraydesignprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay" ADD FOREIGN KEY ("arraydesign_id")
  REFERENCES "arraydesign" ("arraydesign_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay" ADD FOREIGN KEY ("operator_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay" ADD FOREIGN KEY ("protocol_id")
  REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay_biomaterial" ADD FOREIGN KEY ("assay_id")
  REFERENCES "assay" ("assay_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay_biomaterial" ADD FOREIGN KEY ("biomaterial_id")
  REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay_biomaterial" ADD FOREIGN KEY ("channel_id")
  REFERENCES "channel" ("channel_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay_project" ADD FOREIGN KEY ("assay_id")
  REFERENCES "assay" ("assay_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assay_project" ADD FOREIGN KEY ("project_id")
  REFERENCES "project" ("project_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assayprop" ADD FOREIGN KEY ("assay_id")
  REFERENCES "assay" ("assay_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "assayprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial" ADD FOREIGN KEY ("biosourceprovider_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial" ADD FOREIGN KEY ("taxon_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial_dbxref" ADD FOREIGN KEY ("biomaterial_id")
  REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial_treatment" ADD FOREIGN KEY ("biomaterial_id")
  REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial_treatment" ADD FOREIGN KEY ("treatment_id")
  REFERENCES "treatment" ("treatment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterial_treatment" ADD FOREIGN KEY ("unittype_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterialprop" ADD FOREIGN KEY ("biomaterial_id")
  REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "biomaterialprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line" ADD FOREIGN KEY ("organism_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_cvterm" ADD FOREIGN KEY ("cell_line_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_cvterm" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_cvtermprop" ADD FOREIGN KEY ("cell_line_cvterm_id")
  REFERENCES "cell_line_cvterm" ("cell_line_cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_cvtermprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_dbxref" ADD FOREIGN KEY ("cell_line_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_feature" ADD FOREIGN KEY ("cell_line_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_feature" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_feature" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_library" ADD FOREIGN KEY ("cell_line_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_library" ADD FOREIGN KEY ("library_id")
  REFERENCES "library" ("library_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_library" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_pub" ADD FOREIGN KEY ("cell_line_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_synonym" ADD FOREIGN KEY ("cell_line_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_synonym" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_line_synonym" ADD FOREIGN KEY ("synonym_id")
  REFERENCES "synonym" ("synonym_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_lineprop" ADD FOREIGN KEY ("cell_line_id")
  REFERENCES "cell_line" ("cell_line_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_lineprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_lineprop_pub" ADD FOREIGN KEY ("cell_lineprop_id")
  REFERENCES "cell_lineprop" ("cell_lineprop_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cell_lineprop_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "contact" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "contact_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "contact_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "contact_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "control" ADD FOREIGN KEY ("assay_id")
  REFERENCES "assay" ("assay_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "control" ADD FOREIGN KEY ("tableinfo_id")
  REFERENCES "tableinfo" ("tableinfo_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "control" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvprop" ADD FOREIGN KEY ("cv_id")
  REFERENCES "cv" ("cv_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvterm" ADD FOREIGN KEY ("cv_id")
  REFERENCES "cv" ("cv_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvterm" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvterm_dbxref" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvterm_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvterm_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvterm_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvterm_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvtermpath" ADD FOREIGN KEY ("cv_id")
  REFERENCES "cv" ("cv_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvtermpath" ADD FOREIGN KEY ("object_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvtermpath" ADD FOREIGN KEY ("subject_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvtermpath" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvtermprop" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvtermprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvtermsynonym" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "cvtermsynonym" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "dbxref" ADD FOREIGN KEY ("db_id")
  REFERENCES "db" ("db_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "dbxrefprop" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "dbxrefprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "element" ADD FOREIGN KEY ("arraydesign_id")
  REFERENCES "arraydesign" ("arraydesign_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "element" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "element" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "element" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "element_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "element" ("element_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "element_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "element" ("element_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "element_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "elementresult" ADD FOREIGN KEY ("element_id")
  REFERENCES "element" ("element_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "elementresult" ADD FOREIGN KEY ("quantification_id")
  REFERENCES "quantification" ("quantification_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "elementresult_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "elementresult" ("elementresult_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "elementresult_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "elementresult" ("elementresult_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "elementresult_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "environment_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "environment_cvterm" ADD FOREIGN KEY ("environment_id")
  REFERENCES "environment" ("environment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_cvterm" ADD FOREIGN KEY ("cvterm_type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_cvterm" ADD FOREIGN KEY ("expression_id")
  REFERENCES "expression" ("expression_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_cvtermprop" ADD FOREIGN KEY ("expression_cvterm_id")
  REFERENCES "expression_cvterm" ("expression_cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_cvtermprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_image" ADD FOREIGN KEY ("eimage_id")
  REFERENCES "eimage" ("eimage_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_image" ADD FOREIGN KEY ("expression_id")
  REFERENCES "expression" ("expression_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_pub" ADD FOREIGN KEY ("expression_id")
  REFERENCES "expression" ("expression_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expression_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expressionprop" ADD FOREIGN KEY ("expression_id")
  REFERENCES "expression" ("expression_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "expressionprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature" ADD FOREIGN KEY ("organism_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvterm" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvterm" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvterm_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvterm_dbxref" ADD FOREIGN KEY ("feature_cvterm_id")
  REFERENCES "feature_cvterm" ("feature_cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvterm_pub" ADD FOREIGN KEY ("feature_cvterm_id")
  REFERENCES "feature_cvterm" ("feature_cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvterm_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvtermprop" ADD FOREIGN KEY ("feature_cvterm_id")
  REFERENCES "feature_cvterm" ("feature_cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_cvtermprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_dbxref" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_expression" ADD FOREIGN KEY ("expression_id")
  REFERENCES "expression" ("expression_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_expression" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_expression" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_expressionprop" ADD FOREIGN KEY ("feature_expression_id")
  REFERENCES "feature_expression" ("feature_expression_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_expressionprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_genotype" ADD FOREIGN KEY ("chromosome_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_genotype" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_genotype" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_genotype" ADD FOREIGN KEY ("genotype_id")
  REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_phenotype" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_phenotype" ADD FOREIGN KEY ("phenotype_id")
  REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_pub" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_pubprop" ADD FOREIGN KEY ("feature_pub_id")
  REFERENCES "feature_pub" ("feature_pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_pubprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationship_pub" ADD FOREIGN KEY ("feature_relationship_id")
  REFERENCES "feature_relationship" ("feature_relationship_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationship_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationshipprop" ADD FOREIGN KEY ("feature_relationship_id")
  REFERENCES "feature_relationship" ("feature_relationship_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationshipprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationshipprop_pub" ADD FOREIGN KEY ("feature_relationshipprop_id")
  REFERENCES "feature_relationshipprop" ("feature_relationshipprop_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_relationshipprop_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_synonym" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_synonym" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "feature_synonym" ADD FOREIGN KEY ("synonym_id")
  REFERENCES "synonym" ("synonym_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featureloc" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featureloc" ADD FOREIGN KEY ("srcfeature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featureloc_pub" ADD FOREIGN KEY ("featureloc_id")
  REFERENCES "featureloc" ("featureloc_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featureloc_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featuremap" ADD FOREIGN KEY ("unittype_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featuremap_pub" ADD FOREIGN KEY ("featuremap_id")
  REFERENCES "featuremap" ("featuremap_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featuremap_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurepos" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurepos" ADD FOREIGN KEY ("featuremap_id")
  REFERENCES "featuremap" ("featuremap_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurepos" ADD FOREIGN KEY ("map_feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featureprop_pub" ADD FOREIGN KEY ("featureprop_id")
  REFERENCES "featureprop" ("featureprop_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featureprop_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurerange" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurerange" ADD FOREIGN KEY ("featuremap_id")
  REFERENCES "featuremap" ("featuremap_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurerange" ADD FOREIGN KEY ("leftendf_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurerange" ADD FOREIGN KEY ("leftstartf_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurerange" ADD FOREIGN KEY ("rightendf_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featurerange" ADD FOREIGN KEY ("rightstartf_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library" ADD FOREIGN KEY ("organism_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_cvterm" ADD FOREIGN KEY ("library_id")
  REFERENCES "library" ("library_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_cvterm" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_dbxref" ADD FOREIGN KEY ("library_id")
  REFERENCES "library" ("library_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_feature" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_feature" ADD FOREIGN KEY ("library_id")
  REFERENCES "library" ("library_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_pub" ADD FOREIGN KEY ("library_id")
  REFERENCES "library" ("library_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_synonym" ADD FOREIGN KEY ("library_id")
  REFERENCES "library" ("library_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_synonym" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "library_synonym" ADD FOREIGN KEY ("synonym_id")
  REFERENCES "synonym" ("synonym_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "libraryprop" ADD FOREIGN KEY ("library_id")
  REFERENCES "library" ("library_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "libraryprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "libraryprop_pub" ADD FOREIGN KEY ("libraryprop_id")
  REFERENCES "libraryprop" ("libraryprop_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "libraryprop_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "magedocumentation" ADD FOREIGN KEY ("mageml_id")
  REFERENCES "mageml" ("mageml_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "magedocumentation" ADD FOREIGN KEY ("tableinfo_id")
  REFERENCES "tableinfo" ("tableinfo_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment" ADD FOREIGN KEY ("nd_geolocation_id")
  REFERENCES "nd_geolocation" ("nd_geolocation_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_contact" ADD FOREIGN KEY ("contact_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_contact" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_dbxref" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_genotype" ADD FOREIGN KEY ("genotype_id")
  REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_genotype" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_phenotype" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_phenotype" ADD FOREIGN KEY ("phenotype_id")
  REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_project" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_project" ADD FOREIGN KEY ("project_id")
  REFERENCES "project" ("project_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_protocol" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_protocol" ADD FOREIGN KEY ("nd_protocol_id")
  REFERENCES "nd_protocol" ("nd_protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_pub" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_stock" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_stock" ADD FOREIGN KEY ("stock_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_stock" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_stock_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_stock_dbxref" ADD FOREIGN KEY ("nd_experiment_stock_id")
  REFERENCES "nd_experiment_stock" ("nd_experiment_stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_stockprop" ADD FOREIGN KEY ("nd_experiment_stock_id")
  REFERENCES "nd_experiment_stock" ("nd_experiment_stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experiment_stockprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experimentprop" ADD FOREIGN KEY ("nd_experiment_id")
  REFERENCES "nd_experiment" ("nd_experiment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_experimentprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_geolocationprop" ADD FOREIGN KEY ("nd_geolocation_id")
  REFERENCES "nd_geolocation" ("nd_geolocation_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_geolocationprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_protocol_reagent" ADD FOREIGN KEY ("nd_protocol_id")
  REFERENCES "nd_protocol" ("nd_protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_protocol_reagent" ADD FOREIGN KEY ("reagent_id")
  REFERENCES "nd_reagent" ("nd_reagent_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_protocol_reagent" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_protocolprop" ADD FOREIGN KEY ("nd_protocol_id")
  REFERENCES "nd_protocol" ("nd_protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_protocolprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_reagent" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_reagent_relationship" ADD FOREIGN KEY ("object_reagent_id")
  REFERENCES "nd_reagent" ("nd_reagent_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_reagent_relationship" ADD FOREIGN KEY ("subject_reagent_id")
  REFERENCES "nd_reagent" ("nd_reagent_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_reagent_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_reagentprop" ADD FOREIGN KEY ("nd_reagent_id")
  REFERENCES "nd_reagent" ("nd_reagent_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "nd_reagentprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "organism_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "organism_dbxref" ADD FOREIGN KEY ("organism_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "organismprop" ADD FOREIGN KEY ("organism_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "organismprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phendesc" ADD FOREIGN KEY ("environment_id")
  REFERENCES "environment" ("environment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phendesc" ADD FOREIGN KEY ("genotype_id")
  REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phendesc" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phendesc" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype" ADD FOREIGN KEY ("assay_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype" ADD FOREIGN KEY ("attr_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype" ADD FOREIGN KEY ("cvalue_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype" ADD FOREIGN KEY ("observable_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison" ADD FOREIGN KEY ("environment1_id")
  REFERENCES "environment" ("environment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison" ADD FOREIGN KEY ("environment2_id")
  REFERENCES "environment" ("environment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison" ADD FOREIGN KEY ("genotype1_id")
  REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison" ADD FOREIGN KEY ("genotype2_id")
  REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison" ADD FOREIGN KEY ("organism_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison" ADD FOREIGN KEY ("phenotype1_id")
  REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison" ADD FOREIGN KEY ("phenotype2_id")
  REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison_cvterm" ADD FOREIGN KEY ("phenotype_comparison_id")
  REFERENCES "phenotype_comparison" ("phenotype_comparison_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_comparison_cvterm" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenotype_cvterm" ADD FOREIGN KEY ("phenotype_id")
  REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenstatement" ADD FOREIGN KEY ("environment_id")
  REFERENCES "environment" ("environment_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenstatement" ADD FOREIGN KEY ("genotype_id")
  REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenstatement" ADD FOREIGN KEY ("phenotype_id")
  REFERENCES "phenotype" ("phenotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenstatement" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phenstatement" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode" ADD FOREIGN KEY ("parent_phylonode_id")
  REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode" ADD FOREIGN KEY ("phylotree_id")
  REFERENCES "phylotree" ("phylotree_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_dbxref" ADD FOREIGN KEY ("phylonode_id")
  REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_organism" ADD FOREIGN KEY ("organism_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_organism" ADD FOREIGN KEY ("phylonode_id")
  REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_pub" ADD FOREIGN KEY ("phylonode_id")
  REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_relationship" ADD FOREIGN KEY ("phylotree_id")
  REFERENCES "phylotree" ("phylotree_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonode_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonodeprop" ADD FOREIGN KEY ("phylonode_id")
  REFERENCES "phylonode" ("phylonode_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylonodeprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylotree" ADD FOREIGN KEY ("analysis_id")
  REFERENCES "analysis" ("analysis_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylotree" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylotree" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylotree_pub" ADD FOREIGN KEY ("phylotree_id")
  REFERENCES "phylotree" ("phylotree_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "phylotree_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "project_contact" ADD FOREIGN KEY ("contact_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "project_contact" ADD FOREIGN KEY ("project_id")
  REFERENCES "project" ("project_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "project_pub" ADD FOREIGN KEY ("project_id")
  REFERENCES "project" ("project_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "project_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "project_relationship" ADD FOREIGN KEY ("object_project_id")
  REFERENCES "project" ("project_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "project_relationship" ADD FOREIGN KEY ("subject_project_id")
  REFERENCES "project" ("project_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "project_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "projectprop" ADD FOREIGN KEY ("project_id")
  REFERENCES "project" ("project_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "projectprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "protocol" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "protocol" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "protocol" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "protocolparam" ADD FOREIGN KEY ("datatype_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "protocolparam" ADD FOREIGN KEY ("protocol_id")
  REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "protocolparam" ADD FOREIGN KEY ("unittype_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pub" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pub_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pub_dbxref" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pub_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pub_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pub_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pubauthor" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pubprop" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "pubprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantification" ADD FOREIGN KEY ("acquisition_id")
  REFERENCES "acquisition" ("acquisition_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantification" ADD FOREIGN KEY ("analysis_id")
  REFERENCES "analysis" ("analysis_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantification" ADD FOREIGN KEY ("operator_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantification" ADD FOREIGN KEY ("protocol_id")
  REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantification_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "quantification" ("quantification_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantification_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "quantification" ("quantification_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantification_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantificationprop" ADD FOREIGN KEY ("quantification_id")
  REFERENCES "quantification" ("quantification_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "quantificationprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock" ADD FOREIGN KEY ("organism_id")
  REFERENCES "organism" ("organism_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_cvterm" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_cvterm" ADD FOREIGN KEY ("stock_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_dbxref" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_dbxref" ADD FOREIGN KEY ("stock_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_dbxrefprop" ADD FOREIGN KEY ("stock_dbxref_id")
  REFERENCES "stock_dbxref" ("stock_dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_dbxrefprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_genotype" ADD FOREIGN KEY ("genotype_id")
  REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_genotype" ADD FOREIGN KEY ("stock_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_pub" ADD FOREIGN KEY ("stock_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_relationship" ADD FOREIGN KEY ("object_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_relationship" ADD FOREIGN KEY ("subject_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_relationship" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_relationship_cvterm" ADD FOREIGN KEY ("cvterm_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_relationship_cvterm" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_relationship_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_relationship_pub" ADD FOREIGN KEY ("stock_relationship_id")
  REFERENCES "stock_relationship" ("stock_relationship_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockcollection" ADD FOREIGN KEY ("contact_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockcollection" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockcollection_stock" ADD FOREIGN KEY ("stock_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockcollection_stock" ADD FOREIGN KEY ("stockcollection_id")
  REFERENCES "stockcollection" ("stockcollection_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockcollectionprop" ADD FOREIGN KEY ("stockcollection_id")
  REFERENCES "stockcollection" ("stockcollection_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockcollectionprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockprop" ADD FOREIGN KEY ("stock_id")
  REFERENCES "stock" ("stock_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockprop_pub" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stockprop_pub" ADD FOREIGN KEY ("stockprop_id")
  REFERENCES "stockprop" ("stockprop_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "study" ADD FOREIGN KEY ("contact_id")
  REFERENCES "contact" ("contact_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "study" ADD FOREIGN KEY ("dbxref_id")
  REFERENCES "dbxref" ("dbxref_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "study" ADD FOREIGN KEY ("pub_id")
  REFERENCES "pub" ("pub_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "study_assay" ADD FOREIGN KEY ("assay_id")
  REFERENCES "assay" ("assay_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "study_assay" ADD FOREIGN KEY ("study_id")
  REFERENCES "study" ("study_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studydesign" ADD FOREIGN KEY ("study_id")
  REFERENCES "study" ("study_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studydesignprop" ADD FOREIGN KEY ("studydesign_id")
  REFERENCES "studydesign" ("studydesign_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studydesignprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyfactor" ADD FOREIGN KEY ("studydesign_id")
  REFERENCES "studydesign" ("studydesign_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyfactor" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyfactorvalue" ADD FOREIGN KEY ("assay_id")
  REFERENCES "assay" ("assay_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyfactorvalue" ADD FOREIGN KEY ("studyfactor_id")
  REFERENCES "studyfactor" ("studyfactor_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyprop" ADD FOREIGN KEY ("study_id")
  REFERENCES "study" ("study_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyprop_feature" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyprop_feature" ADD FOREIGN KEY ("studyprop_id")
  REFERENCES "studyprop" ("studyprop_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "studyprop_feature" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "synonym" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "treatment" ADD FOREIGN KEY ("biomaterial_id")
  REFERENCES "biomaterial" ("biomaterial_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "treatment" ADD FOREIGN KEY ("protocol_id")
  REFERENCES "protocol" ("protocol_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "treatment" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "featureprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") DEFERRABLE;

;
ALTER TABLE "featureprop" ADD FOREIGN KEY ("feature_id")
  REFERENCES "feature" ("feature_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

