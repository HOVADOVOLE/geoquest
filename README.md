# GeoQuest 🌍

![Flutter](https://img.shields.io/badge/Flutter-3.19-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.3-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Completed-success)

**Interaktivní edukační platforma pro globální identifikaci geopolitických entit v reálném čase.**

GeoQuest je moderní mobilní hra a encyklopedie postavená na frameworku Flutter. Navržena s důrazem na **offline-first** architekturu, typově bezpečnou lokalizaci a prémiové uživatelské rozhraní inspirované designovým systémem **Shadcn**. Aplikace transformuje surová data z REST Countries API do gamifikovaného ekosystému s RPG prvky (XP systém, levelování, achievementy).

---

## 🚀 Klíčové Funkce

- **Herní Módy:**
  - 🏳️ **Vlajky Světa:** Klasický kvíz poznávání zemí podle vlajek.
  - 🏛️ **Hlavní Města:** Přiřazování hlavních měst k zemím.
  - 🔄 **Obrácený Kvíz:** Výběr vlajky na základě názvu země.
- **Filtrování a Regiony:** Možnost hrát za celý svět nebo specifické kontinenty (Evropa, Asie, Afrika...).
- **Encyklopedie (Atlas):** Prohlížeč všech zemí s vyhledáváním, seskupováním (abeceda/kontinent) a detailními informacemi (populace, mapa).
- **RPG Systém:** Hráč získává zkušenosti (XP), postupuje na vyšší levely a sleduje svůj "Streak" (dny v řadě).
- **Achievementy:** Systém trofejí s notifikacemi (Toast) přímo ve hře.
- **Lokální Žebříček:** Ukládání nejlepších výsledků.
- **Dark Mode:** Plná podpora tmavého režimu.
- **Lokalizace:** Kompletní česká lokalizace (připraveno pro další jazyky díky `slang`).

---

## 🛠️ Technický Stack

Projekt využívá moderní přístupy a knihovny pro zajištění škálovatelnosti a udržitelnosti.

| Kategorie            | Technologie        | Účel                                                      |
| :------------------- | :----------------- | :-------------------------------------------------------- |
| **Framework**        | Flutter & Dart 3.x | Multiplatformní vývoj (Android, iOS).                     |
| **State Management** | **Riverpod**       | Reaktivní správa stavu, DI, AsyncNotifiers.               |
| **Persistence (DB)** | **Hive**           | NoSQL databáze pro bleskové ukládání dat offline.         |
| **API Klient**       | **Dio**            | Robustní HTTP klient pro komunikaci s REST Countries API. |
| **UI Komponenty**    | **shadcn_ui**      | Moderní, přizpůsobitelný designový systém.                |
| **Lokalizace**       | **Slang**          | Typově bezpečná i18n s generováním kódu.                  |
| **Ikony**            | Lucide Icons       | Konzistentní sada vektorových ikon.                       |
| **Animace**          | flutter_animate    | Deklarativní animace UI prvků.                            |

---

## 🏗️ Architektura a Datový Tok

Aplikace sleduje **Feature-first** architekturu s rozdělením na vrstvy (Data, Domain, Presentation).

### Tok Dat (Data Flow)

1.  **API Layer:** `Dio` stáhne data z `restcountries.com` (minimalizovaný payload).
2.  **Repository Layer:** `CountriesRepository` data zpracuje a uloží do lokální **Hive** cache ("Cache-first" strategie). Pokud je zařízení offline, data se načtou z disku.
    - _Filtrace:_ Repozitář poskytuje metody pro filtrování zemí podle regionů.
3.  **Controller Layer (Riverpod):**
    - `GameController`: Řídí stav hry (časovač, skóre, aktuální otázka).
    - `UserProfileController`: Spravuje progres hráče (XP, Level).
    - `AchievementController`: Vyhodnocuje podmínky pro zisk trofejí.
4.  **UI Layer:** Reaktivní widgety (`ConsumerWidget`) naslouchají změnám stavu a překreslují se.

### Adresářová Struktura

```
lib/
├── core/                  # Sdílené moduly (API, DB, Theme, Router)
│   ├── api/               # Konfigurace Dio
│   ├── database/          # Hive adaptéry a inicializace
│   └── theme/             # AppTheme (Shadcn konfigurace)
├── features/              # Hlavní funkční celky
│   ├── encyclopedia/      # Atlas zemí (List, Detail, Filter)
│   ├── game/              # Herní logika
│   │   ├── data/          # CountriesRepository
│   │   ├── domain/        # Modely (Country, GameSession, QuizConfig)
│   │   └── presentation/  # GameScreen, Dashboard, Controllers
│   ├── home/              # Splash, DashboardScreen
│   ├── profile/           # UserProfile, Achievements
│   └── settings/          # Nastavení (Theme, Language)
├── i18n/                  # Lokalizační soubory (.i18n.json) a generovaný kód
└── main.dart              # Vstupní bod aplikace
```

---

## 📥 Instalace a Spuštění

### Prerekvizity

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (verze 3.10+)
- Android Studio / VS Code
- Zařízení nebo emulátor

### Kroky

1.  **Klonování repozitáře:**

    ```bash
    git clone https://github.com/yourusername/geoquest.git
    cd geoquest
    ```

2.  **Instalace závislostí:**

    ```bash
    flutter pub get
    ```

3.  **Generování kódu (volitelné, pokud chybí .g.dart soubory):**

    ```bash
    dart run build_runner build --delete-conflicting-outputs
    dart run slang  # Pro lokalizaci
    ```

4.  **Spuštění:**
    ```bash
    flutter run
    ```

---

## 📱 Sestavení (Build)

### Android (APK / App Bundle)

1.  Ujistěte se, že máte nastavený `key.properties` (pro podepsanou verzi). Pro debug stačí:

    ```bash
    flutter build apk --release
    ```

    Výstup: `build/app/outputs/flutter-apk/app-release.apk`

2.  Pro Google Play (App Bundle):
    ```bash
    flutter build appbundle --release
    ```

### iOS (IPA)

_Vyžaduje macOS a Xcode._

1.  Otevřete `ios/Runner.xcworkspace` v Xcode.
2.  Nastavte Signing & Capabilities (Team).
3.  V terminálu:
    ```bash
    flutter build ipa --release
    ```
    Nebo archivujte přímo přes Xcode (Product -> Archive).

---

## 📄 Licence

Tento projekt je licencován pod licencí MIT - viz soubor [LICENSE](LICENSE) pro detaily.

---
