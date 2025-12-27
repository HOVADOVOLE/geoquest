# GeoQuest Development Roadmap 2.0 🌍

Tento dokument slouží jako komplexní plán pro transformaci MVP na plnohodnotnou hru.

## ✅ Hotovo (MVP)
- [x] **Fáze 1-4:** Architektura, Data (API/Hive), Základní UI, Lokalizace.
- [x] **Fáze 5:** Základní gamifikace (Timer, Konfety, Haptika).
- [x] **Leaderboard:** Základní lokální žebříček.

---

## 🚀 Fáze 6: Redesign & UX (Priorita)
Cíl: Zbavit se "prototypového" vzhledu, opravit Dark Mode a zavést profesionální navigaci.
- [x] **6.1 Oprava Dark Mode**
    - [x] Správná konfigurace `ShadTheme` pro světlý/tmavý režim (definice barev).
    - [x] Ověření přepínání v celé aplikaci.
- [ ] **6.2 Hlavní Navigace**
    - [ ] Implementace **BottomNavigationBar** (Domů, Encyklopedie, Profil).
    - [ ] Odstranění starého "Card Menu" a nahrazení Dashboardem.
- [ ] **6.3 Dashboard (Home)**
    - [ ] Mřížka s výběrem herních módů (ne jen jedno tlačítko "Start").
    - [ ] Zobrazení aktuálního Levelu a XP (zatím dummy data).

## 💾 Fáze 7: Rozšíření Dat
Cíl: Připravit data pro nové herní módy a encyklopedii.
- [x] **7.1 Update Modelu Country**
    - [x] Přidat pole: `capital` (hlavní města), `population`, `continents`, `maps` (google maps link).
    - [x] Migrace/Reset Hive databáze (vynucení nového stažení dat).
- [x] **7.2 Logika pro Filtrování**
    - [x] Metody v repozitáři pro filtrování podle kontinentů.

## 🎮 Fáze 8: Pokročilé Herní Módy
Cíl: Variabilita hratelnosti.
- [ ] **8.1 Refactoring GameController**
    - [ ] Zavedení `QuizType` (FlagToName, NameToFlag, CapitalToName).
    - [ ] Zavedení `QuizFilter` (Region: World, Europe, Asia...).
- [x] **8.2 Implementace Módů**
    - [x] **Capital City Quiz:** "Jaké je hlavní město Francie?"
    - [x] **Reverse Quiz:** "Vyber vlajku pro Japonsko" (4 obrázky jako možnosti).
    - [x] **Region Selection:** UI pro výběr oblasti před hrou.

## 📈 Fáze 9: RPG Systém & Progrese
Cíl: Motivace hráče (Meta-game).
- [ ] **9.1 User Profile Model**
    - [ ] Ukládání: Total XP, Current Level, Games Played, Streak.
- [ ] **9.2 Leveling Logic**
    - [ ] Výpočet XP za hru (správná odpověď = body, rychlost = bonus).
    - [ ] Progress bar s levelem na hlavní stránce.
- [ ] **9.3 Statistiky**
    - [ ] Graf úspěšnosti podle regionů (Koláčový graf).

## 🏆 Fáze 10: Achievementy
Cíl: Dlouhodobé cíle.
- [x] **10.1 Systém Achievementů**
    - [x] Definice seznamu (např. "První krev", "Sniper", "Maratonec").
    - [x] Logika pro odemykání (Observer pattern nad GameSession).
- [x] **10.2 UI Achievementů**
    - [x] Obrazovka v profilu (zamčené/odemčené ikony).
    - [x] Notifikace (Toast/Overlay) při získání během hry.

## 📚 Fáze 11: Encyklopedie (Geo-Atlas)
Cíl: Vzdělávací hodnota.
- [x] **11.1 Seznam zemí**
    - [x] Vyhledávací lišta (Search).
    - [x] Seskupení podle abecedy nebo kontinentů.
- [x] **11.2 Detail Země**
    - [x] Velká vlajka, Hlavní město, Populace, Mapa.
    - [x] Odkaz "Zobrazit na mapě".

---
*Aktualizováno: 31. ledna 2026*