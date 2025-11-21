# RBook — Website Baca Komik (JSP + MySQL)

Proyek ini adalah contoh aplikasi baca komik berbasis JSP (WAR), dengan fitur CRUD untuk komik, autentikasi pengguna, penyimpanan metadata di MySQL, dan upload gambar halaman komik.

Fitur utama:
- Registrasi dan login pengguna (hash password dengan BCrypt)
- CRUD komik (judul, penulis, deskripsi, cover)
- Upload halaman/cover komik (disimpan di folder `uploads/`, nama file disimpan di DB)
- Halaman membaca yang responsif (Bootstrap)
- Template GitHub Actions + Dockerfile untuk deploy (template Railway)

Persyaratan lingkungan (lokal / Railway):
- JDK 11+
- Maven
- MySQL (atau layanan DB yang kompatibel)
- Railway token / Project ID untuk deploy otomatis (lihat workflow)

ENV yang harus diset sebelum menjalankan:
- `DB_URL` contoh: `jdbc:mysql://host:3306/rbook?useSSL=false&allowPublicKeyRetrieval=true`
- `DB_USER`
- `DB_PASSWORD`
- `UPLOAD_DIR` (opsional, default `uploads` di root aplikasi)

Catatan deployment Railway:
- Railway memiliki filesystem ephemeral; gambar yang diupload ke filesystem aplikasi kemungkinan hilang setelah redeploy. Untuk produksi gunakan object storage (S3) atau simpan halaman di layanan penyimpanan terpisah. Workflow GitHub Actions yang disertakan adalah template; Anda perlu memasukkan secret `RAILWAY_TOKEN` dan `RAILWAY_PROJECT_ID` di repo settings.

Build & run lokal (contoh):
1. Set environment variable seperti `DB_URL`, `DB_USER`, `DB_PASSWORD`.
2. Jalankan `mvn package`.
3. Deploy WAR ke Tomcat lokal atau gunakan plugin yang sesuai.

File penting:
- `pom.xml` — konfigurasi Maven
- `src/main/java` — sumber Java (servlet, DAO, model)
- `src/main/webapp` — JSP dan assets
- `sql/schema.sql` — skema database
- `.github/workflows/railway-deploy.yml` — template CI/CD

Jika ingin saya lanjutkan untuk menambahkan fitur lanjutan (S3, pagination, full-text search), beri tahu saya.
