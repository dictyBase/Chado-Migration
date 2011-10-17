-- Convert schema '/Users/sid/Proj/Modware-Chado-Migration/db/_source/deploy/0.08002/001-auto.yml' to '/Users/sid/Proj/Modware-Chado-Migration/db/_source/deploy/0.08100/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE stock_cvtermprop (
  stock_cvtermprop_id INTEGER PRIMARY KEY NOT NULL,
  stock_cvterm_id integer NOT NULL,
  type_id integer NOT NULL,
  value text,
  rank integer NOT NULL DEFAULT 0
);

;
CREATE INDEX stock_cvtermprop_idx_stock_cvterm_id ON stock_cvtermprop (stock_cvterm_id);

;
CREATE INDEX stock_cvtermprop_idx_type_id ON stock_cvtermprop (type_id);

;
CREATE UNIQUE INDEX stock_cvtermprop_c1 ON stock_cvtermprop (stock_cvterm_id, type_id, rank);

;

COMMIT;

