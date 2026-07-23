-- intinya rata-rata team_size & company_age per tahun batch
SELECT b.year, COUNT(*) AS n_company,
       ROUND(AVG(fc.team_size),1) AS avg_team,
       ROUND(AVG(fc.company_age),1) AS avg_age
FROM FactCompany fc JOIN DimBatch b ON fc.batch_key = b.batch_key
GROUP BY b.year
ORDER BY b.year DESC;


-- distribusi status company per negara
SELECT l.country, s.status_name, COUNT(*) AS n
FROM FactCompany fc
JOIN DimLocation l ON fc.location_key = l.location_key
JOIN DimStatus s ON fc.status_key = s.status_key
WHERE l.country IN ('USA','United Kingdom','Canada')
GROUP BY l.country, s.status_name
ORDER BY l.country, n DESC;


-- total akun social per platform, grouped per status company
SELECT s.status_name,
       COUNT(*) AS n_founder,
       SUM(ff.linkedin_count) AS linkedin,
       SUM(ff.twitter_count) AS twitter,
       SUM(ff.github_count) AS github
FROM FactFounder ff JOIN DimStatus s ON ff.status_key = s.status_key
GROUP BY s.status_name
ORDER BY n_founder DESC;


-- industri terpopuler untuk company batch tahun 2026
SELECT i.industry_name, COUNT(*) AS n_company
FROM FactCompany fc
JOIN DimBatch b ON fc.batch_key = b.batch_key
JOIN BridgeCompanyIndustry br ON br.company_key = fc.company_key
JOIN DimIndustry i ON i.industry_key = br.industry_key
WHERE b.year = 2026
GROUP BY i.industry_name
ORDER BY n_company DESC
LIMIT 10;


-- compare measure dari dua fact table berbeda
SELECT s.status_name,
       ROUND(AVG(fc.founder_count),2) AS avg_founder_per_company,
       (SELECT ROUND(AVG(ff.social_count),2)
        FROM FactFounder ff WHERE ff.status_key = s.status_key) AS avg_social_per_founder
FROM FactCompany fc JOIN DimStatus s ON fc.status_key = s.status_key
GROUP BY s.status_name, s.status_key
ORDER BY avg_founder_per_company DESC;
