DROP INDEX IF EXISTS IdxCompanyName;
DROP INDEX IF EXISTS IdxFounderName;
DROP INDEX IF EXISTS IdxSocialUrl;


-- Q1: Company by name (point lookup)
-- SEBELUM (Seq Scan on company):
EXPLAIN ANALYZE SELECT slug FROM Company WHERE name = 'Stripe';
CREATE INDEX IdxCompanyName ON Company(name);
ANALYZE Company;
-- SESUDAH (Index Scan using idxcompanyname):
EXPLAIN ANALYZE SELECT slug FROM Company WHERE name = 'Stripe';


-- Q2: Founder by name (point lookup)
-- SEBELUM (Seq Scan on founder):
EXPLAIN ANALYZE SELECT company_slug FROM Founder WHERE name = 'Patrick Collison';
CREATE INDEX IdxFounderName ON Founder(name);
ANALYZE Founder;
-- SESUDAH (Index Scan using idxfoundername):
EXPLAIN ANALYZE SELECT company_slug FROM Founder WHERE name = 'Patrick Collison';


-- Q3: FounderSocial by url (point lookup)
-- SEBELUM (Seq Scan on foundersocial):
EXPLAIN ANALYZE SELECT founder_id FROM FounderSocial WHERE url = 'https://github.com/ray-project/ray';
CREATE INDEX IdxSocialUrl ON FounderSocial(url);
ANALYZE FounderSocial;
-- SESUDAH (Index Scan using idxsocialurl):
EXPLAIN ANALYZE SELECT founder_id FROM FounderSocial WHERE url = 'https://github.com/ray-project/ray';


-- hash sebelum == sesudah
SELECT 'Q1' AS q, COUNT(*), MD5(COALESCE(STRING_AGG(slug, ',' ORDER BY slug), '')) AS output_hash
FROM Company WHERE name = 'Stripe'
UNION ALL
SELECT 'Q2', COUNT(*), MD5(COALESCE(STRING_AGG(company_slug, ',' ORDER BY company_slug), ''))
FROM Founder WHERE name = 'Patrick Collison'
UNION ALL
SELECT 'Q3', COUNT(*), MD5(COALESCE(STRING_AGG(founder_id::text, ',' ORDER BY founder_id), ''))
FROM FounderSocial WHERE url = 'https://github.com/ray-project/ray';