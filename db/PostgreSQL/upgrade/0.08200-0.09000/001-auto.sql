-- Convert schema '/Users/sid/Proj/Modware-Chado-Migration/db/_source/deploy/0.08200/001-auto.yml' to '/Users/sid/Proj/Modware-Chado-Migration/db/_source/deploy/0.09000/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "genotypeprop" (
  "genotypeprop_id" serial NOT NULL,
  "genotype_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("genotypeprop_id"),
  CONSTRAINT "genotypeprop_c1" UNIQUE ("genotype_id", "type_id", "rank")
);
CREATE INDEX "genotypeprop_idx_genotype_id" on "genotypeprop" ("genotype_id");
CREATE INDEX "genotypeprop_idx_type_id" on "genotypeprop" ("type_id");

;
ALTER TABLE "genotypeprop" ADD FOREIGN KEY ("genotype_id")
  REFERENCES "genotype" ("genotype_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "genotypeprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

