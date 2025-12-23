import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';
import '../../../core/api/api_client.dart';
import '../../../core/database/hive_service.dart';
import '../domain/country.dart';
import '../domain/quiz_config.dart';

part 'countries_repository.g.dart';

/// Repozitář pro získávání dat o zemích z API s podporou lokální cache.
///
/// **Účel:**
/// Zajišťuje stahování dat z REST Countries API, jejich ukládání do Hive databáze
/// a poskytuje metody pro získání všech zemí nebo filtrování podle regionu.
@riverpod
class CountriesRepository extends _$CountriesRepository {
  @override
  Future<List<Country>> build() async {
    return getCountries();
  }

  /// Získá seznam všech zemí.
  ///
  /// **Co dělá:**
  /// 1. Zkontroluje Hive cache. Pokud obsahuje data, vrátí je.
  /// 2. Pokud je cache prázdná, stáhne data z API.
  /// 3. Uloží nová data do cache a vrátí je.
  Future<List<Country>> getCountries() async {
    final box = Hive.box<Country>(HiveService.countriesBoxName);
    
    if (box.isNotEmpty) {
      return box.values.toList();
    }

    final countries = await fetchCountries();
    
    // Uložení do cache
    await box.clear();
    await box.addAll(countries);
    
    return countries;
  }

  /// Získá seznam zemí filtrovaný podle regionu.
  ///
  /// **Vstupní parametry:**
  /// - `region`: Enum `QuizRegion` (např. Europe, Asia).
  ///
  /// **Interní logika:**
  /// Načte všechny země (z cache nebo API) a vyfiltruje je podle pole `region`.
  /// Porovnání je case-insensitive.
  Future<List<Country>> getCountriesByRegion(QuizRegion region) async {
    final allCountries = await getCountries();
    
    if (region == QuizRegion.world) {
      return allCountries;
    }

    final regionName = region.name.toLowerCase();
    // API vrací "Americas", ale enum je "americas". Shoda je ok.
    return allCountries.where((c) => c.region.toLowerCase() == regionName).toList();
  }

  /// Stáhne seznam všech zemí s vyfiltrovanými poli z API.
  ///
  /// **Co dělá:**
  /// Volá `/all` endpoint s parametry `fields` pro minimalizaci přenášených dat.
  ///
  /// **Návratová hodnota:**
  /// Seznam objektů `Country` nebo vyhodí výjimku při chybě.
  Future<List<Country>> fetchCountries() async {
    final dio = ref.watch(dioProvider);
    final response = await dio.get('/all?fields=name,flags,translations,cca3,region,capital,population,continents,maps');
    
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Nepodařilo se načíst data o zemích: ${response.statusCode}');
    }
  }
}
