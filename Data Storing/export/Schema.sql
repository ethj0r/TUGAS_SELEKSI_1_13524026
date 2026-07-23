-- Relational Schema dari The Y Combinator Startup Directory
--
-- What already implemented
--   - Tabel core (diisi seed hasil scraping)
--   - Subtipe ISA Company (disjoint + total) — diisi seed
--   - Constraints: PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE
--   - TRIGGER validasi status vs subtipe, auto derived age
--
-- Buat urutan CREATE mengikuti dependency FK. Drop first agar idempotent

DROP VIEW IF EXISTS FounderSocialView CASCADE;
DROP TABLE IF EXISTS Acquisition CASCADE;
DROP TABLE IF EXISTS Investment CASCADE;
DROP TABLE IF EXISTS Investor CASCADE;
DROP TABLE IF EXISTS FundingRound CASCADE;
DROP TABLE IF EXISTS InactiveCompany CASCADE;
DROP TABLE IF EXISTS PublicCompany CASCADE;
DROP TABLE IF EXISTS AcquiredCompany CASCADE;
DROP TABLE IF EXISTS ActiveCompany CASCADE;
DROP TABLE IF EXISTS FounderSocial CASCADE;
DROP TABLE IF EXISTS Founder CASCADE;
DROP TABLE IF EXISTS CompanyIndustry CASCADE;
DROP TABLE IF EXISTS Company CASCADE;
DROP TABLE IF EXISTS ScrapeSession CASCADE;
DROP TABLE IF EXISTS CompanyStatus CASCADE;
DROP TABLE IF EXISTS Industry CASCADE;
DROP TABLE IF EXISTS Batch CASCADE;
DROP TABLE IF EXISTS Location CASCADE;


-- CORE TABLES (diisi seed)
-- Location: hasil normalisasi city/state/country dari company cards (90 kombinasi uniqe)
-- UQ_Location pakai COALESCE ke '' karena UNIQUE(city,state,country) biasa TIDAK
-- menangkap duplikat saat state/country NULL (SQL: tiap NULL dianggap beda dari NULL lain)
CREATE TABLE Location (
    location_id SERIAL PRIMARY KEY,
    city VARCHAR(80) NOT NULL,
    state VARCHAR(80),
    country VARCHAR(80)
);
CREATE UNIQUE INDEX UQ_Location ON Location (city, COALESCE(state, ''), COALESCE(country, ''));

-- Batch: kode angkatan YC, mis. 'W09', 'Sp26'.
CREATE TABLE Batch (
    batch_id VARCHAR(6) PRIMARY KEY,
    season VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    CONSTRAINT CK_Batch_Season CHECK (season IN ('Winter', 'Spring', 'Summer', 'Fall')),
    CONSTRAINT CK_Batch_Year CHECK (year BETWEEN 2005 AND 2100)
);

-- Industry: daftar referensi industri (59 vals). SERIAL (bukan ID dari JSON) supaya
-- ID stabil across run dan Preprocess.py re-assign industry_id dari 1 tiap kali run,
-- jadi upsert harus resolve by name, bukan raw ID dari file
CREATE TABLE Industry (
    industry_id SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE
);

-- CompanyStatus: val status jadi diskriminator spesialisasi Company
CREATE TABLE CompanyStatus (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL UNIQUE,
    CONSTRAINT CK_Status CHECK (status_name IN ('Active', 'Acquired', 'Public', 'Inactive'))
);

-- ScrapeSession: utilities buat automated scheduling
CREATE TABLE ScrapeSession (
    session_id SERIAL PRIMARY KEY,
    started_at TIMESTAMP NOT NULL DEFAULT NOW(),
    session_number INT NOT NULL
);

-- Company: main entities. company_age ga disimpan sebagai kolom input karena udah diisi
-- oleh trigger sebagai atribut dervied dari founded_year.
-- session_id: FK ke ScrapeSession, reduksi dari relationship <scraped_in> kalo di erdnya
CREATE TABLE Company (
    slug VARCHAR(60) PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    one_liner VARCHAR(255),
    long_description TEXT,
    website VARCHAR(300),
    team_size INT,
    founded_year INT,
    company_age INT, -- derived filled by trigger nanti
    batch_id VARCHAR(6),
    location_id INT,
    status_id INT NOT NULL,
    session_id INT,
    CONSTRAINT FK_Company_Batch FOREIGN KEY (batch_id) REFERENCES Batch(batch_id),
    CONSTRAINT FK_Company_Location FOREIGN KEY (location_id) REFERENCES Location(location_id),
    CONSTRAINT FK_Company_Status FOREIGN KEY (status_id) REFERENCES CompanyStatus(status_id),
    CONSTRAINT FK_Company_Session FOREIGN KEY (session_id) REFERENCES ScrapeSession(session_id),
    CONSTRAINT CK_Company_TeamSize CHECK (team_size IS NULL OR team_size >= 0),
    CONSTRAINT CK_Company_Founded CHECK (founded_year IS NULL OR founded_year BETWEEN 1900 AND 2100)
);

-- CompanyIndustry: relasi M:N Company <-> Industry, PK komposit
CREATE TABLE CompanyIndustry (
    company_slug VARCHAR(60) NOT NULL,
    industry_id INT NOT NULL,
    CONSTRAINT PK_CompanyIndustry PRIMARY KEY (company_slug, industry_id),
    CONSTRAINT FK_CI_Company FOREIGN KEY (company_slug) REFERENCES Company(slug) ON DELETE CASCADE,
    CONSTRAINT FK_CI_Industry FOREIGN KEY (industry_id) REFERENCES Industry(industry_id)
);

-- Founder: 1:N dari Company. UQ_Founder_Identity dipakai as target
-- (sumber scraping tak punya ID founder natural; (company_slug, name) dipakai sbg identitas praktis).
CREATE TABLE Founder (
    founder_id SERIAL PRIMARY KEY,
    company_slug VARCHAR(60) NOT NULL,
    name VARCHAR(80) NOT NULL,
    CONSTRAINT FK_Founder_Company FOREIGN KEY (company_slug) REFERENCES Company(slug) ON DELETE CASCADE,
    CONSTRAINT UQ_Founder_Identity UNIQUE (company_slug, name)
);

-- FounderSocial: WEAK ENTITY
-- Ga punya PK sendiri jadi diidentifikasi oleh founder+url as discriminator
-- Author note terkait BCNF: colm "platform" ga disimpan karena url -> platform (platform
-- sepenuhnya turunan dari domain url). Menyimpannya melanggar BCNF (url bukan superkey)
-- Platform disajikan lewat VIEW FounderSocialView di bawah.
CREATE TABLE FounderSocial (
    founder_id INT NOT NULL,
    url VARCHAR(300) NOT NULL,
    CONSTRAINT PK_FounderSocial PRIMARY KEY (founder_id, url),
    CONSTRAINT FK_Social_Founder FOREIGN KEY (founder_id) REFERENCES Founder(founder_id) ON DELETE CASCADE
);

-- VIEW platform as atribut turunan dari domain url, tanpa menyimpannya
-- basically buat jaga FounderSocial di atas tetap BCNF
CREATE OR REPLACE VIEW FounderSocialView AS
SELECT
    founder_id,
    url,
    CASE
        WHEN url ILIKE '%linkedin.com%' THEN 'LinkedIn'
        WHEN url ILIKE '%twitter.com%' OR url ILIKE '%x.com%' THEN 'Twitter/X'
        WHEN url ILIKE '%github.com%' THEN 'GitHub'
        ELSE 'Other'
    END AS platform
FROM FounderSocial;




--SUBTIPE ISA COMPANY (disjoint+total)
CREATE TABLE ActiveCompany (
    slug VARCHAR(60) PRIMARY KEY,
    CONSTRAINT FK_Active_Company FOREIGN KEY (slug) REFERENCES Company(slug) ON DELETE CASCADE
);

CREATE TABLE AcquiredCompany (
    slug VARCHAR(60) PRIMARY KEY,
    acquisition_date DATE, -- empty
    CONSTRAINT FK_Acquired_Company FOREIGN KEY (slug) REFERENCES Company(slug) ON DELETE CASCADE
);

CREATE TABLE PublicCompany (
    slug VARCHAR(60) PRIMARY KEY,
    ticker VARCHAR(10), --empty
    ipo_date DATE,--empty
    CONSTRAINT FK_Public_Company FOREIGN KEY (slug) REFERENCES Company(slug) ON DELETE CASCADE
);

CREATE TABLE InactiveCompany (
    slug VARCHAR(60) PRIMARY KEY,
    CONSTRAINT FK_Inactive_Company FOREIGN KEY (slug) REFERENCES Company(slug) ON DELETE CASCADE
);


-- TABEL TAMBAHAN
-- Author note: senagja dibuat dan dibiarkan kosong untuk memperindah dan memperluas domain
-- FundingRound: 1:N dari Company.
CREATE TABLE FundingRound (
    round_id SERIAL PRIMARY KEY,
    company_slug VARCHAR(60) NOT NULL,
    round_type VARCHAR(20),
    amount_usd BIGINT,
    round_date DATE,
    CONSTRAINT FK_Round_Company FOREIGN KEY (company_slug) REFERENCES Company(slug) ON DELETE CASCADE,
    CONSTRAINT CK_Round_Amount CHECK (amount_usd IS NULL OR amount_usd >= 0)
);

CREATE TABLE Investor (
    investor_id SERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL
);

-- Investment: AGGREGATION
-- connect agregat (Company x FundingRound) ke Investor
CREATE TABLE Investment (
    investment_id SERIAL PRIMARY KEY,
    round_id INT NOT NULL,
    investor_id INT NOT NULL,
    contribution_usd BIGINT,
    CONSTRAINT FK_Inv_Round FOREIGN KEY (round_id) REFERENCES FundingRound(round_id) ON DELETE CASCADE,
    CONSTRAINT FK_Inv_Investor FOREIGN KEY (investor_id) REFERENCES Investor(investor_id),
    CONSTRAINT UQ_Investment UNIQUE (round_id, investor_id)
);

-- RELASI REKURSIF Company -> Company (role acquirer/acquired).
CREATE TABLE Acquisition (
    acquisition_id SERIAL PRIMARY KEY,
    acquirer_slug VARCHAR(60) NOT NULL,
    acquired_slug VARCHAR(60) NOT NULL,
    acquisition_date DATE,
    CONSTRAINT FK_Acq_Acquirer FOREIGN KEY (acquirer_slug) REFERENCES Company(slug),
    CONSTRAINT FK_Acq_Acquired FOREIGN KEY (acquired_slug) REFERENCES Company(slug),
    CONSTRAINT CK_Acq_NotSelf CHECK (acquirer_slug <> acquired_slug)
);


-- TRIGGERSSS

-- Trigger 1: fill company_age sebagai atribut derived dari founded_year
-- setiap kali row Company di-INSERT/UPDATE -> konsistensi derived attribute
CREATE OR REPLACE FUNCTION SetCompanyAge()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.founded_year IS NOT NULL THEN
        NEW.company_age := EXTRACT(YEAR FROM CURRENT_DATE)::INT - NEW.founded_year;
    ELSE
        NEW.company_age := NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TrgSetCompanyAge
    BEFORE INSERT OR UPDATE OF founded_year ON Company
    FOR EACH ROW
    EXECUTE FUNCTION SetCompanyAge();


-- Trigger 2: basically buat jaga konsistensi spesialisasi ISA (disjoint)
-- Saat baris dimasukkan ke salah satu subtipe, ensuring status Company cocok dengan subtipe tsb
-- canceling, e.g., company berstatus 'Active' masuk ke PublicCompany.
CREATE OR REPLACE FUNCTION CheckSubtypeStatus()
RETURNS TRIGGER AS $$
DECLARE
    ExpectedStatus VARCHAR(20);
    ActualStatus VARCHAR(20);
BEGIN
    ExpectedStatus := CASE TG_TABLE_NAME
        WHEN 'activecompany' THEN 'Active'
        WHEN 'acquiredcompany' THEN 'Acquired'
        WHEN 'publiccompany' THEN 'Public'
        WHEN 'inactivecompany' THEN 'Inactive'
    END;

    SELECT s.status_name INTO ActualStatus
    FROM Company c JOIN CompanyStatus s ON c.status_id = s.status_id
    WHERE c.slug = NEW.slug;

    IF ActualStatus IS DISTINCT FROM ExpectedStatus THEN
        RAISE EXCEPTION 'Company % berstatus % tidak boleh masuk subtipe % (butuh %)',
            NEW.slug, ActualStatus, TG_TABLE_NAME, ExpectedStatus;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TrgCheckActive BEFORE INSERT OR UPDATE ON ActiveCompany
    FOR EACH ROW EXECUTE FUNCTION CheckSubtypeStatus();
CREATE TRIGGER TrgCheckAcquired BEFORE INSERT OR UPDATE ON AcquiredCompany
    FOR EACH ROW EXECUTE FUNCTION CheckSubtypeStatus();
CREATE TRIGGER TrgCheckPublic BEFORE INSERT OR UPDATE ON PublicCompany
    FOR EACH ROW EXECUTE FUNCTION CheckSubtypeStatus();
CREATE TRIGGER TrgCheckInactive BEFORE INSERT OR UPDATE ON InactiveCompany
    FOR EACH ROW EXECUTE FUNCTION CheckSubtypeStatus();
