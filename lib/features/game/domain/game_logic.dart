import 'dart:math';
import 'country.dart';
import 'quiz_config.dart';

/// Třída obsahující čistou herní logiku (generování otázek, výběr možností).
///
/// **Účel:**
/// Odděluje algoritmickou část hry od správy stavu (Controller).
class GameLogic {
  final Random _random = Random();

  /// Vygeneruje sadu otázek pro hru.
  ///
  /// **Co dělá:**
  /// Zamíchá vstupní seznam zemí a vybere požadovaný počet otázek.
  /// Předpokládá, že vstupní seznam `availableCountries` je již vyfiltrovaný podle regionu.
  ///
  /// **Vstupní parametry:**
  /// - `availableCountries`: Seznam zemí, ze kterých se má vybírat.
  /// - `config`: Konfigurace kvízu (určuje počet otázek).
  ///
  /// **Výstupní parametry:**
  /// - `List<Country>`: Seznam vybraných otázek (cílových zemí).
  List<Country> generateQuestions(List<Country> availableCountries, QuizConfig config) {
    // Pokud máme méně zemí než je požadovaný počet otázek, použijeme všechny dostupné.
    // (To se může stát u malých regionů nebo při testování).
    final count = min(config.questionCount, availableCountries.length);

    // Vytvoříme kopii seznamu, abychom neovlivnili původní data, a zamícháme ji.
    final shuffled = List<Country>.from(availableCountries)..shuffle(_random);
    
    return shuffled.take(count).toList();
  }

  /// Vybere možnosti odpovědí (1 správná + 3 špatné) pro danou otázku.
  ///
  /// **Co dělá:**
  /// Ze seznamu `pool` vybere 3 náhodné země, které nejsou cílovou zemí (`target`).
  /// Vrátí zamíchaný seznam 4 možností.
  ///
  /// **Vstupní parametry:**
  /// - `pool`: Seznam zemí, ze kterých se vybírají "decoys" (špatné odpovědi).
  /// - `target`: Správná odpověď.
  /// - `type`: Typ kvízu (zatím nevyužito pro výběr, ale připraveno).
  List<Country> getOptions(List<Country> pool, Country target, QuizType type) {
    // Decoys (klamné možnosti) vybíráme ze stejného poolu (např. regionu).
    final decoys = pool.where((c) => c.cca3 != target.cca3).toList();
    decoys.shuffle(_random);
    
    // Vezmeme 3, nebo méně pokud jich není dost
    final count = min(3, decoys.length);
    final options = [target, ...decoys.take(count)];
    
    options.shuffle(_random);
    return options;
  }
}