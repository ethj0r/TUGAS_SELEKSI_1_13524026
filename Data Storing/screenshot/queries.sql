-- Company pada batch tertentu + status (FK Company->Batch, JOIN CompanyStatus)
-- FK batch_id kepakai + status dinormalisasi ke tabel terpisah
SELECT c.slug, c.name, s.status_name, c.team_size
FROM Company c
JOIN CompanyStatus s ON c.status_id = s.status_id
WHERE c.batch_id = 'Wi26'
ORDER BY c.name
LIMIT 10;

-- Company di kota tertentu (JOIN Company x Location, FK location_id)
SELECT c.slug, c.name, l.city, l.state, l.country
FROM Company c
JOIN Location l ON c.location_id = l.location_id
WHERE l.city = 'San Francisco'
LIMIT 10;

-- Derived attribute company_age (kolom yang diisi trigger)
--trigger disni jalan (company_age = tahun_now-founded_year)
SELECT slug, name, founded_year, company_age
FROM Company
WHERE company_age IS NOT NULL AND founded_year < 2015
ORDER BY founded_year
LIMIT 10;

-- M:N Company <-> Industry pada industri tertentu (via CompanyIndustry)
-- relasi M:N lewat tabel penghubung
SELECT c.name AS company, i.name AS industry
FROM Company c
JOIN CompanyIndustry ci ON c.slug = ci.company_slug
JOIN Industry i ON ci.industry_id = i.industry_id
WHERE i.name = 'Analytics'
LIMIT 10;


--ISA subtype company yang berstatus Public (via tabel PublicCompany)
--specialization/ISA. subtype disimpan di tabel terpisah
SELECT c.name, s.status_name
FROM Company c
JOIN PublicCompany p ON c.slug = p.slug
JOIN CompanyStatus s ON c.status_id = s.status_id
WHERE s.status_name = 'Public'
LIMIT 10;

-- Weak entity FounderSocial+VIEW platform (derived dari url)
SELECT f.name AS founder, v.platform, v.url
FROM Founder f
JOIN FounderSocialView v ON f.founder_id = v.founder_id
WHERE v.platform = 'GitHub'
LIMIT 10;


-- Bukti scheduling, Company linked ke ke ScrapeSession
-- FK session_id + timestamp ekstraksi tercatat per sesssionnya
SELECT ss.session_id, ss.started_at, ss.session_number, COUNT(c.slug) AS company_count
FROM ScrapeSession ss
JOIN Company c ON c.session_id = ss.session_id
WHERE ss.session_number = 1
GROUP BY ss.session_id, ss.started_at, ss.session_number;
