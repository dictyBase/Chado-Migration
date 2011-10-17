-- Convert schema '/Users/sid/Proj/Modware-Chado-Migration/db/_source/deploy/0.08002/001-auto.yml' to '/Users/sid/Proj/Modware-Chado-Migration/db/_source/deploy/0.08100/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "stock_cvtermprop" (
  "stock_cvtermprop_id" serial NOT NULL,
  "stock_cvterm_id" integer NOT NULL,
  "type_id" integer NOT NULL,
  "value" text,
  "rank" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("stock_cvtermprop_id"),
  CONSTRAINT "stock_cvtermprop_c1" UNIQUE ("stock_cvterm_id", "type_id", "rank")
);
CREATE INDEX "stock_cvtermprop_idx_stock_cvterm_id" on "stock_cvtermprop" ("stock_cvterm_id");
CREATE INDEX "stock_cvtermprop_idx_type_id" on "stock_cvtermprop" ("type_id");

;
ALTER TABLE "stock_cvtermprop" ADD FOREIGN KEY ("stock_cvterm_id")
  REFERENCES "stock_cvterm" ("stock_cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "stock_cvtermprop" ADD FOREIGN KEY ("type_id")
  REFERENCES "cvterm" ("cvterm_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

