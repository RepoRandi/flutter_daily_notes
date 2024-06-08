# Daily Notes App

## Cara Menjalankan Aplikasi

1. Pastikan Flutter telah terinstal di mesin Anda.
2. Clone repository ini:

    ```bash
    git clone https://github.com/RepoRandi/flutter_daily_notes
    cd daily_notes_app
    ```

3. Install dependensi:

    ```bash
    flutter pub get
    ```

4. Jalankan aplikasi:

    ```bash
    flutter run
    ```

## Struktur Proyek

- `data`: Menyimpan data layer, termasuk model, datasource, dan implementasi repository.
- `domain`: Menyimpan domain layer, termasuk entities, usecases, dan repository interface.
- `presentation`: Menyimpan presentation layer, termasuk bloc, pages, dan widgets.
- `main.dart`: Entry point aplikasi.
