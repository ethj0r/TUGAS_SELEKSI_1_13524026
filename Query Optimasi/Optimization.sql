-- output/SS hasil query optimization ini ada di ./screenshot/optimization.png

-- Q1: Company by batch_id
-- BEFORE (Seq Scan on company)
EXPLAIN ANALYZE SELECT slug, name FROM Company WHERE batch_id = 'Wi26';
CREATE INDEX IF NOT EXISTS IdxCompanyBatch ON Company(batch_id);
ANALYZE Company;
-- AFTER (Bitmap Index Scan on idxcompanybatch)
EXPLAIN ANALYZE SELECT slug, name FROM Company WHERE batch_id = 'Wi26';



-- Q2: Company by founded_year (range)
-- BEFORE (Seq Scan on company)
EXPLAIN ANALYZE SELECT slug, name FROM Company WHERE founded_year BETWEEN 2010 AND 2015;
CREATE INDEX IF NOT EXISTS IdxCompanyFounded ON Company(founded_year);
ANALYZE Company;
-- AFTER (Bitmap/Index Scan on idxcompanyfounded)
EXPLAIN ANALYZE SELECT slug, name FROM Company WHERE founded_year BETWEEN 2010 AND 2015;



-- Q3: Company by status_id+team_size (composite)
-- BEFORE (Seq Scan on company)
EXPLAIN ANALYZE SELECT slug, name FROM Company WHERE status_id = 1 AND team_size > 100;
CREATE INDEX IF NOT EXISTS IdxCompanyStatusTeam ON Company(status_id, team_size);
ANALYZE Company;
-- AFTER (Bitmap Index Scan on idxcompanystatusteam)
EXPLAIN ANALYZE SELECT slug, name FROM Company WHERE status_id = 1 AND team_size > 100;



-- PROOF OUTPUT IDENTIK (hash BEFORE == AFTER)
SELECT 'Q1' AS q, COUNT(*), MD5(STRING_AGG(slug, ',' ORDER BY slug)) AS output_hash
FROM Company WHERE batch_id = 'Wi26'
UNION ALL
SELECT 'Q2', COUNT(*), MD5(STRING_AGG(slug, ',' ORDER BY slug))
FROM Company WHERE founded_year BETWEEN 2010 AND 2015
UNION ALL
SELECT 'Q3', COUNT(*), MD5(STRING_AGG(slug, ',' ORDER BY slug))
FROM Company WHERE status_id = 1 AND team_size > 100;