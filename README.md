# Seleksi Asisten Basis Data 2026

## Author

- **Nama:** Made Branenda Jordhy
- **NIM:** 13524026

## Deskripsi

Topik yang aku ambil adalah data **The Y Combinator Companies Directory**
(`https://www.ycombinator.com/companies`) yang mencakup dimensi batch/cohort, founder,
status perusahaan (Active/Acquired/Public/Inactive), dan industri.

Kenapa topik ini? Aku dari awal tertarik ke dunia start-up, tetapi ketika liat di sheets pemilihan topik/data, ternyata udah pernah diambil, dan karena berbeda substansi dari topik "Startup Unicorn Global" (CB Insights) yang sudah diambil peserta lain, dengan demikian aku ambil The YC Directory ini. The YC itu portofolio satu accelerator (mayoritas startup early-stage), dengan dimensi batch/founder/status yang memang khas dan ga ada di data ranking valuasi. Jadi walaupun sama-sama soal startup, angle datanya beda.

**Data yang dihasilkan:** 995 company, 2140 founder, 3376 akun social founder, 1713 pairing
company–industry, 90 lokasi unik, 59 industri, dan 37 batch YC.

**DBMS:** PostgreSQL 16. Aku pilih relational (bukan NoSQL) karena datanya memang relasional
banget, e.g., banyak relasi 1:N, M:N, weak entity, dan specialization yang lebih natural
direpresentasikan pakai tabel + FK + constraint. Data di-scrape pakai Playwright (headless
Chromium) karena halaman YC di-render React JS, jadi `curl`/`requests` biasa cuma dapat
shell HTML kosong tanpa isi/konten gitu.

## Cara Menggunakan Scraper & Output-nya

Set up virtual environment venv (macOS ver)

```bash
python -m venv venv
source venv/bin/activate
pip install playwright psycopg[binary]
playwright install chromium
```

Run pipeline ETL (scrape, preprocess, store)

```bash
# Scraping
python "Data Scraping/src/ScrapeList.py" #daftar company
python "Data Scraping/src/ScrapeDetail.py" #enrich tiap /companies/{slug}
python "Data Scraping/src/Preprocess.py" #cleaning/parsing

# Storing
psql -d yc_startup -f "Data Storing/export/Schema.sql"
python "Data Storing/src/StoreData.py"
```

Or run entire pipeline langsung(ini udh support **AUTOMATED SCHEDULING**)

```bash
python "Data Storing/src/RunScheduledScrape.py"
```

**Cara pakai output-nya:** hasil akhir scraping adalah 6 file JSON entities di
`Data Scraping/data/`. `StoreData.py` read 6 files itu lalu di-upsert ke PostgreSQL
sesuai schema di `Data Storing/export/Schema.sql`. Setelah storing, data siap di-query lewat
`psql` atau tool RDBMS lain.

**Catatan teknis scraper:**
- `ScrapeDetail.py` resume-able yg artinya checkpoint tiap 25 slug, jadi kalau run kepotong bisa
  dilanjut tanpa strat dari nol
- Ethics `robots.txt` YC disallows `/companies?*` (URL berquery). Aku cuma scrape `/companies`
  (list) dan `/companies/{slug}` (detail), keduanya diizinkan. buktinya udh aku taruh di
  `Data Scraping/src/Check.py` dan `Data Scraping/src/robots.txt`.

## Struktur File JSON

Semua ada di `Data Scraping/data/`. Data dipisah per entities sbg berikut.

| File | Jumlah | Isi / kolom kunci |
|---|---|---|
| `companies.json` | 995 | slug (PK), name, one_liner, long_description, website, status, team_size, founded_year, company_age (derived), batch_id, city/state/country |
| `batches.json` | 37 | batch_id (PK, mis. `Sp26`), season, year — cohort YC |
| `industries.json` | 59 | industry_id, name |
| `company_industries.json` | 1713 | company_slug + industry_id — pasangan M:N |
| `founders.json` | 2140 | founder_id, company_slug, name — 1:N dari company |
| `founder_socials.json` | 3376 | founder_id, platform, url — akun social (entitas lemah) |

`RawCompanies.json` (hasil `ScrapeList.py`) dan `RawDetails.json` (hasil `ScrapeDetail.py`)
adalah raw data sebelum di-`Preprocess.py`. Preprocessing melakukan cleaning
(whitespace/karakter), parsing (batch `"SPRING 2026"`->season+year, lokasi
`"San Francisco, CA, USA"` -> city/state/country), transformasi (`team_size` string → int),
derive `company_age` dari `founded_year`, dan deteksi platform social dari domain url.

## Struktur ERD & Diagram Relasional

Gambar ada di folder `Data Storing/design/`:

- **ERD (konseptual):** `Data Storing/design/ERD - 13524026 - The Y Combinator Companies Directory.png`
- **Diagram Relasional:** `Data Storing/design/Relational Model - 13524026 - The Y Combinator Companies Directory.png`

**Konstruk ERD yang dipakai:**
- **Strong entity + PK**  Company, Batch, Industry, Founder, dll.
- **1:N** — Company → Founder (parsial di sisi Company: ada 41 company tanpa founder di data).
- **M:N + tabel penghubung** — Company ↔ Industry lewat CompanyIndustry.
- **Weak entity** — FounderSocial, diidentifikasi oleh Founder + url sebagai discriminator
  (sumber YC ga kasih ID global untuk akun social).
- **Composite attribute** — lokasi (city/state/country), batch (season/year).
- **Derived attribute** — `company_age` (dihitung dari `founded_year`, diisi trigger).
- **Specialization / ISA** disjoint + total — Company → Active/Acquired/Public/Inactive
  berdasar status.
- **Aggregation** — Investment: relasi Company–FundingRound dibungkus, lalu direlasikan ke
  Investor.
- **Rekursif (unary)** — Acquisition: Company mengakuisisi Company, dengan role
  acquirer/acquired.

### Alasan dan keputusan desain ERD

- **Location, Batch, CompanyStatus dipisah jadi entity** (bukan kolom di Company). Location
  karena ada repetisi tinggi (90 kombinasi unik untuk ~960 company; San Francisco muncul
  ratusan kali) → dinormalisasi biar ga duplikat. Company → Location **parsial**, karena 35
  company tidak punya city (NULL) saat scraping. Status jadi entity `CompanyStatus` (bukan
  enum) karena dipakai sebagai diskriminator ISA shg perlu jadi entity supaya bisa direferensi
  FK dan jadi basis kondisi specialization.
- **Company ↔ Industry = M:N.** Satu company bisa punya >1 industri dan satu industri jelas
  dipakai banyak company. Karena kedua sisi "banyak", industri ga bisa jadi kolom shg harus
  tabel penghubung.
- **Founder = 1:N, FounderSocial = weak entity.** Satu company punya banyak founder (parsial:
  sebagian company ga punya founder di data or NULL). FounderSocial weak karena identitasnya baru
  meaningful kalau nempel ke founder pemiliknya. `platform` = derived (bisa dihitung dari
  domain url, FD `url -> platform`), jadi aku simpan.
- **ISA/specialization** dipakai karena tiap subtype punya atribut lokal yang cuma relevan
  untuk sebagian company (e.g., `acquisition_date` cuma untuk AcquiredCompany).
- **Aggregation, bukan ternary Company-Round-Investor.** Investasi lebih cocok nempel ke
  relasi Company–FundingRound, bukan ke Company langsung. Satu funding round itu event antara
  company dan ≥1 investor, while investor mendanai round tertentu yang udh terikat ke company,
  bukan mendanai company abstrak. Kalau Investor -> Company langsung, info "round berapa"
  hilang dan jadiny ambigu sih.
- **Acquisition = rekursif** karena acquirer dan acquired sama-sama Company. Dari scraping ada
  company berstatus Acquired, tapi *siapa mengakuisisi siapa* ga tersedia di source shg
  tabelnya kosong. Role acquirer/acquired tetap aku buat biar arah akuisisi ga ambigu.
- **ScrapeSession** , ya ini entities utility buat mencatat scraping session.

## Proses Translasi ERD -> Diagram Relasional

Translasi dilakukan melalui 3 fase sebagai berikut.

**Fase 1: ERD konseptual.** Cuma entity + relationship, **tanpa FK sama sekali**, dan beberpa konstruk seperti Agregation/ISA/weak entity, dll yang sudah aku sebutkan di atas.

**Fase 2: Normalisasi sampai BCNF.** Tiap kandidat relasi dicek functional dependency (FD)-nya,
lalu diperiksa apakah tiap determinan adalah superkey atau ga.

- **Tingkat normalisasi tertinggi yang dicapai: 13 dari 14 tabel adalah BCNF penuh.**
- Satu-satunya penyimpangan adalah tabel **Company**, yang berhenti di bawah 3NF secara
  sengaja karena ada FD yg derived `founded_year -> company_age`. `company_age` sebetulnya derived
  dan bisa dihilangkan, tapi aku pertahankan sebagai kolom yang diisi **trigger**,
  keputusan ini sebetulny demi memenuhi kewajiban implementasi trigger, dan valuenya selalu konsisten
  karena dijaga trigger (bukan anomali data beneran).
- **FounderSocial** awalnya melanggar BCNF karena FD `url -> platform` (`url` bukan superkey).
  Diperbaiki dengan membuang kolom `platform` dari tabel shg tabel jadi BCNF, dan value
  platform jadinya lewat VIEW `FounderSocialView` yang menghitung dari domain url.

**Fase 3: Reduksi ke relational.** Aturan reduksi yang aku pakai:

- **1:N / N:1** → FK di sisi "banyak". Makanya `batch_id`, `location_id`, `status_id`,
  `session_id` semua jadi kolom FK di **Company**.
- **M:N** → tabel penghubung baru dengan PK gabungan. `CompanyIndustry(company_slug,
  industry_id)`.
- **Weak entity** → PK = PK entity pengidentifikasi + discriminator. `FounderSocial(founder_id,
  url)`.
- **ISA** → **Method 1**: tabel superclass (Company) + tabel per-subclass (ActiveCompany dst),
  PK subclass = slug (sekaligus FK ke Company). Dipilih Method 1 karena kalau digabung satu
  tabel, mayoritas rows jadi NULL (933 Active ga punya ticker/ipo_date/acquisition_date).
- **Aggregation & rekursif**: tabel relatio dengan FK ke tiap peserta. `Investment(round_id,
  investor_id)`, `Acquisition(acquirer_slug, acquired_slug)`.

### Keputusan teknis saat reduksi (yang baru muncul di implementasi)

- **Arah FK & nullability.** Semua FK 1:N nempel di sisi banyak (Company). Nullability
  disamakan dengan kenyataan data: `location_id` & `session_id` boleh NULL (ada company tanpa
  lokasi; company bisa ada sebelum sesi pertama), `status_id` NOT NULL (tiap company pasti
  punya status), `batch_id` dibiarkan nullable (walau cuma 1 company kosong) biar ga maksa.
- **Location pakai SERIAL, Batch pakai string PK.** `location_id` SERIAL (surrogate) karena PK
  natural-nya (city, state, country) panjang dan sebagian NULL. `batch_id` pakai string
  (`Sp26`) langsung karena udah pendek, natural, dan stabil.
- **Location UNIQUE pakai COALESCE.** Baru ketahuan saat implementasi: `UNIQUE(city, state,
  country)` biasa ga nge-dedup baris ber-NULL (di SQL, NULL ≠ NULL), jadi tiap re-scrape malah
  nambah duplikat (sempat kejadian 90 → 106 baris). Diperbaiki dengan UNIQUE INDEX
  `COALESCE(state,'')` / `COALESCE(country,'')`.
- **PK komposit CompanyIndustry** `(company_slug, industry_id)`ini bukan surrogate id karena
  yang harus unik memang pasangannya. komposit bs langsung menjaga itu.
- **Industry & Founder di-resolve by natural key saat upsert.** `industry_id` & `founder_id`
  dibikin SERIAL, tapi upsert-nya match by `name` (Industry) / `(company_slug, name)`
  (Founder), karena ID dari JSON di-assign ulang tiap run `Preprocess.py` → ga stabil.

## Screenshot

Bukti penyimpanan data ke RDBMS query `SELECT ... FROM ... WHERE ...` (screenshot ada di
`Data Storing/screenshot/`). File query lengkap di `Data Storing/screenshot/queries.sql`.

### 1. Company pada batch tertentu + status (FK Company->Batch, JOIN CompanyStatus)

```sql
SELECT c.slug, c.name, s.status_name, c.team_size
FROM Company c
JOIN CompanyStatus s ON c.status_id = s.status_id
WHERE c.batch_id = 'Wi26'
ORDER BY c.name
LIMIT 10;
```

![Query 1](Data%20Storing/screenshot/1.png)

### 2. Company di kota tertentu (JOIN Company x Location, FK location_id)

```sql
SELECT c.slug, c.name, l.city, l.state, l.country
FROM Company c
JOIN Location l ON c.location_id = l.location_id
WHERE l.city = 'San Francisco'
LIMIT 10;
```

![Query 2](Data%20Storing/screenshot/2.png)

### 3. Derived attribute company_age (kolom yang diisi trigger)

```sql
SELECT slug, name, founded_year, company_age
FROM Company
WHERE company_age IS NOT NULL AND founded_year < 2015
ORDER BY founded_year
LIMIT 10;
```

![Query 3](Data%20Storing/screenshot/3.png)

### 4. M:N Company <-> Industry pada industri tertentu (via CompanyIndustry)

```sql
SELECT c.name AS company, i.name AS industry
FROM Company c
JOIN CompanyIndustry ci ON c.slug = ci.company_slug
JOIN Industry i ON ci.industry_id = i.industry_id
WHERE i.name = 'Analytics'
LIMIT 10;
```

![Query 4](Data%20Storing/screenshot/4.png)

### 5. ISA subtype company yang berstatus Public (via tabel PublicCompany)

```sql
SELECT c.name, s.status_name
FROM Company c
JOIN PublicCompany p ON c.slug = p.slug
JOIN CompanyStatus s ON c.status_id = s.status_id
WHERE s.status_name = 'Public'
LIMIT 10;
```

![Query 5](Data%20Storing/screenshot/5.png)

### 6. Weak entity FounderSocial + VIEW platform (derived dari url)

```sql
SELECT f.name AS founder, v.platform, v.url
FROM Founder f
JOIN FounderSocialView v ON f.founder_id = v.founder_id
WHERE v.platform = 'GitHub'
LIMIT 10;
```

![Query 6](Data%20Storing/screenshot/6.png)

### 7. Bukti scheduling: Company linked ke ScrapeSession

```sql
SELECT ss.session_id, ss.started_at, ss.session_number, COUNT(c.slug) AS company_count
FROM ScrapeSession ss
JOIN Company c ON c.session_id = ss.session_id
WHERE ss.session_number = 1
GROUP BY ss.session_id, ss.started_at, ss.session_number;
```

![Query 7](Data%20Storing/screenshot/7.png)

## Bonus 2: Automated Scheduling

**Tujuan:** proses ETL (scrape, preprocess, store) bisa dijalankan berkala tanpa
menghasilkan data duplicates di database.

### Mekanisme

`Data Storing/src/RunScheduledScrape.py` run the entire pipeline berurutan
(`ScrapeList.py` → `ScrapeDetail.py` → `Preprocess.py` → `StoreData.py`), dan berhenti kalau
ada tahap yang gagal. Script ini didaftarkan ke **cron** (Linux) / **launchd** (macOS) supaya
jalan otomatis tiap interval tertentu.

Contoh entri crontab (jalan tiap hari jam 03:00, sesuaikan path venv & repo):

```cron
0 3 * * * cd "TUGAS_SELEKSI_1_13524026/Data Storing/src" && \
  TUGAS_SELEKSI_1_13524026/venv/bin/python -u RunScheduledScrape.py >> \
  TUGAS_SELEKSI_1_13524026/scheduled_run.log 2>&1
```

Daftarkan dengan `crontab -e`, tempel baris di atas (path disesuaikan), save. Cek jadwal
aktif dengan `crontab -l`.

### Mencegah redundansi data

`StoreData.py` melakukan **upsert**, bukan `INSERT` mentah, sehingga run kedua/ketiga dst
tidak membuat baris duplikat:

- **Company** — `ON CONFLICT (slug) DO UPDATE` (slug = natural key stabil dari URL YC).
  Subtipe ISA direkonsiliasi manual: kalau status company berubah antar-run (mis. Active →
  Acquired), baris di subtipe lama dihapus, baris baru ditambahkan ke subtipe yang sesuai.
- **Industry** — upsert by `name` (bukan `industry_id` dari JSON, karena ID di-assign ulang
  tiap run).
- **Founder** — di-resolve by `(company_slug, name)`. Founder & FounderSocial milik satu
  company dihapus lalu ditulis ulang tiap run supaya data selalu cerminan run terbaru (ga ada
  baris basi menumpuk kalau founder ganti akun social).
- **Location** — upsert by kombinasi (city, state, country) dengan `COALESCE(..., '')` di
  unique index supaya kombinasi ber-NULL tetap terdeteksi duplikat.

### Bukti: perbedaan timestamp ekstraksi antar-run

Tabel `ScrapeSession` mencatat satu baris per run (`session_id`, `started_at`,
`session_number`). Tiap `Company` menyimpan FK `session_id` yang menunjuk ke sesi **terakhir**
yang meng-upsert baris tersebut.

`StoreData.py` dijalankan tiga kali berturut-turut terhadap data scraping yang sama
(2026-07-23) untuk validasi, hasil `SELECT * FROM ScrapeSession ORDER BY session_id`:

| session_id | started_at | session_number |
|---|---|---|
| 1 | 2026-07-23 18:24:12.201249 | 1 |
| 2 | 2026-07-23 18:41:33.567601 | 2 |
| 3 | 2026-07-23 18:41:34.079196 | 3 |

Setelah run ke-3, seluruh 995 baris Company menunjuk `session_id = 3` (run terbaru) —
`SELECT session_id, COUNT(*) FROM Company GROUP BY session_id` mengembalikan `3 | 995`, tanpa
ada baris nyangkut di sesi lama. Row count tabel data (Company 995, Founder 2140,
FounderSocial 3376, CompanyIndustry 1713, Location 90, Industry 59, Batch 37) **identik** di
ketiga run — bukti tidak ada redundansi meski pipeline dijalankan berulang.

## Referensi

- **Sumber data:** `https://www.ycombinator.com/companies`
- **Library:**
  - Playwright (Python) — headless browser scraping
  - psycopg 3 — PostgreSQL driver
- **RDBMS:** PostgreSQL 16
- **Materi acuan desain ERD:** Silberschatz, *Database System Concepts* 7e
