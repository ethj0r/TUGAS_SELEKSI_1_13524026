DROP TABLE IF EXISTS BridgeCompanyIndustry CASCADE;
DROP TABLE IF EXISTS FactFounder CASCADE;
DROP TABLE IF EXISTS FactCompany CASCADE;
DROP TABLE IF EXISTS DimIndustry CASCADE;
DROP TABLE IF EXISTS DimStatus CASCADE;
DROP TABLE IF EXISTS DimLocation CASCADE;
DROP TABLE IF EXISTS DimBatch CASCADE;


-- DIMENSIONS (shared antar kedua fact)
-- dimensi waktu versi YC (cohort). quarter diturunkan dari season.
CREATE TABLE DimBatch (
    batch_key SERIAL PRIMARY KEY,
    batch_id VARCHAR(6) NOT NULL UNIQUE,
    season VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    quarter CHAR(2) NOT NULL
);

CREATE TABLE DimLocation (
    location_key SERIAL PRIMARY KEY,
    city VARCHAR(80),
    state VARCHAR(80),
    country VARCHAR(80)
);

CREATE TABLE DimStatus (
    status_key SERIAL PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE DimIndustry (
    industry_key SERIAL PRIMARY KEY,
    industry_name VARCHAR(80) NOT NULL UNIQUE
);


-- grain: 1 baris per company
-- Measures:team_size, company_age, founder_count, industry_count.
CREATE TABLE FactCompany (
    company_key SERIAL PRIMARY KEY,
    slug VARCHAR(60) NOT NULL UNIQUE,
    batch_key INT,
    location_key INT,
    status_key INT NOT NULL,
    team_size INT,
    company_age INT,
    founder_count INT NOT NULL,
    industry_count INT NOT NULL,
    CONSTRAINT FK_FC_Batch FOREIGN KEY (batch_key) REFERENCES DimBatch(batch_key),
    CONSTRAINT FK_FC_Location FOREIGN KEY (location_key) REFERENCES DimLocation(location_key),
    CONSTRAINT FK_FC_Status FOREIGN KEY (status_key) REFERENCES DimStatus(status_key)
);


-- grain: 1 baris per founder
-- Measures: social_count+breakdown per platform
CREATE TABLE FactFounder (
    founder_key SERIAL PRIMARY KEY,
    founder_name VARCHAR(80) NOT NULL,
    company_slug VARCHAR(60) NOT NULL,
    batch_key INT,
    location_key INT,
    status_key INT NOT NULL,
    social_count INT NOT NULL,
    linkedin_count INT NOT NULL,
    twitter_count INT NOT NULL,
    github_count INT NOT NULL,
    CONSTRAINT FK_FF_Batch FOREIGN KEY (batch_key) REFERENCES DimBatch(batch_key),
    CONSTRAINT FK_FF_Location FOREIGN KEY (location_key) REFERENCES DimLocation(location_key),
    CONSTRAINT FK_FF_Status FOREIGN KEY (status_key) REFERENCES DimStatus(status_key)
);


-- FactCompany bridge DimIndustry (M:N)
-- Company bisa banyak industri shg tak muat jadi FK tunggal di fact, pakai bridge
CREATE TABLE BridgeCompanyIndustry (
    company_key INT NOT NULL,
    industry_key INT NOT NULL,
    PRIMARY KEY (company_key, industry_key),
    CONSTRAINT FK_BR_Company FOREIGN KEY (company_key) REFERENCES FactCompany(company_key) ON DELETE CASCADE,
    CONSTRAINT FK_BR_Industry FOREIGN KEY (industry_key) REFERENCES DimIndustry(industry_key)
);
