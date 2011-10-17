-- Convert schema '/Users/sid/Proj/Modware-Chado-Migration/db/_source/deploy/0.08200/001-auto.yml' to '/Users/sid/Proj/Modware-Chado-Migration/db/_source/deploy/0.09000/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE genotypeprop (
  genotypeprop_id INTEGER PRIMARY KEY NOT NULL,
  genotype_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);

;
CREATE INDEX genotypeprop_idx_genotype_id ON genotypeprop (genotype_id);

;
CREATE INDEX genotypeprop_idx_type_id ON genotypeprop (type_id);

;
CREATE UNIQUE INDEX genotypeprop_c1 ON genotypeprop (genotype_id, type_id, rank);

;

COMMIT;

